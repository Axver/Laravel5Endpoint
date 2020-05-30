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
    Route::post('/forgot/verifcode',
        [
            'uses'=>'ForgotController@getcode'
        ]);
    Route::post('/forgot/newpass',
        [
            'uses'=>'ForgotController@newpassword'
        ]);

    Route::get('/produk/listtraining',
        [
            'uses'=>'ProdukCOntroller@listtraining'
        ]);
    Route::get('/produk/bytraining',
        [
            'uses'=>'ProdukCOntroller@produkbytraining'
        ]);
    Route::get('/produk/bypaket',
        [
            'uses'=>'ProdukCOntroller@paketbytraining'
        ]);
    Route::post('/produk/pembelian',
        [
            'uses'=>'ProdukCOntroller@pembelian'
        ]);
    Route::post('/produk/verifikasi',
        [
            'uses'=>'ProdukCOntroller@verifikasi'
        ]);
    Route::post('/modul/add',
        [
            'uses'=>'ModulController@add'
        ]);
    Route::get('/modul/byproduk',
        [
            'uses'=>'ModulController@produkmodul'
        ]);
    Route::get('/modul/video',
        [
            'uses'=>'ModulController@videomodul'
        ]);
    Route::get('/quiz/getquiz',
        [
            'uses'=>'QuizController@quiz'
        ]);





}
);

