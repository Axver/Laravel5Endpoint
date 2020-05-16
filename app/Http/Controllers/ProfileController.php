<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Profile;
use DB;

class ProfileController extends Controller
{
    public function  __construct()
    {
    $this->middleware('jwt.auth',['except'=>['profile']]);
    }

    public function profile(Request $request)
    {
//        Mendapatkan Profile User Tertentu
        $this->validate($request,
            [
                'user_id'=>'required',
            ]);
        $user_id=$request->input('user_id');
        $CheckProfile =  DB::table('profiles')
            ->join('users', 'profiles.user_id', '=', 'users.id')
            ->select('profiles.company', 'profiles.photo', 'users.name',"users.email")
            ->where('user_id',$user_id);

        if($CheckProfile)
        {
            $response=[
                'status'=>'0',
            'data'=>$CheckProfile->get()
            ];
        }
        else
        {
            $response=[
                'status'=>'1',
                'message'=>'Failed'
            ];
        }

        return $response;


    }

    public function edit(Request $request)
    {
        $this->validate($request,
            [
                'photo'=>'required',
                'company'=>'required',
                'user_id'=>'required',
            ]);

        $photo=$request->input('photo');
        $company=$request->input('company');
        $user_id=$request->input('user_id');

        //     Periksa apakah data sudah ada
        $CheckProfile = Profile::where('user_id', '=', $user_id)->first();

        if (! $CheckProfile)
        {

            return response()->json(
                [
                    'message'=>'Profile Doesnt Exist'
                ], 404
            );

        }
        else
        {
//            Update Data
            $CheckProfile->photo=$photo;
            $CheckProfile->company=$company;


            if($CheckProfile->save())
            {
                return response()->json(
                    [
                        'message'=>'Profile Berhasil Diupdate'
                    ], 201
                );
            }
            else
            {
                return response()->json(
                    [
                        'message'=>'Profile Gagal Diupdate'
                    ], 201
                );
            }
        }


    }

    public function newinfo(Request $request)
    {
        $this->validate($request,
            [
                'photo'=>'required',
                'company'=>'required',
                'user_id'=>'required',
            ]);

        $photo=$request->input('photo');
        $company=$request->input('company');
        $user_id=$request->input('user_id');


//     Periksa apakah data sudah ada
        $CheckProfile = Profile::where('user_id', '=', $user_id)->first();

        if (! $CheckProfile)
        {
            $profile=Profile::create(
                [
                    'user_id'=>$user_id,
                    'photo'=>$photo,
                    'company'=>$company
                ]
            );
//            Tambahkan Data Baru
            if(!$profile)
            {
                return response()->json(
                    [
                        'msg'=>'Gagal Menambahkan Profile'
                    ], 400
                );
            }
            else
            {
                return response()->json(
                    [
                        'msg'=>'Profile Berhasil Di tambahkan'
                    ], 201
                );
            }


        }
        else
        {
//            Update Data
           $CheckProfile->photo=$photo;
           $CheckProfile->company=$company;


           if($CheckProfile->save())
           {
               return response()->json(
                   [
                       'msg'=>'Profile Berhasil Diupdate'
                   ], 201
               );
           }
           else
           {
               return response()->json(
                   [
                       'msg'=>'Profile Gagal Diupdate'
                   ], 201
               );
           }
        }





    }
}
