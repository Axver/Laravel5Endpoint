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
    Route::post('/user/logout',
        [
            'uses'=>'AuthController@logout'
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
    Route::get('/produk/topikperpaket',
        [
            'uses'=>'ProdukCOntroller@topikfrompaket'
        ]);
    Route::post('/produk/pembelian',
        [
            'uses'=>'ProdukCOntroller@pembelian'
        ]);
    Route::post('/produk/verifikasi',
        [
            'uses'=>'ProdukCOntroller@verifikasi'
        ]);
    Route::post('/produk/uploadbukti',
        [
            'uses'=>'ProdukCOntroller@uploadbukti'
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
    Route::post('/quiz/answer',
        [
            'uses'=>'QuizController@answer'
        ]);
    Route::post('/image/upload',
        [
            'uses'=>'FileController@upload'
        ]);
    Route::post('/pdf/upload',
        [
            'uses'=>'PdfController@uploadexlusive'
        ]);
    Route::post('/pdf/listbymodul',
        [
            'uses'=>'PdfController@modul_exlusive'
        ]);
    Route::post('/pdf/uploadble',
        [
            'uses'=>'PdfController@uploaddownloadble'
        ]);
    Route::post('/pdf/downbymodul',
        [
            'uses'=>'PdfController@downbymodul'
        ]);
    Route::post('/word/sertifikat',
        [
            'uses'=>'WordController@sertifikat'
        ]);





}
);

