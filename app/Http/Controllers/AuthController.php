<?php

namespace App\Http\Controllers;

use http\Env\Response;
use Illuminate\Http\Request;
use JWTAuth;
use JWTAuthException;
use App\User;
use Illuminate\Support\Facades\DB;


class AuthController extends Controller
{
    public function store(Request $request)
    {
       $this->validate($request,
           [
               'name'=>'required',
               'email'=>'required',
               'password'=>'required'
           ]);

       $name=$request->input('name');
       $email=$request->input('email');
       $password=$request->input('password');



       $user = new User(
           [
               'name'=>$name,
               'email'=>$email,
               'password'=>bcrypt($password)
           ]
       );

       $credential=
           [
               'email'=>$email,
               'password'=>$password
           ];

       if($user->save())
       {
           $token=null;

           try{
               if(!$token=JWTAuth::attempt($credential))
               {
                   return response()->json(
                       [
                           'msg'=>'Email atau Password Salah'
                       ], 404
                   );
               }
           }
           catch (JWTException $e)
           {
               return response()->json(
                   [
                       'msg'=>'Failed To Create Token'
                   ], 400
               );
           }

           $user->signin=[
               'href'=>'api/v1/user/signin',
               'method'=>'POST',
               'params'=>'email,password'
           ];
           $response=[
               'msg'=>'User Created',
               'user'=>$user,
               'token'=>$token
           ];


           return response()->json($response,201);


       }

        $response=[
            'msg'=>'Error'

        ];

        return response()->json($response,404);


    }

    public function signin(Request $request)
    {
        $this->validate($request,
            [
                'email'=>'required',
                'password'=>'required'
            ]);

        $email=$request->input('email');
        $password=$request->input('password');

        if($user= User::where('email',$email)->first())
        {
            $credintial=[
                'email'=>$email,
                'password'=>$password
            ];

            $token=null;

            try{
                if(!$token=JWTAuth::attempt($credintial))
                {
                    return response()->json(
                        [
                            'msg'=>'Email atau Password Salah'
                        ], 404
                    );
                }
            }
            catch (JWTException $e)
            {
                return response()->json(
                    [
                        'msg'=>'Failed To Create Token'
                    ], 400
                );
            }

            $response=[
              'msg'=>'User Sign',
                'user'=>$user,
                'token'=>$token
            ];

//            Update Remember token pada tabel user
            $affected = DB::table('users')
                ->where('email', $email)
                ->update(['remember_token' => $token]);

            return response()->json($response,201);

        }

        $response=[
            'msg'=>'Error'

        ];

        return response()->json($response,404);
    }

}
