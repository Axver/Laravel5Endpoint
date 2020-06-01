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
            ->select('question.id','question.id_modul','question','option','expiration','image.name')
            ->join('quiz', 'question.id_modul', '=', 'quiz.id_modul')
            ->leftJoin('question_image','question.id','question_image.id')
            ->leftJoin('image','question_image.image','image.image')
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
        $id_modul_get='';
        foreach ($query as $key=>$data)
        {
            $expiration=$data->expiration;
            $id_modul_get=$data->id_modul;
            if($data->name!=null)
            {
                $base_url=url('/').'/upload/'.$data->name;
                $data->name=$base_url;cmddd
            }

        }



//        Ubah Expiration ke Menit
        $expiration=$expiration*60;
        $expiresAt = Carbon::now()->addMinutes($expiration);
        $now=Carbon::now();
        $uuid=Uuid::generate()->string;
        Cache::put($uuid, $now, $expiresAt);

//        Ambil semua pertanyaanya
        $response=[
          'quizSession'=>$uuid,
            'id_modul'=>$id_modul_get,
            'question'=>$query
        ];
        return $response;
    }

    public function answer(Request $request)
    {
        $this->validate($request,
            [
                'session_id'=>'required',
                'answer'=>'required',
                'user_id'=>'required',
                'id_modul'=>'required'
            ]);
        $session_id=$request->input('session_id');
        $answer=$request->input('answer');
        $user_id=$request->input('user_id');
        $id_modul=$request->input('id_modul');

//        Cek apakah session_id masih ada atau tidak
        if (Cache::has($session_id)) {
//            Jika data ada maka periksa hasil inputan user nya
            $answer=json_decode($answer);
            $count=count($answer->data);

            $correct=0;
            $wrong=0;

            $i=0;
            while($i<$count)
            {
                $id_question=$answer->data[$i]->id_question;
                $user_answer=$answer->data[$i]->answer;

//                Select Real Naswer
                $users = DB::table('question')->select('answer')->where('id',$id_question)->first();
                $real_answer=$users->answer;

                $data_he[$i]=[
                    'real_answer'=>$real_answer,
                    'user_answer'=>$user_answer
                ];

                if($real_answer==$user_answer)
                {
                    $correct++;
                }
                else
                {
                    $wrong++;
                }
                $i++;
            }

            $final_point=$correct/$count*100;
//            Selanjutnya simpan hasilnya didatabase
//            Ambil data dari Redis
            $time = Cache::get($session_id);
            $insert=DB::table('quiz_session')->insert(
                ['id_session' => $session_id,'starting_time'=>$time,'id_modul'=>$id_modul,'id'=>$user_id,'wrong_count'=>$wrong,'correct_count'=>$correct,'score'=>$final_point]
            );

            if($insert)
            {
                return response()->json(
                    [
                        'status'=>'success',
                        'msg'=>'Jawaban Sudah DI Submit',
                        'correct'=>$correct,
                        'wrong'=>$wrong,
                        'score'=>$final_point
                    ],201
                );
            }
            else
            {
                return response()->json(
                    [
                        'status'=>'failed',
                        'msg'=>'Gagal Menyimpan Jawaban',
                    ], 404
                );
            }



        }
        else
        {
            return response()->json(
                [
                    'status'=>'failed',
                    'msg'=>'Session Sudah Berakhir',
                ], 404
            );
        }
    }
}
