<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Stripe\Stripe;

class StripeController extends Controller
{
    public function charge(Request $request)
    {
        Stripe::setApiKey(config('stripe.secret_key'));

        $amount = $request->input('amount');
        $currency = 'USD'; // Change to your desired currency

        try {
            $charge = \Stripe\Charge::create([
                'amount' => $amount,
                'currency' => $currency,
                'source' => $request->input('stripeToken'),
            ]);

            // Process successful charge

            return response()->json(['message' => 'Payment successful']);

        } catch (\Stripe\Exception\CardException $e) {
            // Handle card error
        } catch (\Stripe\Exception\RateLimitException $e) {
            // Handle rate limit error
        } catch (\Stripe\Exception\InvalidRequestException $e) {
            // Handle invalid request error
        } catch (\Stripe\Exception\AuthenticationException $e) {
            // Handle authentication error
        } catch (\Stripe\Exception\ApiConnectionException $e) {
            // Handle API connection error
        } catch (\Stripe\Exception\ApiErrorException $e) {
            // Handle generic API error
        }

        return response()->json(['message' => 'Payment failed']);
    }
    public function makePayment(Request $request)

    {

        try{

            /* Instantiate a Stripe Gateway either like this */

            $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET'));

            $charge = $stripe->charges->create([

                'card' => $request->nonce,

                'currency' => 'USD',

                'amount' => ($request->amount * 100),

                'description' => "New Payment Received from mobile app",

                'metadata' => [

                    "order_id" => 1111,

                    "others" => "You can add anything metadata"

                ]

            ]);

            if($charge->status == 'succeeded') {

                $data = ['transaction_id' => $charge->id];

                return ['success'=>1,'message'=>'Transaction Success','data'=>$data];

            }else{

                return ['success'=>0,'message'=>'Card not charge, Please try again later','data'=>[]];

            }

        }catch(Exception $e){

            return ['success'=>0,'message'=>"Error Processing Transaction",'data'=>[]];

        }

    }


}


