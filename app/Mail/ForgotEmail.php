<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class ForgotEmail extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($code,$email)
    {
        $this->variable  = $code;
        $this->variable2 = $email;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->from('developer@ujicoba.com')
            ->view('emailreset')
            ->with(
                [
                    'kode' => $this->variable,
                    'email' => $this->variable2,
                ]);
    }
}
