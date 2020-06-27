<?php

namespace App\Helpers;

class Validator {

    public static function isExist($value) : bool{
        return $value != null;
    }


}