<?php

namespace App\Repositories\Api;


use App\Http\Resources\Api\AddressResource;
use App\Http\Resources\Api\ListOrderResource;
use App\Http\Resources\Api\TrackOrderResource;
use App\Interfaces\Api\OrderInterface;
use App\Libarary\CustomerPayLogic;
use App\Models\Coupon;
use App\Models\CustomerAddress;
use App\Models\Food;
use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\Restaurant;
use App\Modules\Core\Helper;
use App\Modules\Core\HTTPResponseCodes;
use http\Env\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Stripe\OrderItem;

class OrderRepository implements OrderInterface
{

    public  function calcualate_order_amount($request){
        $product_price=0;
        $cart_items=json_decode($request['cart_items'], true);
        foreach ($cart_items as $key => $value) {
            $product_price +=  $value['price']* $value['quantity'];
        }
        if($request->has('coupon_code')) {
            $coupon = Coupon::active()->where(['code' => $request['coupon_code']])->first();
            if (isset($coupon['min_purchase'])) {
                if ($product_price < $coupon['min_purchase']) {
                    /*return response()->json([
                        'status' => false,
                        'errors' => __('min_purchase to apply coupon is ') . $coupon['min_purchase'],
                        'message' => __('min_purchase to apply coupon is ') . $coupon['min_purchase'],
                        'data' => [],
                        'code' => 407
                    ], HTTPResponseCodes::Sucess['code']);*/
                    return (array('status'=>false,'msg'=> __('min_purchase to apply coupon is ') . $coupon['min_purchase']));
                }

            }
        }
        $restaurant=Restaurant::find($request->restaurant_id);

        $coupon_discount_amount =isset( $coupon) ? Helper::get_discount($coupon, $product_price) : 0;

        $total_price = $product_price- $coupon_discount_amount ;
        $tax = $restaurant->tax;
        $total_tax_amount= ($tax > 0)?(($total_price * $tax)/100):0;
        $shipping_coast=$restaurant->shipping_coast;

        if(($restaurant['minimum_order']) > $product_price )
        {
            /* return response()->json([
                 'status' =>false,
                 'errors'=>__('not_found'),
                 'message' =>__('you_need_to_order_at_least amount') ."  ".$restaurant->minimum_order,
                 'data' => [],
                 'code'=>408
             ],HTTPResponseCodes::Sucess['code']);*/
            return( array('status'=>false,'msg'=>__('you_need_to_order_at_least amount') ."  ".$restaurant->minimum_order));
        }

        if(isset($coupon))
        {
            $coupon->increment('total_uses');
        }
        $order_amount = round($total_price + $total_tax_amount + $shipping_coast,2 );//config('round_up_to_digit')
        $data=['status'=>'true','order_amount'=>$order_amount,'total_price'=>$total_price,'coupon_discount_amount'=>$coupon_discount_amount,'tax'=>$tax];

        return($data);


    }
    public function payment_success()
    {
        //   echo   Session::get('order_id'); exit;

        $order = Order::find(Session::get('order_id'));

        $order->order_status='confirmed';
        $order->payment_method='stripe';
        $order->transaction_reference=Session::get('transaction_id');
        $order->payment_status='paid';
        $order->confirmed=now();
        $order->save();
        try {
            //  Helper::send_order_notification($order);
        } catch (\Exception $e) {

        }
        return true;
    }
    public function cart_order($request)
    {

        //print_r($request->all());

        // TODO: Implement cart_order() method.

        $coupon = null;
        $free_delivery_by = null;
        $schedule_at = $request['schedule_at']?\Carbon\Carbon::parse($request['schedule_at']):now();
        if($request['schedule_at']&& $schedule_at < now())
        {
            return response()->json([
                'status' =>false,
                'errors'=>__('order_time'),
                'message' =>__('you_can_not_schedule_a_order_in_past'),
                'data' => [],
                'code'=>406
            ],HTTPResponseCodes::Sucess['code']);


        }


        $restaurant = Restaurant::selectRaw('*, IF(((select count(*) from `restaurant_schedule` where `restaurants`.`id` = `restaurant_schedule`.`restaurant_id` and `restaurant_schedule`.`day` = '.$schedule_at->format('w').' and `restaurant_schedule`.`opening_time` < "'.$schedule_at->format('H:i:s').'" and `restaurant_schedule`.`closing_time` >"'.$schedule_at->format('H:i:s').'") > 0), true, false) as open')->where('id', $request->restaurant_id)->first();
        if(!$restaurant)
        {
            return response()->json([
                'status' =>false,
                'errors'=>__('restaurant_not_found'),
                'message' =>HTTPResponseCodes::BadRequest['message'],
                'data' => [],
                'code'=>HTTPResponseCodes::BadRequest['code']
            ],HTTPResponseCodes::Sucess['code']);

        }
        /* if($restaurant->open == false)
         {
             echo "kjkj"; exit;
             return response()->json([
                 'status' =>HTTPResponseCodes::InvalidArguments['status'],
                 'message' => trans('messages.restaurant_is_closed_at_order_time'),
                 'errors' => [],

                 'code'=>HTTPResponseCodes::InvalidArguments['code']
             ],HTTPResponseCodes::InvalidArguments['code']);

         }*/

        // start cupon
        if ($request['coupon_code']) {
            $coupon = Coupon::active()->where(['code' => $request['coupon_code']])->first();
            if(isset($coupon['min_purchase']))
            {
                if($request['amount']< $coupon['min_purchase'])
                {
                    return response()->json([
                        'status' =>false,
                        'errors'=>__('min_purchase to apply coupon is ').$coupon['min_purchase'],
                        'message' =>__('min_purchase to apply coupon is ').$coupon['min_purchase'],
                        'data' => [],
                        'code'=>407
                    ],HTTPResponseCodes::Sucess['code']);
                }

            }
            if (isset($coupon)) {
                $staus = Helper::is_valide($coupon, $request->user()->id ,$request['restaurant_id']);
                if($staus==407)
                {
                    return response()->json([
                        'status' =>false,
                        'errors'=>__('coupon_expire'),
                        'message' =>__('coupon_expire'),
                        'data' => [],
                        'code'=>407
                    ],HTTPResponseCodes::Sucess['code']);

                }
                else if($staus==406)
                {
                    return response()->json([
                        'status' =>false,
                        'errors'=>__('coupon_usage_limit_over'),
                        'message' =>__('coupon_usage_limit_over'),
                        'data' => [],
                        'code'=>406
                    ],HTTPResponseCodes::Sucess['code']);

                }
                else if($staus==404)
                {
                    return response()->json([
                        'status' =>false,
                        'errors'=>__('not_found'),
                        'message' =>'coupon not_found',
                        'data' => [],
                        'code'=>HTTPResponseCodes::BadRequest['code']
                    ],HTTPResponseCodes::Sucess['code']);
                }
                /* if($coupon->coupon_type == 'free_delivery')
                 {
                     $delivery_charge = 0;
                     $coupon = null;
                     $free_delivery_by = 'admin';
                 }*/
            } else {
                return response()->json([
                    'status' =>false,
                    'errors'=>[],
                    'message' =>__('coupon not_found'),
                    'data' => [],
                    'code'=>HTTPResponseCodes::BadRequest['code']
                ],HTTPResponseCodes::Sucess['code']);
            }
        }
        // end cupon


        if($request['order_type'] == 'take_away')
        {
            $shipping_coast=0;
        }else{
            $shipping_coast=$restaurant->shipping_coast;
        }
        if(isset($request['address']))
        {
            $user_id=Auth::guard('api')->user()->id;

            $address_data=$request['address'];
            $address_data['user_id']= $user_id;//array('user_id'=>$user_id,'contact_person_number'=>'ahmed','address'=>'tiyleklj','contact_person_name'=>'contact_person_name','floor'=>'floor','road','house'=>'house');



            $order_address=CustomerAddress::insert((array)$address_data);


        } else
        {
            $order_address=$request->address_id;
        }
        $coupon_discount_amount=0;

        /* $coupon_discount_amount = $coupon ? CouponLogic::get_discount($coupon, $product_price + $total_addon_price - $restaurant_discount_amount) : 0;
         $total_price = $product_price + $total_addon_price - $restaurant_discount_amount - $coupon_discount_amount ;

         $tax = $restaurant->tax;
         $total_tax_amount= ($tax > 0)?(($total_price * $tax)/100):0;

         if($restaurant->minimum_order > $product_price + $total_addon_price )
         {
             return response()->json([
                 'errors' => [
                     ['code' => 'order_time', 'message' => trans('messages.you_need_to_order_at_least', ['amount'=>$restaurant->minimum_order.' '.Helpers::currency_code()])]
                 ]
             ], 406);
         }*/
        DB::beginTransaction();
        try {
            $order = new Order();
            $order->user_id = Auth::guard('api')->user()->id;
            $order->order_amount = $request['order_amount'];
            $order->coupon_discount_amount = $coupon_discount_amount;
            if (isset($request['address'])) {
                $order->delivery_address_id = $order_address;
            } else {
                $order->delivery_address_id = $order_address;
            }
            $order->order_note = $request->order_note;
            $order->restaurant_id = $request->restaurant_id;
            $order->delivery_charge = $shipping_coast;
            $order->payment_method = $request->payment_method;
            $order->payment_status = $request['payment_method']=='wallet'?'paid':'unpaid';
            $order->order_status = $request['payment_method']=='digital_payment'?'failed':($request->payment_method == 'wallet'?'confirmed':'pending');
            $order->pending = now();
            $order->confirmed = $request->payment_method == 'wallet' ? now() : null;
            $order->created_at = now();
            $order->updated_at = now();



            //cart_items= (array) $request->cart_items;//array('food_id' => 1, 'quantity' => 2, 'price' => 80));
            $product_price=0;
            $cart_items=$request['cart_items'];
            foreach ($cart_items as $key => $value) {
                $product_price +=  $value['price']* $value['quantity'];
            }
            $coupon_discount_amount = $coupon ? Helper::get_discount($coupon, $product_price) : 0;
            $total_price = $product_price- $coupon_discount_amount ;
            $tax = $restaurant->tax;
            $total_tax_amount= ($tax > 0)?(($total_price * $tax)/100):0;

            if($restaurant->minimum_order > $product_price )
            {
                return response()->json([
                    'status' =>false,
                    'errors'=>__('not_found'),
                    'message' =>__('you_need_to_order_at_least amount') ."  ".$restaurant->minimum_order,
                    'data' => [],
                    'code'=>408
                ],HTTPResponseCodes::Sucess['code']);
            }
            if($coupon)
            {
                $coupon->increment('total_uses');
            }
            $order_amount = round($total_price + $total_tax_amount + $shipping_coast,2 );//config('round_up_to_digit')

            if($request->payment_method == 'wallet' && $request->user()->wallet_balance < $order_amount)
            {


                return response()->json([
                    'status' =>false,
                    'errors'=>__('insufficient_balance'),
                    'message' =>__('insufficient_balance'),
                    'data' => [],
                    'code'=>409
                ],HTTPResponseCodes::Sucess['code']);
            }

            try {
                $order->coupon_discount_amount = round($coupon_discount_amount, 2);//config('round_up_to_digit')
                $order->coupon_discount_title = $coupon ? $coupon->title : '';
                // $order->free_delivery_by = $free_delivery_by;
                // $order->restaurant_discount_amount= round($restaurant_discount_amount, config('round_up_to_digit'));
                $order->total_tax_amount = round($total_tax_amount, 2);//config('round_up_to_digit')
                $order->order_amount = $order_amount;
                $order->save();

                $last_order = $order->id;

                Session::put('order_id', $last_order);

                foreach ($cart_items as $key => $value) {

                    $food = food::where('id', $value['food_id'])->first();
                    $order_item = new OrderDetail();
                    $order_item->food_id = $food['id'];
                    $order_item->food_details = json_encode($food);
                    $order_item->quantity = $value['quantity'];
                    $order_item->price = $value['price'];
                    $order_item->order_id = $last_order;
                    $order_item->save();
                }
                DB::commit();
                //Helper::send_order_notification($order);
                //$restaurant->increment('total_order');
                if ($request->payment_method == 'wallet') CustomerPayLogic::create_wallet_transaction($order->user_id, $order->order_amount, 'order_place', $order->id);

                try {
                    if ($order->order_status == 'pending') {
                        //  Mail::to($customer['email'])->send(new \App\Mail\OrderPlaced($order->id));
                    }
                } catch (\Exception $ex) {
                    info($ex);
                }
                return response()->json([
                    'status' =>HTTPResponseCodes::Sucess['status'],
                    'errors'=>[],
                    'message' =>__('order_placed_successfully'),
                    'data' => ['order_id'=>$order->id,'total_amount'=>$order_amount],
                    'code'=>200
                ],HTTPResponseCodes::Sucess['code']);


            } catch (\Exception $e) {
                info($e);
                return response()->json([$e], 403);
            }
            return response()->json([
                'status' =>false,
                'errors'=>[],
                'message' =>__('failed_to_place_order'),
                'data' => ['order_id'=>$order->id,'total_amount'=>$order_amount],
                'code'=>403
            ],HTTPResponseCodes::Sucess['code']);
            // return true;

        } catch (\Exception $e) {
            DB::rollback();
            return false;
            //  return redirect()->back()->withErrors(['error' => $e->getMessage()]);
            // something went wrong
        }
    }


    public function get_pervious_address($user_id)
    {
        // TODO: Implement get_pervious_address() method.

        // return
        $adds= CustomerAddress::where('user_id',$user_id)->get();
        return AddressResource::collection($adds);
    }
    public function get_address($user_id,$address_id)
    {
        // TODO: Implement get_pervious_address() method.

        // return
        $adds= CustomerAddress::where(['user_id'=>$user_id,'id'=>$address_id])->get()->first();

        return  new AddressResource($adds);
    }
    public function track_order($order_id,$user_id)
    {
        // TODO: Implement track_order() method.
        // DB::enableQueryLog();
        $order = Order::with(['restaurant'])->withCount('details')->where(['id' => $order_id, 'user_id' => $user_id])->first();

        // $query= DB::getQueryLog();
        //print_R($orderc); exit;
        if ($order) {
            return  new TrackOrderResource($order);
            //  $order['restaurant'] = $order['restaurant'] ? Helper::restaurant_data_formatting($order['restaurant']) : $order['restaurant'];
            //  $order['delivery_address'] = $order['delivery_address']?json_decode($order['delivery_address']):$order['delivery_address'];
        } else {
            return false;
        }
        ;
        return ($order);
    }


    public function list_($request, $user_id)
    {
        // TODO: Implement list() method.
        //DB::enableQueryLog();
        $order = Order::with(['restaurant'])->where (function ($query) use($request){
            if($request->has('current_order')&& ($request->current_order==1)){
                $query->whereIn('order_status',array('pending','processing','picked_up'));
            }elseif ($request->has('latest_order')){
                $query->where('order_status',array('delivered'));
            }else{
                $query->whereIn('order_status',array('delivered','canceled'));
            }


        })->where('user_id' , $user_id)
            -> withCount('details')
            -> orderBy('id','desc')
            ->paginate($request->limit, ['*'], 'page', $request->offset);
        // print_r($order); exit;
        //  $query=   DB::getQueryLog($order);
        // print_r($query); exit;

        return ListOrderResource::collection($order);
        /*  return [
              'total_size' =>$order->total(),
              'limit' => $request->limit,
              'offset' =>  $request->offset,
              'restaurants' => $order->items()
          ];*/

    }

    public function cancel_order($order_id)
    {
        // TODO: Implement cancle_order() method.
        $order= Order::with(['restaurant'])->where(['id'=>$order_id,'order_status'=>'pending'])->first();
        if(!$order)
            return false;

        Order::where('id',$order_id)->update(['order_status'=>'canceled','canceled'=>now()]);
        return true;
    }

    public function get_order_details($order_id)
    {
        // TODO: Implement get_order_details() method.
        $details = OrderDetail::where(['order_id' =>$order_id])->get();
        foreach ($details as $det) {
            $det['product_details'] = json_decode($det['product_details'], true);
        }
        return $details;
    }


}
