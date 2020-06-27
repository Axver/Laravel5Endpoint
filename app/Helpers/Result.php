<?php


namespace App\Helpers;

class Result {

    private $fails = array();

    public static function success($payload){
        return [
            "payload" => $payload,
            "errors" => [] 
        ];
    }

    public static function failed($code, $message){
        return [
            "payload" => null,
            "errors" => [
                [
                    "code" => $code,
                    "message" => $message
                ]
            ]
        ];
    }

    public function fail($code, $message){
        array_push($this->fails, [
            'code' => $code,
            'message' => $message
        ]);
    }

    public function result(){
        return [
            "payload" => null,
            "errors" => $this->fails
        ];
    }

}