<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Profile;

class ProfileController extends Controller
{
    public function  __construct()
    {
    $this->middleware('jwt.auth');
    }

    public function profile(Request $request)
    {
//        Get Profile
        
        return "Berhasil";
    }

    public function edit(Request $request)
    {
        return "Berhasil";
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
