<?php
namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\PaymentRequest;
use App\Http\Requests\Api\WalletPaymentRequest;
use App\Http\Requests\Api\WalletTransactionListRequest;
use App\Libarary\CustomerPayLogic;
use App\Models\Coupon;
use App\Models\Food;
use App\Models\PaymentMethod;
use App\Models\Restaurant;
use App\Models\WalletTransaction;
use App\Modules\Core\HTTPResponseCodes;
use App\Repositories\Api\OrderRepository;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Modules\Core\Helper;
use Stripe\Exception\SignatureVerificationException;
use Stripe\Stripe;
use Stripe\Event;
use Stripe\PaymentIntent;
use Stripe\Webhook;

class PaymentController extends Controller {

    public function pay(PaymentRequest $request) {

        /*$data = $this->calcualate_order_amount($request);
        $amount = "";
        if (isset($data['status']) && $data['status'] == true) {
            $amount = $data['order_amount'];
        } else {
            return response()->json([
                        'status' => false,
                        'errors' => __('error'),
                        'message' => $data['msg'],
                        'data' => [],
                        'code' => 408
                            ], HTTPResponseCodes::Sucess['code']);
        }
        Stripe::setApiKey(config('stripe.secret_key'));

        //  $amount = $request->input('amount');
        $currency = 'USD'; // Change to your desired currency

        $paymentLink = \Stripe\Checkout\Session::create([
                    'payment_method_types' => ['card'],
                    'line_items' => [
                        [
                            'price_data' => [
                                'currency' => $currency,
                                'unit_amount' => $amount * 100, // Stripe requires the amount in cents
                                'product_data' => [
                                    'name' => 'Payment',
                                ],
                            ],
                            'quantity' => 1,
                        ],
                    ],
                    'mode' => 'payment',
                    'success_url' => config('app.url') . '/success',
                    'cancel_url' => config('app.url') . '/cancel',
        ]);

        return response()->json([
                    'payment_link' => $paymentLink->url,
        ]);*/


        Stripe::setApiKey(config('stripe.secret_key'));

        // Extract relevant data from the request
        $total_amount = 0;
        $product_price = 0;
        $discount= 0;
        $reference = $request->input('reference'); // reference from order not input
        $orderItems = json_decode($request->input('cart_items', []),true); // Add order items to the request
        $customerEmail = Auth::guard('api')->user()->email;//$request->input('customer_email'); // Add customer email to the request
        $voucher = $request->input('coupon_code');
        $restaurant_id = $request->input('restaurant_id');
        // Define success and cancel URLs
        $successUrl = route('payment.complete', ['reference' => $reference]);
        $cancelUrl = route('payment.complete', ['reference' => $reference]);

        // check voucher discount
        if($voucher) {

            // @todo validate discount
            if ($request['coupon_code'] && $request['coupon_code']!="null") {

                $coupon = Coupon::active()->where(['code' => $request['coupon_code']])->first();
                $staus = Helper::is_valide($coupon,Auth::guard('api')->user()->id,$restaurant_id,$orderItems);
                if ($staus == 407) {
                    return response()->json([
                        'status' => false,
                        'errors' => __('coupon_expire'),
                        'message' => __('coupon_expire'),
                        'data' => [],
                        'code' => 407
                    ], HTTPResponseCodes::Sucess['code']);

                } else if ($staus == 406) {
                    return response()->json([
                        'status' => false,
                        'errors' => __('coupon_usage_limit_over'),
                        'message' => __('coupon_usage_limit_over'),
                        'data' => [],
                        'code' => 406
                    ], HTTPResponseCodes::Sucess['code']);

                } /* if($coupon->coupon_type == 'free_delivery')
                 {
                     $delivery_charge = 0;
                     $coupon = null;
                     $free_delivery_by = 'admin';
                 }*/
                else {
                    return response()->json([
                        'status' => false,
                        'errors' => [],
                        'message' => $staus,
                        'data' => [],
                        'code' => HTTPResponseCodes::BadRequest['code']
                    ], HTTPResponseCodes::Sucess['code']);
                }
            }
              $order=new OrderRepository();
              $data=$order->calcualate_order_amount($request);
                if(isset($data['status'])&& $data['status']==true){
                    $amount=$data['order_amount'];
                    $discount=$data['coupon_discount_amount'];
                }else{
                    return response()->json([
                        'status' =>false,
                        'errors'=>__('error'),
                        'message' =>$data['msg'],
                        'data' => [],
                        'code'=>408
                    ],HTTPResponseCodes::Sucess['code']);
                }

        }

        // Prepare order item data for Stripe (adjust this based on your actual data structure)
        $lineItems = [];

        foreach ($orderItems as $item) {

            $food=Food::where('id',$item['food_id'])->first();
            $lineItems[] = [
                'price_data' => [
                    'currency' => config('app.currency'),
                    'unit_amount' => $food['price']*100,
                    'product_data' => [
                        'name' => $food['name'],
                    ],
                ],
                'quantity' => $item['quantity'],
            ];

            $product_price+= $item['quantity']*$food['price'];
        }

        $restaurant=Restaurant::find($restaurant_id);




        $tax = $restaurant->tax;
        $tax= ($tax > 0)?(($product_price * $tax)/100):0;
        $delivery_charge=$restaurant->delivery_charge;
        # Add the delivery charge to the line items list
        $lineItems[] = [
            'price_data' => [
                'currency' => config('app.currency'),
                'unit_amount' =>$delivery_charge*100,
                'product_data' => [
                    'name'=> "Delivery Charge",
                ],
            ],
            'quantity' =>1,
        ];
        # Add the delivery charge to the line items list
        $lineItems[] = [
            'price_data' => [
                'currency' => config('app.currency'),
                'unit_amount' =>$tax*100,
                'product_data' => [
                    'name'=> "tax",
                ],
            ],
            'quantity' =>1,
        ];

        $coupon = null;

        if($discount) {
            // Create a coupon code with a fixed amount off
            $coupon = \Stripe\Coupon::create([
                //'percent_off' => 0, // Set to 0 for fixed amount off
                'name' => $voucher,
                'amount_off' => $discount*100,
                'currency' => config('app.currency', 'SAR'), // Set to your desired currency
                'duration' => 'once', // Use 'once' for a one-time discount
            ]);
        }
        //print_r($lineItems);die;

        // Create PaymentIntent with additional details
        $intent = \Stripe\Checkout\Session::create([
            'currency' => config('app.currency', 'SAR'),
            'client_reference_id' => $reference,
            'metadata' => [
                'reference' => $reference,
            ],
            //'confirmation_method' => 'manual',
            //'confirm' => true,
            //'payment_method_types' => ['card'],
            //'setup_future_usage' => 'off_session',
            'mode' => 'payment',
            'success_url' => $successUrl,
            'cancel_url' => $cancelUrl,
            'line_items' => $lineItems, // Include order items
            'customer_email' => $customerEmail, // Include customer email
            'discounts' => [['coupon' => $coupon ? $coupon->id: null]],
        ]);

        /*$intent = PaymentIntent::create([
           'amount' => $total_amount - $discount,
           'currency' => config('app.currency', 'usd'),
           'metadata' => [
               'reference' => $reference,
           ],
           'confirmation_method' => 'manual',
           'confirm' => true,
           'payment_method_types' => ['card'],
           'setup_future_usage' => 'off_session',
           'line_items' => $lineItems, // Include order items
           'return_url' => $successUrl,
           //'cancel_url' => $cancelUrl,
       ]);*/

        // Generate a payment link for the transaction
        $payment_id = $intent->id;
        $paymentLink = $intent->url;

        // @todo save payment id with payment reference in table
        //cs_test_a1AH2zOFX2XMP9DUBfJGzIEVmUlyNuSTIQ2F02lkR5PWnxkyM3Bqmd8cqd

        return response()->json([
            'payment_id' => $payment_id,
            'payment_link' => $paymentLink,
        ]);
    }

    public function create_payment_wallet_link(WalletPaymentRequest $request) {


        Stripe::setApiKey(config('stripe.secret_key'));

        // Extract relevant data from the request
        $amount = $request->input('amount'); //amount
        // Define success and cancel URLs
        $reference="wallet charge";
        $successUrl = route('payment.complete', ['reference' => $reference]);
        $cancelUrl = route('payment.complete', ['reference' => $reference]);
        $currency = config('app.currency'); // Change to your desired currency

        $intent= \Stripe\Checkout\Session::create([
            'payment_method_types' => ['card'],
            'line_items' => [
                [
                    'price_data' => [
                        'currency' => $currency,
                        'unit_amount' => $amount * 100, // Stripe requires the amount in cents
                        'product_data' => [
                            'name' => 'wallet charge',
                        ],
                    ],
                    'quantity' => 1,
                ],
            ],
            'mode' => 'payment',
            'success_url' => $successUrl,
            'cancel_url' => $cancelUrl,
        ]);

        // Generate a payment link for the transaction
        $payment_id = $intent->id;
        $paymentLink = $intent->url;

        // @todo save payment id with payment reference in table
        //cs_test_a1AH2zOFX2XMP9DUBfJGzIEVmUlyNuSTIQ2F02lkR5PWnxkyM3Bqmd8cqd

        return response()->json([
            'payment_id' => $payment_id,
            'payment_link' => $paymentLink,
        ]);
    }
    public function status(Request $request) {
    // Retrieve the payment intent ID from the query parameters
    $paymentIntentId = $request->query('payment_id');

    // Retrieve the transaction ID from the Stripe API using the payment intent ID
    Stripe::setApiKey(config('stripe.secret_key'));
    $data = \Stripe\Checkout\Session::retrieve($paymentIntentId);

    if($data['payment_status']=="paid"){
        $sucess=new OrderRepository();
        $sucess->payment_success();
        //CustomerPayLogic::create_wallet_transaction(Auth::guard('api')->user()->id, $order_amount, 'order_place',$last_order);
        return response()->json([
            'status' =>true,
            'errors'=>[],
            'message' =>__('success'),
            'data' => [],
            'code'=>HTTPResponseCodes::Sucess['code']
        ],HTTPResponseCodes::Sucess['code']);
    }else{
        return response()->json([
            'status' =>false,
            'errors'=>[],
            'message' =>HTTPResponseCodes::BadRequest['message'],
            'data' => [],
            'code'=>HTTPResponseCodes::BadRequest['code']
        ],HTTPResponseCodes::Sucess['code']);
    }
    // return response()->json($data);
}

    public function wallet_status(Request $request) {

        // Retrieve the payment intent ID from the query parameters
        $paymentIntentId = $request->query('payment_id');

        // Retrieve the transaction ID from the Stripe API using the payment intent ID
        Stripe::setApiKey(config('stripe.secret_key'));
        $data = \Stripe\Checkout\Session::retrieve($paymentIntentId);

        if($data['payment_status']=="paid"){
           $db_status= CustomerPayLogic::create_wallet_transaction(Auth::guard('api')->user()->id, $data['amount_total']/100, 'wallet_charge','wallet');
            if($db_status==true) {
                return response()->json([
                    'status' => true,
                    'errors' => [],
                    'message' => __('success'),
                    'data' => [],
                    'code' => HTTPResponseCodes::Sucess['code']
                ], HTTPResponseCodes::Sucess['code']);
            }else{
                return response()->json([
                    'status' =>false,
                    'errors'=>[],
                    'message' =>__('success but db error'),
                    'data' => [],
                    'code'=>HTTPResponseCodes::BadRequest['code']
                ],HTTPResponseCodes::Sucess['code']);
            }
        }else{
            return response()->json([
                'status' =>false,
                'errors'=>[],
                'message' =>HTTPResponseCodes::BadRequest['message'],
                'data' => [],
                'code'=>HTTPResponseCodes::BadRequest['code']
            ],HTTPResponseCodes::Sucess['code']);
        }
        // return response()->json($data);
    }


    public function webhook(Request $request) {
        $payload = $request->getContent();
        $sigHeader = $request->header('Stripe-Signature');
        $endpointSecret = config('stripe.secret_key'); // Set your webhook secret

        try {
            $event = Webhook::constructEvent($payload, $sigHeader, $endpointSecret);
        } catch (SignatureVerificationException $e) {
            return response()->json(['error' => 'Invalid signature'], 400);
        }

        // Handle different event types
        switch ($event->type) {
            case 'payment_intent.succeeded':
                $paymentIntent = $event->data->object;
                // Handle successful payment
                break;
            case 'payment_intent.payment_failed':
                $paymentIntent = $event->data->object;
                // Handle failed payment
                break;
            // Add more cases for other relevant events
        }

        print_r($paymentIntent);die;

        return response()->json(['status' => 'success']);
    }

    public function payment_method(Request $request){
       $payment_methods= PaymentMethod::where('status',1)->get();
        return response()->json([
            'status' => true,
            'errors' => [],
            'message' => __('success'),
            'data' => $payment_methods,
            'code' => HTTPResponseCodes::Sucess['code']
        ], HTTPResponseCodes::Sucess['code']);
    }
    public function transactions(WalletTransactionListRequest $request)
    {

        $paginator = WalletTransaction::where('user_id', $request->user()->id)->latest()->paginate($request->limit, ['*'], 'page', $request->offset);

        $data = [
            'total_size' => $paginator->total(),
            'limit' => $request->limit,
            'offset' => $request->offset,
            'data' => $paginator->items()
        ];
        return response()->json([
            'status' => true,
            'errors' => [],
            'message' => __('success'),
            'data' => $data,
            'code' => HTTPResponseCodes::Sucess['code']
        ], HTTPResponseCodes::Sucess['code']);

    }


}
