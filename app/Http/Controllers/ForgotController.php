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

        if (Cache::has('token')) {
//            Masih belum 3 menit
            $value = Cache::get('key');
            $token = Cache::get('token');
            Mail::to($email)->send(new ForgotEmail($value,$email));

            $response=[
                'status'=>'success',
                'message'=>'Resend Verification Code',
                'token'=>$token

            ];
        }
        else
        {
//            Delete all token data
            DB::table('password_resets')->where('email', $email)->delete();
//        send email to user
            $code=rand(100000,999999);
            Mail::to($email)->send(new ForgotEmail($code,$email));
//        Simpan kode kedalam database
            DB::table('password_resets')->insert(
                ['email' => $email, 'token' => $code]
            );

            $token=md5(uniqid(rand(), true));

            $expiresAt = Carbon::now()->addMinutes(3);
            Cache::put('key', $code, $expiresAt);
            Cache::put('token', $token, $expiresAt);
            $value = Cache::get('key');
            $response=[
                'status'=>'success',
                'message'=>'Adding New Verification Code',
                'token'=>$token
            ];

        }


        return $response;

    }

    public function getcode()
    {
//        Mendapatkan kode yang diinputkan oleh user

    }

    public function newpassword()
    {
//        ubah password user

    }
}
