<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Webpatser\Uuid\Uuid;
use Carbon\Carbon;

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
            'jenis'=>'produk',
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
            'jenis'=>'paket',
            'data'=>$paket

        ];
    }
    return $response;
}

//Pembelian Produk
public function pembelian(Request $request)
{
    $this->validate($request,
        [
            'id_produk'=>'required',
            'token'=>'required',
            'jenis'=>'required'
        ]);

    $id_produk=$request->input('id_produk');
    $token=$request->input('token');
    $jenis=$request->input('jenis');

    //        Check remember token
    if($token_user=$user = DB::table('users')->where('remember_token', $token)->first())
    {
        //    Jika jenisnya adalah produk maka masukkan ke tabel produk
        //    Jika jenisnya paket maka masukkan ke tabel paket
        $id_user=$token_user->id;

        if($jenis=='produk')
        {
//            Buy Product Insert
            $uuid=Uuid::generate()->string;
            $insert=DB::table('pembelian_produk')->insert(
                array('id_pembelian' =>$uuid , 'id_produk' => $id_produk,'id_user'=>$id_user,'created_at'=>Carbon::now(),'status_pembayaran'=>'No')
            );

            if(!$insert)
            {
                $response=[
                    'status'=>'failed',
                    'msg'=>'Gagal Membeli Produk'
                ];
            }
            else
            {
                $data = DB::table('pembelian_produk')
                    ->select('id_pembelian','status_pembayaran','bukti_pembayaran','nama_produk','deskripsi_produk','foto','harga','zoom')
                    ->join('produk', 'pembelian_produk.id_produk', '=', 'produk.id')
                    ->where('pembelian_produk.id_pembelian', $uuid)
                    ->get();
                $response=[
                    'status'=>'success',
                    'data'=>$data
                ];
            }


        }
        else
        {

        }

    }
    else
    {
        $response=[
            'status'=>'failed',
            'message'=>'Token Not Match'
        ];
    }



    return $response;
}


}
