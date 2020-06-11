<?php

namespace App\Http\Controllers;

use App\Mail\Verifikasi;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use phpDocumentor\Reflection\Types\Array_;
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
        $training = DB::table('training')->select('training.id', 'nama_training','deskripsi','thumbnail','image.name')
            ->leftJoin('image_triaining','training.id','image_triaining.id')
            ->leftJoin('image','image_triaining.image','image.image')->get();
        if(!$training)
        {
            $response=[
                'status'=>'failed'
            ];
        }
        else
        {
            foreach ($training as $key=>$data)
            {

                if($data->name!=null)
                {
                    $base_url=url('/').'/upload/'.$data->name;
                    $data->name=$base_url;
                }

            }
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

    $produk = DB::table('topik')->select('topik.id', 'training_id','nama_topik','deskripsi_topik','thumbnail','harga','zoom','image.name')
        ->leftJoin('image_produk','topik.id','image_produk.id')
        ->leftJoin('image','image_produk.image','image.image')
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
        foreach ($produk as $key=>$data)
        {

            if($data->name!=null)
            {
                $base_url=url('/').'/upload/'.$data->name;
                $data->name=$base_url;
            }

        }
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

    $paket = DB::table('paket')->select('paket.id', 'training_id','nama_paket','deskripsi','harga','zoom','max_user','image.name')
        ->leftJoin('image_paket','paket.id','image_paket.id')
        ->leftJoin('image','image_paket.image','image.image')
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
        foreach ($paket as $key=>$data)
        {

            if($data->name!=null)
            {
                $base_url=url('/').'/upload/'.$data->name;
                $data->name=$base_url;
            }

        }
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
                    ->select('id_pembelian','status_pembayaran','bukti_pembayaran','nama_topik','deskripsi_topik','thumbnail','harga','zoom','image.name')
                    ->join('topik', 'pembelian_produk.id_produk', '=', 'topik.id')
                    ->leftJoin('image_produk','topik.id','image_produk.id')
                    ->leftJoin('image','image_produk.image','image.image')
                    ->where('pembelian_produk.id_pembelian', $uuid)
                    ->get();

                if($data)
                {
                    foreach ($data as $key=>$data)
                    {

                        if($data->name!=null)
                        {
                            $base_url=url('/').'/upload/'.$data->name;
                            $data->name=$base_url;
                        }

                    }
                }
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
                                    if($akun=='')
                                    {

                                    }
                                    else
                                    {
                                        $account_generated[$i]=$email_g.'|'.'Password:'.$password;
                                    }

                                }

                                if($email_g==''){

                                }
                                else
                                {
                                    DB::table('users')->insert(
                                        ['name' => $name_g, 'email' => $email_g,'password'=>$password_crypt,'created_at'=>Carbon::now(),'updated_at'=>Carbon::now()]
                                    );
                                }

//                                    Insert saja


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
            'token'=>'required'
        ]);

    $id_pembelian=$request->input('id_pembelian');
    $token=$request->input('token');
//    Cek apakah pembelian masih ada
    if (Cache::has($id_pembelian)) {
            $now=Carbon::now();
            $md5Name = md5_file($request->file('image')->getRealPath());
            $md5Name=$md5Name.md5($now);
            $md5Name=md5($md5Name);
            $guessExtension = $request->file('image')->guessExtension();
            $extension = $request->file('image')->extension();
            $path=$request->file('image')->move(public_path('/upload'),$md5Name.'.'.$guessExtension);
            $photoUrl=url('/upload',$md5Name.'.'.$extension);

            if(strtolower($extension)=='png'||strtolower($extension)=='jpg'||strtolower($extension)=='bmp'||strtolower($extension)=='jpeg')
            {
                //            Update Gambaar Di Database
                $uuid=Uuid::generate()->string;
                $update = DB::table('pembelian')
                    ->where('id_pembelian', $id_pembelian)
                    ->update(['bukti_pembayaran' => $md5Name.'.'.$extension]);


                if($update)
                {
                    Cache::forget($id_pembelian);
                    return response()->json(
                        [
                            'status'=>'success',
                            'data'=>[
                                'code'=>0,
                                'msg'=>'Image Upload Sucessfully',
                                'url'=>$photoUrl,
                                'name'=>$md5Name.'.'.$extension,
                                'id_image'=>$uuid
                            ]

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

            }
            else
            {
                return response()->json(
                    [
                        'data'=>null,
                        'errors'=>[
                            'code'=>1,
                            'msg'=>'Type file not accepted'
                        ]
                    ], 404
                );
            }



    }
    else
    {
        return response()->json(
            [
                'data'=>null,
                'errors'=>[
                    'code'=>1,
                    'msg'=>'id_pembelian not match of any data'
                ]
            ], 404
        );
    }


}

public function verifikasi(Request $request)
{
    $this->validate($request,
        [
            'id_pembelian'=>'required',
        ]);
    $id_pembelian=$request->input('id_pembelian');
            $var=DB::transaction(function() use ($id_pembelian){
                $affected = DB::table('pembelian')
                    ->where('id_pembelian', $id_pembelian)
                    ->update(['status_pembayaran' => "Yes"]);
                $list_email = DB::table('pembelian_paket')
                    ->select('list_email')
                    ->where('pembelian_id_pembelian', $id_pembelian)->get();


                return $list_email;
            });

            if($var)
            {
                $length=count($var);
                $list_email='';
//                return $length;

                $i=0;
                while($i<$length)
                {
                    $list_email=$list_email.','.$var[$i]->list_email;
                    $i++;
                }


            }
            $list_email_new=explode(',',$list_email);
            $removed = array_shift($list_email_new);

//            Generate list user dari list email tersebut


            $datauser=  $data = DB::table('pembelian')
                   ->select('email')
                   ->join('users', 'pembelian.users_id', '=', 'users.id')
                   ->where('pembelian.id_pembelian', $id_pembelian)
                   ->first();

            $jumlah_email=count($list_email_new);

            $i=0;

    while($i<$jumlah_email)
    {
//                            generate user baru sesuai dengan data ini
        $name_g=Str::random();
        $email_g=$list_email_new[$i];
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
                DB::table('users')->insert(
                    ['name' => $name_g, 'email' => $email_g,'password'=>$password_crypt,'created_at'=>Carbon::now(),'updated_at'=>Carbon::now()]
                );


            }


        }
        catch (\PDOException $e)
        {

        }


        $i++;

    }

//    return var_dump($account_generated);

   $send= Mail::to($datauser->email)->send(new ListUser($account_generated,$datauser->email));

    return response()->json(
        [
            'status'=>'success',
            'data'=>[
                'msg'=>'account generated and email already sent',
                'users'=>$account_generated
            ]
        ], 201
    );



}


public function topikfrompaket(Request $request)
{
    $this->validate($request,
        [
            'id_topik'=>'required',
        ]);
    $id_topik=$request->input('id_topik');
//    Select Data
    $topik = DB::table('paket_topik')->select('topik.id', 'nama_topik','deskripsi_topik','thumbnail','harga','image.name')
        ->leftJoin('topik','paket_topik.id','topik.id')
        ->leftJoin('image_produk','topik.id','image_produk.id')
        ->leftJoin('image','image_produk.image','image.image')
        ->where('paket_topik.paket_id',$id_topik)->get();

    if($topik)
    {
        foreach ($topik as $key=>$data)
        {

            if($data->name!=null)
            {
                $base_url=url('/').'/upload/'.$data->name;
                $data->name=$base_url;
            }

        }
        $response=[
            'status'=>'success',
            'data'=>$topik
        ];

        return response()->json(
            $response, 404
        );
    }
    else
    {
        $response=[
            'status'=>'failed',
            'msg'=>'Failed to get topik data'
        ];

        return response()->json(
           $response, 404
        );
    }



}



public function belibatch(Request $request)
{
    $this->validate($request,
        [
            'user_token'=>'required',
            'list'=>'required',
        ]);

    $user_token=$request->input('user_token');
    $list=$request->input('list');

    if($gettoken=DB::table('users')->select('remember_token','id')->where('remember_token',$user_token)->first())
    {
        if($user_token==$gettoken->remember_token)
        {
            $id_pembelian=Uuid::generate()->string;
            $id_user=$gettoken->id;
            $list=json_decode($list);
            $count=count($list->data);
            $i=0;
            $topik_data=array();
            $paket_data=array();
            $count_topik=0;
            $counnt_paket=0;
            while($i<$count)
            {
                $jenis=$list->data[$i]->jenis;
                $produk_paket_id=$list->data[$i]->produk_paket_id;
                $email=$list->data[$i]->email;

//                jenis untuk mennentukan apakah yang dibeli adalah paket ataupun produk , produk disebut juga topik
//                jenis: 1 -> Pertopik, Jenis: 2->Perpaket
                if($jenis=='1')
                {
                    $uuid=Uuid::generate()->string;
                    $topik_data_ew=array('id_pembelian' =>$uuid , 'id_produk' => $produk_paket_id,'created_at'=>Carbon::now(),'pembelian_id_pembelian'=>$id_pembelian);
                    $topik_data[$count_topik]=$topik_data_ew;
                    $count_topik++;

                }
                else if($jenis=='2')
                {
                    $uuid=Uuid::generate()->string;
                    $topik_paket_ew=array('id_pembelian' =>$uuid , 'list_email' => $email,'id'=>$produk_paket_id,'created_at'=>Carbon::now(),'pembelian_id_pembelian'=>$id_pembelian);
                    $paket_data[$counnt_paket]=$topik_paket_ew;
                    $counnt_paket++;

                }


                $i++;
            }
        }

//        Db Traaction untuk menambahkan data

        $var=DB::transaction(function() use ($id_user,$topik_data,$paket_data,$id_pembelian){

            try{

                DB::table('pembelian')->insert(
                    ['id_pembelian' => $id_pembelian, 'users_id' => $id_user]
                );

                if(count($topik_data)>0)
                {
                    DB::table('pembelian_produk')->insert(
                        $topik_data
                    );
                }

                if(count($paket_data)>0)
                {
                    DB::table('pembelian_paket')->insert(
                        $paket_data
                    );
                }

                return "Berhasil";

            } catch (\Exception $e) {
                return  $e->getMessage();
            }




        });

if($var)
{
    $expiresAt = Carbon::now()->addMinutes(1500);
    Cache::put($id_pembelian, $id_pembelian, $expiresAt);
//    Jika berhasil maka generate Email dan Password untuk user
    $countPaket=count($paket_data);
    $i=0;
    $email_builder='';
    while($i<$countPaket)
    {




        $var=DB::transaction(function() use ($paket_data,$i,$email_builder){
//                Check Max user

            $account_generated=[];
            $max=$user = DB::table('paket')->where('id', $paket_data[$i]['id'])->first();
            if($max)
            {
                $max_user=$max->max_user;
                $list_email=explode(',',$paket_data[$i]['list_email']);
                $jumlah_email=count($list_email);


                if($jumlah_email<=$max_user)
                {

                    $j=0;

                    while($j<$jumlah_email)
                    {

                        $email_builder=$email_builder.$list_email[$j].',';
                        $j++;

                    }
//                    Masukkan data email ke chache
//                    $expiresAt = Carbon::now()->addMinutes(1500);
//                    Cache::put($paket_data[$i]['id_pembelian'], $email_builder, $expiresAt);

                    return 1;
                }
                else
                {

                  return 2;

                }

            }
            else
            {
             return 3;
            }

        });

        $i++;
    }

//    Cek jika transaction var berhasil atau tidak
    if($var==1)
    {
//        Generate response untuk user
        $i=0;
        $harga_paket=0;

        while($i<$countPaket)
        {
            $max=$user = DB::table('paket')->where('id', $paket_data[$i]['id'])->first();
            $harga_paket=$harga_paket+$max->harga;
            $i++;
        }

        $countTopik=count($topik_data);
        $i=0;

        while($i<$countTopik)
        {
            $max=$user = DB::table('topik')->where('id', $topik_data[$i]['id_produk'])->first();
            $harga_paket=$harga_paket+$max->harga;
            $i++;
        }

        return response()->json(
            [
                'msg'=>'success',
                'data'=>[
                    'code'=>0,
                    'list_topik'=>$topik_data,
                    'list_paket'=>$paket_data,
                    'expired'=>$expiresAt
                ],
                'total'=>$harga_paket
            ], 201
        );
    }
    else if($var==2)
    {
        return response()->json(
            [
                'msg'=>'failed',
                'message'=>'Jumlah Email Melebihi Kuota Paket'
            ], 404
        );
    }
    else if($var==3)
    {
        return response()->json(
            [
                'msg'=>'failed',
                'message'=>'Max Kuota Tidak Ditemukan'
            ], 404
        );
    }

    return $var;
}
else
{
    return "Gagal";
}
    }
    else
    {
        return response()->json(
            [
                'msg'=>'failed',
                'message'=>'Token Not Match'
            ], 404
        );
    }
}


    public function listbeli(Request $request)
    {
        $this->validate($request,
            [
                'user_token'=>'required',
                'id_pembelian'=>'required',
            ]);

        $user_token=$request->input('user_token');
        $id_pembelian=$request->input('id_pembelian');




        if($users = DB::table('users')->where('remember_token', '=', $user_token)->first())
        {
            if($user_token==$users->remember_token)
            {
                $pembelian = DB::table('pembelian')->select('bukti_pembayaran','status_pembayaran')
                        ->leftJoin('pembelian_paket','pembelian_paket.pembelian_id_pembelian','pembelian.id_pembelian')
                        ->leftJoin('paket','pembelian_paket.id','paket.id')
                        ->leftJoin('pembelian_produk','pembelian_produk.pembelian_id_pembelian','pembelian.id_pembelian')
                        ->leftJoin('topik','pembelian_produk.id_produk','topik.id')
                    ->where('pembelian.id_pembelian','=',$id_pembelian)
                    ->where('pembelian.users_id','=',$users->id)->first();
                $list_paket=$users = DB::table('paket')
                    ->select('paket.*')
                    ->leftJoin('pembelian_paket','pembelian_paket.id','paket.id')
                    ->where('pembelian_id_pembelian', '=', $id_pembelian)

                    ->get();

                $list_topik=$users = DB::table('topik')
                    ->select('topik.*')
                    ->leftJoin('pembelian_produk','pembelian_produk.id_produk','topik.id')
                    ->where('pembelian_id_pembelian', '=', $id_pembelian)

                    ->get();

                if($pembelian)
                {
                    return response()->json(
                        [
                            'msg'=>'success',
                            'data'=>[
                                'code'=>0,
                                'pembayaran'=>$pembelian,
                                'list_paket'=>$list_paket,
                                'list_topik'=>$list_topik
                            ],
                            'id_pembelian'=>$id_pembelian
                        ], 200
                    );
                }
            }
            else
            {

            }
        }
        else
        {
            return response()->json(
                [
                    'msg'=>'failed',
                    'message'=>'Token No Match'
                ], 404
            );
        }
    }








}
