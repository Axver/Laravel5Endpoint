<?php

namespace App\Http\Controllers;

use App\Mail\ForgotEmail;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Cache;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use JWTAuth;
use JWTAuthException;

class ForgotController extends Controller
{

    public function sendmail(Request $request)
    {
//        Mengirimkan email berisi kode
        $this->validate($request,
            [
                'email'=>'required',
            ]);
        $email=$request->input('email');
        $credential=
            [
                'email'=>$email

            ];

        $CheckProfile = User::where('email', '=', $email)->first();
        if(!$CheckProfile)
        {
            return response()->json(
                [
                    'msg'=>'Email Tidak Terdaftar'
                ], 400
            );
        }

        if (Cache::has($email)) {
//            Masih belum 3 menit
            $value = Cache::get('key');
//            $token = Cache::get($email);
            Mail::to($email)->send(new ForgotEmail($value,$email));

            $response=[
                'status'=>'success',
                'message'=>'Resend Verification Code',
                'token'=>Cache::get($email)

            ];
        }
        else
        {
            $token=md5(uniqid(rand(), true));
            $expiresAt = Carbon::now()->addMinutes(3);
            Cache::put($token, $token, $expiresAt);
            Cache::put($email, $email, $expiresAt);
//            Delete all token data
            DB::table('password_resets')->where('email', $email)->delete();
//        send email to user
            $code=rand(100000,999999);
            Mail::to($email)->send(new ForgotEmail($code,$email));
//        Simpan kode kedalam database
            DB::table('password_resets')->insert(
                ['email' => $email, 'token' => $code]
            );



            $expiresAt = Carbon::now()->addMinutes(3);
            Cache::put($token, $token, $expiresAt);
            $value = Cache::get('key');
            $response=[
                'status'=>'success',
                'message'=>'Adding New Verification Code',
                'token'=>$token
            ];

        }


        return $response;

    }

    public function getcode(Request $request)
    {
//        Mendapatkan kode yang diinputkan oleh user

        //        ubah password user
        $this->validate($request,
            [
                'code'=>'required',
                'token'=>'required'
            ]);
        $code=$request->input('code');
        $user_token=$request->input('token');
//        Check token


        if (Cache::has($user_token)) {
            $token = Cache::get($user_token);

//        Tambahkan waktu 3 menit untuk memasukkan token dalam chace
            $expiresAt = Carbon::now()->addMinutes(3);
            Cache::put($user_token, $token, $expiresAt);

            if($kode=$user = DB::table('password_resets')->where('token', $code)->first()){
//                Jika kode benar-benar ada kirimkan kode ke user
                $kode=$kode->token;
                $response=[
                    'status'=>'success',
                    'message'=>'Token dan Kode Diverifikasi',
                    'token'=>$token,
                    'kode'=>$kode
                ];


            }
            else
            {
                $response=[
                    'status'=>'error',
                    'message'=>'Kode Verifikasi Salah',

                ];
            }









        }
        else
        {
            $response=[
                'status'=>'error',
                'message'=>'Token Salah',

            ];
        }

        return $response;

    }

    public function newpassword(Request $request)
    {
        $this->validate($request,
            [
                'password'=>'required',
                'token'=>'required',
                'code'=>'required'
            ]);




//        Proses untuk mengubah password lama
        $new_password=$request->input('password');
        $token=$request->input('token');
        $code=$request->input('code');

        //        Periksa apakah token baru sama atau tidak

        if(Cache::has($token))
        {
            //        periksa email yang disimpan di db sesuai dengan nomor code

            $info = DB::table('password_resets')->select('email')->where('token', $code)->first();

            if($info)
            {
                $email=$info->email;
//        Ubah password data lama
                $affected = DB::table('users')
                    ->where('email', $email)
                    ->update(['password' => bcrypt($new_password)]);
//        Hapus data lama dari password reset
                DB::table('password_resets')->where('email', $email)->delete();

                if(!$affected)
                {
                    $response=[
                        'status'=>'error',
                        'message'=>'Gagal Mengubah Password',
                    ];
                }
                else
                {
                    $response=[
                        'status'=>'success',
                        'message'=>'Password Berhasil Diubah',
                    ];
                }
            }
            else
            {
                $response=[
                    'status'=>'error',
                    'message'=>'Kode Verifikasi Belum Direquest',
                ];
            }
        }



        return $response;


    }
}
