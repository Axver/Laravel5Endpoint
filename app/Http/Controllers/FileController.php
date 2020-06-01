<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Webpatser\Uuid\Uuid;
use Illuminate\Support\Facades\DB;

class FileController extends Controller
{
    public function upload(Request $request)
    {
        $now=Carbon::now();
        $md5Name = md5_file($request->file('image')->getRealPath());
        $md5Name=$md5Name.md5($now);
        $md5Name=md5($md5Name);
        $guessExtension = $request->file('image')->guessExtension();
        $extension = $request->file('image')->extension();
        $path=$request->file('image')->move(public_path('/upload'),$md5Name.'.'.$guessExtension);
        $photoUrl=url('/upload',$md5Name.'.'.$extension);

//        Insert data kedalam database
        $uuid=Uuid::generate()->string;
        $insert=DB::table('image')->insert(
            ['image' => $uuid, 'name' => $md5Name.'.'.$extension]
        );

        if($insert)
        {
            return response()->json(
                [
                    'status'=>'success',
                    'msg'=>'Berhasil Menambahkan Gambar',
                    'url'=>$photoUrl,
                    'name'=>$md5Name.'.'.$extension,
                    'id'=>$uuid
                ], 201
            );
        }
        else
        {
            return response()->json(
                [
                    'status'=>'failed',
                    'msg'=>'Gagal Menambahkan Gambar'
                ], 404
            );
        }
        return $photoUrl ;
    }
}
