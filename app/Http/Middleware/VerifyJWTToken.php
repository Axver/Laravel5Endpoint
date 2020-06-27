<?php

namespace App\Http\Middleware;

use App\Helpers\Result;
use Closure;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;

class VerifyJWTToken
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        try{
            $user=JWTAuth::toUser($request->input('token'));
        }catch(TokenExpiredException $ex){
            return response()->json(['token_expired'],$ex->getStatusCode());

        }catch(TokenInvalidException $ex){
            return response()->json(['token_invalid'],$ex->getStatusCode());
        }
        catch (JWTException $e)
        {
            return response()->json(['error'=>'token_required'], 500);
        }
        return $next($request);
    }
}
