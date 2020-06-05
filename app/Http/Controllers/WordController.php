<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Webpatser\Uuid\Uuid;

class WordController extends Controller
{
    public function sertifikat(Request $request)
    {
        function replaceText($element, $variable, $value)
        {
            $text_class = 'PhpOffice\PhpWord\Element\Text';
            $table_class = 'PhpOffice\PhpWord\Element\Table';
            foreach ($element as $e) {
                if (get_class($e) !== $text_class && method_exists($e, 'getElements')) {
                    replaceText($e->getElements(), $variable, $value);
                } elseif (get_class($e) === $text_class && ($match_count = substr_count($e->getText(), $variable))) {
                    for ($i = 1; $i <= $match_count; $i++) {
                        $e->setText(str_replace($variable, $value, $e->getText()));
                    }
                } elseif (get_class($e) === $table_class && ($row_count = count($e->getRows()))) {
                    foreach ($e->getRows() as $row) {
                        foreach ($row->getCells() as $cell) {
                            replaceText($cell->getElements(), $variable, $value);
                        }
                    }
                }
            }
        }
        $this->validate($request,
            [
                'token'=>'required',
                'id_topik'=>'required',
            ]);

        $token=$request->input('token');
        $id_topik=$request->input('id_topik');

        if ($validate_user = DB::table('users')->select('id','name')->where('remember_token',$token)->first())
            {
                if($training = DB::table('topik')->select('nama_training')
                    ->join('training','topik.training_id','training.id')
                    ->where('topik.id',$id_topik)->first())
                {
                    $phpWord = new \PhpOffice\PhpWord\PhpWord();
                    $testWord = $phpWord->loadTemplate(public_path('/sertifikat/template.docx'));
                    $testWord->setValue('{Nama}', $validate_user->name);
                    $testWord->setValue('{Nama Training}', $training->nama_training);
                    $testWord->setValue('{Nama/Jabatan Pemberi}', 'Baru/Contoh Jabatan');
                    $uuid=Uuid::generate()->string;
                    $testWord->saveAs(public_path('/sertifikat/'.$uuid.'.'.'docx'));

//                    Simpan informasi kedalam database
                    $affected = DB::table('quiz_session')
                        ->where('quiz_id', $id_topik)
                        ->where('id',$validate_user->id)
                        ->update(['certificate' => $uuid.'.'.'docx']);

                    if($affected)
                    {
                        $response=[
                            'status'=>'success',
                            'data'=>[
                                'code'=>0,
                                'url'=>url('/').'/sertifikat/'.$uuid.'.'.'docx'
                            ]

                        ];

                        return response()->json($response,201);
                    }
                    else
                    {
                        $response=[
                            'data'=>null,
                            'errors'=>[
                                'code'=>1,
                                'msg'=>'Failed To Update Data'
                            ]

                        ];

                        return response()->json($response,404);
                    }
                }



            }
        else
        {
            $response=[
                'data'=>null,
                'errors'=>[
                    'code'=>2,
                    'msg'=>'Quiz Session Not Found'
                ]

            ];

            return response()->json($response,404);
        }
    }


}
