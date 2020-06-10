<?php

namespace App\Http\Controllers;

use http\Env\Response;
use Illuminate\Http\Request;
use JWTAuth;
use JWTAuthException;
use App\User;
use Illuminate\Support\Facades\DB;
use App\Exceptions;


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
//Check apakah email sudah terdaftar
        if($getemail=DB::table('users')->select('email')->where('email',$email)->first())
        {
            if($email==$getemail->email)
            {
                $response=[
                    'data'=>null,
                    'errors'=>[
                        'code'=>0,
                        'msg'=>'Email Already Registered'
                    ]

                ];

                return response()->json($response,404);

            }
            else
            {
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
                        'code'=>0,
                        'status'=>'success',
                        'data'=>[
                            'user'=>$user,
                            'token'=>$token
                        ]

                    ];


                    return response()->json($response,201);


                }
            }
        }
        else
        {
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
                    'code'=>0,
                    'status'=>'success',
                    'data'=>[
                        'user'=>$user,
                        'token'=>$token
                    ]

                ];


                return response()->json($response,201);


            }
        }






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
                            'data'=>null,
                            'error'=>[
                                'code'=>1,
                                'msg'=>'Failed Generate Tokens',
                            ]
                        ], 404
                    );
                }
            }
            catch (JWTException $e)
            {
                return response()->json(
                    [
                        'data'=>null,
                        'error'=>[
                            'code'=>1,
                            'msg'=>'Failed Generate Tokens',
                        ]
                    ], 404
                );
            }

            $response=[
                'code'=>0,
              'status'=>'success',
                'data'=>[
                    'user'=>$user,
                    'token'=>$token
                ]

            ];

//            Update Remember token pada tabel user
            $affected = DB::table('users')
                ->where('email', $email)
                ->update(['remember_token' => $token]);

            return response()->json($response,201);

        }
        else
        {
            return response()->json(
                [
                    'data'=>null,
                    'error'=>[
                        'code'=>2,
                        'msg'=>'Username Or Pssword Not Matchs',
                    ]
                ], 404
            );
        }



        return response()->json($response,404);
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
