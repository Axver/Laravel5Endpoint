<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Webpatser\Uuid\Uuid;

class PdfController extends Controller
{
    //
    public function index($nama)
    {
//        Cari semua file dengan id tersebut
        $file=$user = DB::table('exclusive')->where('id', $nama)->first();
        if($file)
        {
            $nama_file=$file->file_modul;

            $nama_new= asset('upload/pdf/'.$nama_file);
                        return view('pdf',['nama'=>$nama_new]);
        }
        else
        {
            return view('pdf',['nama'=>'default']);
        }


    }

    public function uploadexlusive(Request $request)
    {
        $this->validate($request,
            [
                'id_modul'=>'required',
            ]);
        $id_modul=$request->input('id_modul');
        $now=Carbon::now();
        $md5Name = md5_file($request->file('file')->getRealPath());
        $md5Name=$md5Name.md5($now);
        $md5Name=md5($md5Name);
        $guessExtension = $request->file('file')->guessExtension();
        $extension = $request->file('file')->extension();

        if($extension=='pdf' || $extension=='PDF' || $extension=='Pdf')
        {
            $path=$request->file('file')->move(public_path('/upload/pdf'),$md5Name.'.'.$guessExtension);
            $photoUrl=url('/upload/pdf',$md5Name.'.'.$extension);

//        Insert data kedalam database
            $uuid=Uuid::generate()->string;
            $insert=DB::table('exclusive')->insert(
                ['id' => $uuid, 'file_modul' => $md5Name.'.'.$extension,'id_modul'=>$id_modul]
            );

            if($insert)
            {
                return response()->json(
                    [
                        'status'=>'success',
                        'msg'=>'Berhasil Menambahkan File Pdf',
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
                        'msg'=>'Gagal Menambahkan File PDF'
                    ], 404
                );
            }
        }
        else
        {
            return response()->json(
                [
                    'status'=>'failed',
                    'msg'=>'Tipe File Bukan PDF'
                ], 404
            );
        }


    }

//    Get all modul exclusive file id
public function modul_exlusive(Request $request)
{
    $this->validate($request,
        [
            'id_modul'=>'required',
        ]);
    $id_modul=$request->input('id_modul');

    $data = DB::table('exclusive')->select('exclusive.id', 'file_modul')->where('id_modul',$id_modul)->get();

    if($data)
    {
        foreach ($data as $key=>$data1)
        {

            if($data1->file_modul!=null)
            {
                $base_url=url('/').'/upload/'.$data1->file_modul;
                $data1->file_modul=$base_url;
            }

        }
        return response()->json(
            [
                'status'=>'success',
                'data'=>$data
            ], 200
        );
    }
    else
    {
        return response()->json(
            [
                'status'=>'failed',
                'msg'=>'data not found'
            ], 404
        );
    }
}


//Upload Downloadable
    public function uploaddownloadble(Request $request)
    {
        $this->validate($request,
            [
                'id_modul'=>'required',
            ]);
        $id_modul=$request->input('id_modul');
        $now=Carbon::now();
        $md5Name = md5_file($request->file('file')->getRealPath());
        $md5Name=$md5Name.md5($now);
        $md5Name=md5($md5Name);
        $guessExtension = $request->file('file')->guessExtension();
        $extension = $request->file('file')->extension();


            $path=$request->file('file')->move(public_path('/upload/downloadble'),$md5Name.'.'.$guessExtension);
            $photoUrl=url('/upload/downloadble',$md5Name.'.'.$extension);

//        Insert data kedalam database
            $uuid=Uuid::generate()->string;
            $insert=DB::table('downloadable')->insert(
                ['id' => $uuid, 'file_modul' => $md5Name.'.'.$extension,'id_modul'=>$id_modul]
            );

            if($insert)
            {
                return response()->json(
                    [
                        'status'=>'success',
                        'msg'=>'Berhasil Menambahkan File',
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
                        'msg'=>'Gagal Menambahkan File'
                    ], 404
                );
            }



    }

//    Download link by modul

public function downbymodul(Request $request){
    $this->validate($request,
        [
            'id_modul'=>'required',
        ]);
    $id_modul=$request->input('id_modul');
    $modul = DB::table('downloadable')->select('id', 'file_modul')
        ->where('id_modul',$id_modul)->get();

    if($modul)
    {
        return response()->json(
            [
                'status'=>'success',
                'msg'=>'Berhasil mengmbil daftr file downloadble untuk modul',
                'data'=>$modul
            ], 200
        );
    }
    else
    {
        return response()->json(
            [
                'status'=>'failed',
                'msg'=>'Gagal Mengmbil Modul'
            ], 404
        );
    }

}




}
