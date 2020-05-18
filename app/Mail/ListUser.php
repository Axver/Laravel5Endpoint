<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class ListUser extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($account_generated,$email)
    {
        $this->variable  = $account_generated;
        $this->variable2  = $email;

    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->from('developer@ujicoba.com')
            ->view('generated')
            ->with(
                [
                    'data' => $this->variable,

                ]);
    }
}
