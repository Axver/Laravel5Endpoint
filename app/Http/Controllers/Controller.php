<?php

namespace App\Http\Controllers;

use App\Helpers\Result;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\JsonResponse;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs;
    use ValidatesRequests {
        buildFailedValidationResponse as protected oldBuildFailedValidationResponse;
    }

    protected function formatValidationErrors(Validator $validator) : array
    {
        $res = new Result();
        $errors = $validator->failed();
        foreach($errors as $field => $rules){
            foreach($rules as $rule => $content){
                $newContent = "";
                if(is_array($content)){
                    $newContent .= join(", ", $content);
                }else{
                    $newContent = $content;
                }
                $res->fail("$field.$rule", $newContent);
            }
        }
        return $res->result();
    }

    protected function buildFailedValidationResponse(Request $request, array $errors)
    {
        if($request->expectsJson()){
            return new JsonResponse($errors, 200);
        }
        return $this->oldBuildFailedValidationResponse($request, $errors);
    }

    protected function addedSuccess($payload){
        return request()->json(Result::success($payload), 201);
    }

    protected function success($payload){
        return response()->json(Result::success($payload), 200);
    }

    protected function failure($code, $message){
        return response()->json(Result::failed($code, $message), 202);
    }

    protected function system_failure($message){
        return response()->json($message, 500);
    }

    protected function getTrainingEnum($id){
        if($id == 1) return "Webinar";
        if($id == 2) return "E-Learning";
        if($id == 3) return "OJD";
    }

}
