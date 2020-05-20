<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PdfController extends Controller
{
    //
    public function index($nama)
    {
//        Cari semua file dengan id tersebut
        $file=$user = DB::table('modul')->where('id_modul', $nama)->first();
        if($file)
        {
            $nama_file=$file->file_modul;

            $nama_new= asset('storage/'.$nama_file);
                        return view('pdf',['nama'=>$nama_new]);
        }
        else
        {
            return view('pdf',['nama'=>'default']);
        }


    }
}
