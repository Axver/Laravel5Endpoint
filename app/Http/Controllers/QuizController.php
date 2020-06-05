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
                'id_topik'=>'required',

            ]);
        $id_topik=$request->input('id_topik');
        $query = DB::table('question')
            ->select('question.id','question.quiz_id','question','option','expiration','image.name')
            ->join('quiz', 'question.quiz_id', '=', 'quiz.id')
            ->leftJoin('question_image','question.id','question_image.id')
            ->leftJoin('image','question_image.image','image.image')
            ->where('question.quiz_id', $id_topik)
            ->get();

        if($query->isEmpty())
        {
            return response()->json(
                [
                    'data'=>null,
                    'errors'=>[
                        'code'=>1,
                        'msg'=>'Pertanyaan tidak ada'
                    ],
                ], 404
            );
        }

        $expiration=0;
        $id_modul_get='';
        foreach ($query as $key=>$data)
        {
            $expiration=$data->expiration;
            $id_modul_get=$data->quiz_id;
            if($data->name!=null)
            {
                $base_url=url('/').'/upload/'.$data->name;
                $data->name=$base_url;
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
            'id_topik'=>$id_modul_get,
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
                'id_topik'=>'required'
            ]);
        $session_id=$request->input('session_id');
        $answer=$request->input('answer');
        $user_id=$request->input('user_id');
        $id_topik=$request->input('id_topik');

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
//            Check apakah pengguna pernah menjawab quiz sebelumnya
            $status = DB::table('quiz_session')->select('quiz_id', 'id')
                ->where('quiz_id',$id_topik)
                ->where('id',$user_id)->first();

            if($status)
            {

                if($status->quiz_id==$id_topik && $status->id==$user_id)
                {
//                Quiz SUdah dijawab
                    return response()->json(
                        [
                            'data'=>null,
                            'errors'=>[
                                'code'=>2,
                                'msg'=>'Quiz Sudah Pernah Dijawab'
                            ],
                        ], 404
                    );

                }
                else
                {
                    $insert=DB::table('quiz_session')->insert(
                        ['id_session' => $session_id,'starting_time'=>$time,'quiz_id'=>$id_topik,'id'=>$user_id,'wrong_count'=>$wrong,'correct_count'=>$correct,'score'=>$final_point]
                    );

                    if($insert)
                    {
                        Cache::forget($session_id);
                        return response()->json(
                            [
                                'status'=>'success',
                                'msg'=>'Jawaban Sudah Dis Submit',
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
                                'data'=>null,
                                'errors'=>[
                                    'code'=>1,
                                    'msg'=>'Gagal menyimpan jawaban'
                                ],
                            ], 404
                        );
                    }
                }
            }
            else
            {
                $insert=DB::table('quiz_session')->insert(
                    ['id_session' => $session_id,'starting_time'=>$time,'quiz_id'=>$id_topik,'id'=>$user_id,'wrong_count'=>$wrong,'correct_count'=>$correct,'score'=>$final_point]
                );

                if($insert)
                {
                    Cache::forget($session_id);
                    return response()->json(
                        [
                            'status'=>'success',
                            'msg'=>'Jawaban Sudah Dis Submit',
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
                            'data'=>null,
                            'errors'=>[
                                'code'=>1,
                                'msg'=>'Gagal menyimpan jawaban'
                            ],
                        ], 404
                    );
                }
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
