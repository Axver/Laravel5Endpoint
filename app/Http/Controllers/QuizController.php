<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Webpatser\Uuid\Uuid;

class QuizController extends Controller
{
    public function quiz(Request $request)
    {
        $this->validate($request,
            [
                'id_modul'=>'required',

            ]);
        $id_modul=$request->input('id_modul');
        $query = DB::table('question')
            ->select('id','question.id_modul','question','image','option','expiration')
            ->join('quiz', 'question.id_modul', '=', 'quiz.id_modul')
            ->where('question.id_modul', $id_modul)
            ->get();

        if($query->isEmpty())
        {
            return response()->json(
                [
                    'status'=>'failed',
                    'msg'=>'Pertanyaan Tidak Ada',
                ], 404
            );
        }

        $expiration=0;
        foreach ($query as $key=>$data)
        {
            $expiration=$data->expiration;
        }

//        Ubah Expiration ke Menit
        $expiration=$expiration*60;
        $expiresAt = Carbon::now()->addMinutes($expiration);
        $uuid=Uuid::generate()->string;
        Cache::put($uuid, $uuid, $expiresAt);

//        Ambil semua pertanyaanya
        $response=[
          'quizSession'=>$uuid,
            'question'=>$query
        ];
        return $response;
    }
}
