<?php

namespace App\Repositories\Admin\Vendor;

use App\Models\Order;
use App\Modules\Core\Helper;
use App\Repositories\Admin\BaseRepository;
use Carbon\Carbon;

class OrderRepository extends BaseRepository
{


    public function __construct()
    {
        parent::__construct(new Order());

    }
    public function details($id){
       /*  $data['order_amounts']=Order::where(['restaurant_id'=>$id,'order_status'=>'delivered'])->sum('order_amount');

          $data['place']= parent::show($id,['vendor','compilation'],['orders']);
          $data['orders']= Order::where('restaurant_id',$id)->with('customer--')->paginate(config('default_pagination'));
          $data['reviews']=Review::with(['customer--','food'=>function ($query) use ($id){
                                           $query->where('restaurant_id',$id);
                                        }])->paginate(config('default_pagination'));
          $data['withdraw']= WithdrawRequest::where('vendor_id',$data['place']['vendor_id'])->with('vendor')->addSelect( DB::raw('SUM(amount) AS withdraw_amount'))->get();
          $data['wallet']=RestaurantWallet::where('vendor_id',$data['place']['vendor_id'])->get();
          $data['evaluation']=Helper::calculate_restaurant_rating($data['place']['rating']);
//print_r($data); exit;
          return($data);*/

    }
   public function change_status($id,$status){

       $item= $this->model->where('id',$id)->update([$status=>Carbon::now(),'order_status'=>$status]);
       $order=$this->model->where('id',$id)->first();
       Helper::send_order_notification($order);
       return $item;

    }


}
