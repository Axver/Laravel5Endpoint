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
                    'data'=>null,
                    'errors'=>[
                        'code'=>1,
                        'msg'=>'Email not registered yet'

                    ]

                ], 400
            );
        }

        if (Cache::has($email)) {
//            Masih belum 3 menit
            $data_e=Cache::get($email);
            $value = DB::table('password_resets')->select('email', 'token')
                ->where('email',$data_e)->first();
            $value=$value->token;
//            $token = Cache::get($email);
            Mail::to($email)->send(new ForgotEmail($value,$email));

            return response()->json(
                [
                    'status'=>'success',
                    'data'=>[
                            'code'=>0,
                            'token'=>Cache::get($email.'_'),
                            'msg'=>'Resend Verification Code',
                    ]

                ], 200
            );

        }
        else
        {
            $token=md5(uniqid(rand(), true));
            $expiresAt = Carbon::now()->addMinutes(5);
            Cache::put($token, $token, $expiresAt);
            Cache::put($email, $email, $expiresAt);
            Cache::put($email.'_', $token, $expiresAt);
            Cache::put($token.'_', $email, $expiresAt);
//            Delete all token data
            DB::table('password_resets')->where('email', $email)->delete();
//        send email to user
            $code=rand(100000,999999);
            Mail::to($email)->send(new ForgotEmail($code,$email));
//        Simpan kode kedalam database
            DB::table('password_resets')->insert(
                ['email' => $email, 'token' => $code]
            );



            $expiresAt = Carbon::now()->addMinutes(5);
            Cache::put($token, $token, $expiresAt);
            $value = Cache::get('key');

            return response()->json(
                [
                    'status'=>'success',
                    'data'=>[
                        'code'=>0,
                        'token'=>$token,
                        'msg'=>'Verification Code Has Been Send',
                    ]

                ], 200
            );



        }




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
            $expiresAt = Carbon::now()->addMinutes(5);
            Cache::put($user_token, $token, $expiresAt);

            if($kode=$user = DB::table('password_resets')->where('token', $code)->first()){
//                Jika kode benar-benar ada kirimkan kode ke user
//                Forget Redis
                Cache::forget($user_token);
                $email=$value = Cache::get($user_token.'_');
                Cache::forget($user_token.'_');
                Cache::forget($email);
                Cache::forget($email.'_');

                $token=md5(uniqid(rand(), true));

//                Create New Token
                $expiresAt = Carbon::now()->addMinutes(5);
                Cache::put($token, $code, $expiresAt);

//                $kode=$kode->token;

                return response()->json(
                    [
                        'status'=>'success',
                        'data'=>[
                            'code'=>0,
                            'new_token'=>$token,
                            'msg'=>'Token and code verified',
                        ]

                    ], 200
                );


            }
            else
            {
                return response()->json(
                    [
                        'data'=>null,
                        'errors'=>[
                            'code'=>1,
                            'msg'=>'Wrong Verification Code',
                        ]

                    ], 404
                );

            }

        }
        else
        {
            return response()->json(
                [
                    'data'=>null,
                    'errors'=>[
                        'code'=>2,
                        'msg'=>'Wrong Token Code',
                    ]

                ], 404
            );



        }



    }

    public function newpassword(Request $request)
    {
        $this->validate($request,
            [
                'password'=>'required',
                'token'=>'required',
            ]);




//        Proses untuk mengubah password lama
        $new_password=$request->input('password');
        $token=$request->input('token');
        $code=Cache::get($token);

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
                    return response()->json(
                        [
                            'data'=>null,
                            'errors'=>[
                                'code'=>1,
                                'msg'=>'Filed To Update Database',
                            ]

                        ], 404
                    );

                }
                else
                {
                    return response()->json(
                        [
                            'status'=>'success',
                            'data'=>[
                                'code'=>0,
                                'msg'=>'Password Updated',
                            ]

                        ], 201
                    );

                }
                Cache::forget($token);
            }
            else
            {
                return response()->json(
                    [
                        'data'=>null,
                        'errors'=>[
                            'code'=>2,
                            'msg'=>'Verification Code Not Found In Database',
                        ]

                    ], 404
                );
            }
        }
        else
        {
            return response()->json(
                [
                    'data'=>null,
                    'errors'=>[
                        'code'=>3,
                        'msg'=>'Token Not Match',
                    ]

                ], 404
            );
        }



        return $response;


    }
}
