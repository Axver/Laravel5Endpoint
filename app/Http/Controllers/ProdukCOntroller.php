<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProdukCOntroller extends Controller
{
//    Mengirimkan semua data pelatihan yang ada
    public function listtraining(Request $request)
    {
        $training = DB::table('training')->select('id', 'nama_training','deskripsi','foto')->get();
        if(!$training)
        {
            $response=[
                'status'=>'failed'
            ];
        }
        else
        {
            $response=[
                'status'=>'success',
                'data'=>$training

            ];
        }
        return $response;
    }

//    Menampilkan produk berdasarkan training tertentu
public function produkbytraining(Request $request)
{
    $this->validate($request,
        [
            'training_id'=>'required',
        ]);
    $training_id=$request->input('training_id');

    $produk = DB::table('produk')->select('id', 'training_id','nama_produk','deskripsi_produk','foto','harga','zoom')
        ->where('training_id',$training_id)->get();
    if(!$produk)
    {
        $response=[
            'status'=>'failed'
        ];
    }
    else
    {
        $response=[
            'status'=>'success',
            'data'=>$produk

        ];
    }
    return $response;
}

//Menampilkan Paket By Training
public function paketbytraining(Request $request)
{
    $this->validate($request,
        [
            'training_id'=>'required',
        ]);
    $training_id=$request->input('training_id');

    $paket = DB::table('paket')->select('id', 'training_id','nama_paket','deskripsi','harga','zoom','max_user')
        ->where('training_id',$training_id)->get();
    if(!$paket)
    {
        $response=[
            'status'=>'failed'
        ];
    }
    else
    {
        $response=[
            'status'=>'success',
            'data'=>$paket

        ];
    }
    return $response;
}


}
