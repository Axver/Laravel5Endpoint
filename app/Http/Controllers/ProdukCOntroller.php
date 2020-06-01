<?php

namespace App\Http\Controllers;

use App\Mail\Verifikasi;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Webpatser\Uuid\Uuid;
use Carbon\Carbon;
use Illuminate\Support\Str;
use App\Mail\ListUser;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Cache;

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
            'status'=>'failed',
            'msg'=>'failed to get data'
        ];
        return response()->json($response,404);
    }
    else
    {
        $response=[
            'status'=>'success',
            'jenis'=>'produk',
            'data'=>$produk

        ];
        return response()->json($response,200);
    }

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
            'status'=>'failed',
            'mdg'=>'failed to get datas'
        ];

        return response()->json($response,404);
    }
    else
    {
        $response=[
            'status'=>'success',
            'jenis'=>'paket',
            'data'=>$paket

        ];

        return response()->json($response,200);
    }

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
        $email_user=$token_user->email;

        if($jenis=='produk')
        {
//            Buy Product Insert
            $uuid=Uuid::generate()->string;
            $insert=DB::table('pembelian_produk')->insert(
                array('id_pembelian' =>$uuid , 'id_produk' => $id_produk,'id_user'=>$id_user,'created_at'=>Carbon::now(),'status_pembayaran'=>'No')
            );

            $expiresAt = Carbon::now()->addMinutes(1500);
            Cache::put($uuid.'_', 'produk', $expiresAt);
            Cache::put($uuid, $uuid, $expiresAt);

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
                    'jenis'=>'produk',
                    'expired'=>Carbon::now(),
                    'data'=>$data
                ];
            }


        }
        else
        {
//            Insert untuk pembelian perpaket dan mengatur email yang akan ditambahkan
            $this->validate($request,
                [
                    'email'=>'required',
                    'id_produk'
                ]);
//           List Email diterima dalam bentuk teks dan dipish dengan tanda koma
            $email=$request->input('email');


            $var=DB::transaction(function() use ($id_produk,$id_user,$email,$email_user){
//                Check Max user
                $max=$user = DB::table('paket')->where('id', $id_produk)->first();
                if($max)
                {
                    $max_user=$max->max_user;
//                    Check email length
                    $list_email=explode(',',$email);
                    $jumlah_email=count($list_email);

                    if($jumlah_email<=$max_user)
                    {
//                        Jika jumlah sesuai kriteria lakukan insert ke database disini
                        $uuid=Uuid::generate()->string;

                        $insert=DB::table('pembelian_paket')->insert(
                            array('id_pembelian' =>$uuid , 'id' => $id_produk,'id_user'=>$id_user,'list_email'=>$email)
                        );
//                        Redis 25 jam expired
                        $expiresAt = Carbon::now()->addMinutes(1500);
                        Cache::put($uuid.'_', 'paket', $expiresAt);
                        Cache::put($uuid, $uuid, $expiresAt);


                        $i=0;
                        $account_generated=[];
                        while($i<$jumlah_email)
                        {
//                            generate user baru sesuai dengan data ini
                            $name_g=Str::random();
                            $email_g=$list_email[$i];
                            $password=Str::random();
                            $password_crypt=bcrypt($password);
//                            Insert data kedalam database

                            try
                            {
//                                Check email jika sudah pernah terdaftar jika sudah kirimkan notifiksi untuk menggunakan password lama
                                if($akun=$user = DB::table('users')->where('email', $email_g)->first())
                                {
                                    $account_generated[$i]=$email_g.'|'.'Password:Password Lama';
                                }
                                else
                                {
                                    $account_generated[$i]=$email_g.'|'.'Password:'.$password;
                                }

//                                    Insert saja
                                DB::table('users')->insert(
                                    ['name' => $name_g, 'email' => $email_g,'password'=>$password_crypt,'created_at'=>Carbon::now(),'updated_at'=>Carbon::now()]
                                );

                            }
                            catch (\PDOException $e)
                            {

                            }


                            $i++;

                        }
                        $expiresAt = Carbon::now()->addMinutes(1500);
                        Cache::put($uuid, $account_generated, $expiresAt);



                        return response()->json(
                            [
                                'msg'=>'success',
                                'message'=>'Pembelian Produk Berhasil Ditambahkan',
                                'jenis'=>'paket',
                                'id_barang'=>$uuid,
                                'expired'=>Carbon::now(),
                                'registered_user'=>Cache::get($uuid)
                            ], 201
                        );

                    }
                    else
                    {

                        return response()->json(
                            [
                                'msg'=>'failed',
                                'message'=>'Data email yang diinputkan melebihi kuota'
                            ], 404
                        );


                    }

                }
                else
                {
                    return response()->json(
                        [
                            'msg'=>'failed',
                            'message'=>'Max Kuota Tidak Ditemukan'
                        ], 404
                    );
                }

            });

//            Kirim emailnya ke user


            return $var;


        }

    }
    else
    {
        $response=[
            'status'=>'failed',
            'message'=>'Token Not Match'
        ];


    }

    return response()->json($response,404);
}

//Function Upload Bukti Pembayaran

public function uploadbukti(Request $request)
{
    $this->validate($request,
        [
            'id_pembelian'=>'required',
            'token'=>'required',

        ]);

    $id_pembelian=$request->input('id_pembelian');
    $jenis_produk=$request->input('token');

//    Cek apakah pembelian masih ada
    if (Cache::has($id_pembelian.'_')) {
        $value = Cache::get($id_pembelian.'_');

        if($value=='produk')
        {
//            Upload Bukti Untuk Produk
            $now=Carbon::now();
            $md5Name = md5_file($request->file('image')->getRealPath());
            $md5Name=$md5Name.md5($now);
            $md5Name=md5($md5Name);
            $guessExtension = $request->file('image')->guessExtension();
            $extension = $request->file('image')->extension();
            $path=$request->file('image')->move(public_path('/upload'),$md5Name.'.'.$guessExtension);
            $photoUrl=url('/upload',$md5Name.'.'.$extension);

//            Update Gambaar Di Database
            $uuid=Uuid::generate()->string;
            $update = DB::table('pembelian_produk')
                ->where('id_pembelian', $id_pembelian)
                ->update(['bukti_pembayaran' => $md5Name.'.'.$extension]);

            if($update)
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
        else
        {
//            Upload Bukti Untuk Produk
            $now=Carbon::now();
            $md5Name = md5_file($request->file('image')->getRealPath());
            $md5Name=$md5Name.md5($now);
            $md5Name=md5($md5Name);
            $guessExtension = $request->file('image')->guessExtension();
            $extension = $request->file('image')->extension();
            $path=$request->file('image')->move(public_path('/upload'),$md5Name.'.'.$guessExtension);
            $photoUrl=url('/upload',$md5Name.'.'.$extension);

//            Update Gambaar Di Database
            $uuid=Uuid::generate()->string;
            $update = DB::table('pembelian_paket')
                ->where('id_pembelian', $id_pembelian)
                ->update(['bukti_pembayaran' => $md5Name.'.'.$extension]);

            if($update)
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


}

public function verifikasi(Request $request)
{
    $this->validate($request,
        [
            'id_pembelian'=>'required',
            'jenis'=>'required'
        ]);
    $id_pembelian=$request->input('id_pembelian');
    $jenis_produk=$request->input('jenis');

//    return $id_pembelian."=====".Cache::get($id_pembelian);

    if($jenis_produk=='paket')
    {
//        Update pada pembelian paket
        if (Cache::has($id_pembelian)) {
            $var=DB::transaction(function() use ($id_pembelian){
                $affected = DB::table('pembelian_paket')
                    ->where('id_pembelian', $id_pembelian)
                    ->update(['status_pembayaran' => "Yes"]);
                $id_produk=DB::table('pembelian_paket')->select('id')->where('id_pembelian',$id_pembelian)->first();



                $list_user=Cache::get($id_pembelian);
                $count=count($list_user);
                $x=0;
                $new_list_email=[];
                while($x<$count)
                {
//                    Explode data
                    $email_g=explode('|',$list_user[$x]);
//                    Tambahkan kedalam database
                    $uuid=Uuid::generate()->string;
                    $id_user=DB::table('users')->select('id')->where('email',$email_g[0])->first();
                    DB::table('pembelian_paket')->insert(
                        ['id_pembelian' => $uuid, 'id' => $id_produk->id,'id_user'=>$id_user->id,'status_pembayaran'=>'Yes']
                    );

                    $x++;
                }


//Tambahkan user ke data pembeli
                $response=[
                    'status'=>'success',
                    'message'=>'Pembelian diverifikasi',
                    'data'=>$list_user,
                ];

                return $response;
            });

            $list_user=Cache::get($id_pembelian);

            if($var)
            {
               $datauser=  $data = DB::table('pembelian_paket')
                   ->select('email')
                   ->join('users', 'pembelian_paket.id_user', '=', 'users.id')
                   ->where('pembelian_paket.id_pembelian', $id_pembelian)
                   ->first();
                Mail::to($datauser->email)->send(new ListUser($list_user,$datauser->email));
            }
            Cache::forget($id_pembelian);
            Cache::forget($id_pembelian.'_');
            return $var;
        }
        else
        {
           return $response=[
                'status'=>'failed',
                'message'=>'Waktu Verifikasi Sudah Expired Atau Pembelian Sudah Di Verifikasi'
            ];
        }

    }
    else
    {
//        Update pada pembelian produk
        if (Cache::has($id_pembelian.'_')) {
            $var=DB::transaction(function() use ($id_pembelian){
//              Update tabel pembelian_produk
                $affected = DB::table('pembelian_produk')
                    ->where('id_pembelian', $id_pembelian)
                    ->update(['status_pembayaran' => "Yes"]);

                $response=[
                    'status'=>'succcess',
                    'message'=>'Verifikasi Sukses'
                ];

                return $response;

            });

            if($var)
            {
                $datauser=  $data = DB::table('pembelian_produk')
                    ->select('email')
                    ->join('users', 'pembelian_produk.id_user', '=', 'users.id')
                    ->where('pembelian_produk.id_pembelian', $id_pembelian)
                    ->first();
                Mail::to($datauser->email)->send(new Verifikasi());
            }

            Cache::forget($id_pembelian);
            Cache::forget($id_pembelian.'_');
            return $var;
        }
        else
        {
           return $response=[
                'status'=>'failed',
                'message'=>'Waktu Verifikasi Sudah Expired Atau Pembelian Sudah Di Verifikasi'
            ];
        }
    }

//            Remove Redis

}










}
