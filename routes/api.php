<?php

use Illuminate\Http\Request;


Route::group(['prefix'=>'v1'],function()
{
    Route::post('/user/register',
        [
            'uses'=>'AuthController@store'
        ]);

    Route::post('/user/signin',
        [
            'uses'=>'AuthController@signin'
        ]);

    Route::get('/user/profile',
        [
            'uses'=>'ProfileController@profile'
        ]);

    Route::post('/user/addprofile',
        [
            'uses'=>'ProfileController@newinfo'
        ]);
    Route::post('/user/editprofile',
        [
            'uses'=>'ProfileController@edit'
        ]);
    Route::post('/forgot/sendcode',
        [
            'uses'=>'ForgotController@sendmail'
        ]);



}
);

