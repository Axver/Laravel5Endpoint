<?php

namespace App\Http\Controllers;

use App\Mail\ForgotEmail;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

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
        $CheckProfile = User::where('email', '=', $email)->first();
        if(!$CheckProfile)
        {
            return response()->json(
                [
                    'msg'=>'Email Tidak Terdaftar'
                ], 400
            );
        }

//        send email to user
        $code=rand(1000,9999);
        Mail::to($email)->send(new ForgotEmail($code,$email));
//        Simpan kode kedalam database
        return $code;

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
