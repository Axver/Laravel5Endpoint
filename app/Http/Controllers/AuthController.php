<?php

namespace App\Http\Controllers;

use http\Env\Response;
use Illuminate\Http\Request;
use JWTAuth;
use JWTAuthException;
use App\User;
use Illuminate\Support\Facades\DB;
use App\Exceptions;
use App\Helpers\Result;
use Illuminate\Contracts\Validation\Validator;

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

        $user = User::where('email',$email)->first();

        if($user){
            return response()->json(Result::failed("email.found", "Email is already registered"), 200);
        }
        else
        {
            if($user->save())
            {
                try{
                    $access_token = JWTAuth::fromUser($user);
                    $resp = [
                        'user'=> [
                            'name'=> $name,
                            'email' => $email
                        ],
                        'access_token'=>$access_token
                    ];

                    return response()->json(Result::success($resp), 201);
                }
                catch (JWTException $e){
                    return response()->json(Result::failed("generate.token", "Error making access token $e"), 500);
                }
            }
        }

        return response()->json(Result::failed("cannot.save", "Cannot save"),404);
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

        if($user=User::where('email',$email)->first())
        {
            $credential=['email'=>$email, 'password'=>$password];

            $access_token=null;
            try{
                if($access_token=JWTAuth::attempt($credential))
                {
                    $response=[
                        'user'=> [
                            'name'=>$user->name,
                            'email'=>$user->email
                        ],
                        'access_token'=>$access_token
                    ];

                    return response()->json(Result::success($response), 201);    
                }
            }
            catch (JWTException $e)
            {
                return response()->json(Result::failed("generate.token", "Error making access token $e"), 500);
            }
        }

        return response()->json(Result::failed("not_matches", "Email or Password not Matches"));
    }

    public function logout(Request $request)
    {
        $this->validate($request,
            [
                'token'=>'required',

            ]);
        $token=$request->input('token');
        $var=DB::transaction(function() use ($token){
//            Periksa apakah token da didalam database
            $users = DB::table('users')->select('remember_token')->where('remember_token',$token)->first();
            if($users)
            {
                $get_token=$users->remember_token;
                if($get_token==$token)
                {
//                Remove token from database
                    $affected = DB::table('users')
                        ->where('remember_token', $token)
                        ->update(['remember_token' => null]);

                    if($affected)
                    {
                        $response=[
                            'status'=>'success',
                            'data'=>[
                                'code'=>0,
                                'msg'=>'user logout'

                            ]

                        ];
                        return response()->json($response,200);

                    }
                    else
                    {
                        $response=[
                            'data'=>null,
                            'errors'=>[
                                'code'=>1,
                                'msg'=>'Failed To Change Login Status'
                            ]
                        ];
                        return response()->json($response,404);
                    }
                }
                else
                {
                    $response=[
                        'data'=>null,
                        'errors'=>[
                          'code'=>2,
                            'msg'=>'user already logout'
                        ],

                    ];
                    return response()->json($response,404);
                }
            }
            else
            {
                $response=[
                    'data'=>null,
                    'errors'=>[
                        'code'=>2,
                        'msg'=>'user already logout'
                    ],

                ];
                return response()->json($response,404);
            }


        });


       return $var;


    }

}
