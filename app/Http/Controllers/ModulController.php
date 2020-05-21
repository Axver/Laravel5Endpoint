<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
Use Exception;

class ModulController extends Controller
{
    public function add(Request $request)
    {
//        Tambahkan data Modul
        $this->validate($request,
            [
                'id_produk'=>'required',
                'nama_modul'=>'required',
                'file_modul'=>'required',

            ]);

        $id_produk=$request->input('id_produk');
        $nama_modul=$request->input('nama_modul');
        $file_modul=$request->input('file_modul');

        try{
            $insert=DB::table('modul')->insert(
                ['id_produk' => $id_produk, 'nama_modul' => $nama_modul,'file_modul'=>$file_modul]
            );
            return response()->json(
                [
                    'status'=>'success',
                    'smsg'=>'Berhasil Menambahakan Data Modul',
                ], 201
            );
        } catch (Exception $e){
            return response()->json(
                [
                    'status'=>'failed',
                    'msg'=>'Gagal Menambahakan Data Modul',
                ], 404
            );
        }


    }

//    Get ALl Product Modul
public function produkmodul(Request $request)
{
    $this->validate($request,
        [
            'id_produk'=>'required',

        ]);
    $id_produk=$request->input('id_produk');
    try{
       $select=$users = DB::table('modul')->select('id_modul', 'nama_modul','file_modul')->where('id_produk',$id_produk)->get();
        return response()->json(
            [
                'status'=>'success',
                'msg'=>'Berhasil Mengambil Data Modul',
                'data'=>$select
            ], 200
        );
    } catch (Exception $e){
        return response()->json(
            [
                'status'=>'failed',
                'msg'=>'Gagal Mengambil Data Modul',
            ], 404
        );
    }

    return "Berhasil";
}

//Video By Modul
    public function videomodul(Request $request)
    {
        $this->validate($request,
            [
                'id_modul'=>'required',

            ]);
        $id_modul=$request->input('id_modul');
        try{
            $select=$users = DB::table('video')->select('id_video', 'nama_video','url')->where('id_modul',$id_modul)->get();
            return response()->json(
                [
                    'status'=>'success',
                    'msg'=>'Berhasil Mengambil Data Video Untuk Modul',
                    'data'=>$select
                ], 200
            );
        } catch (Exception $e){
            return response()->json(
                [
                    'status'=>'failed',
                    'msg'=>'Gagal MMengambil Data Video Untuk Modul',
                ], 404
            );
        }

        return "Berhasil";
    }



}
