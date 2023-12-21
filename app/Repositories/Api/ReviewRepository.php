<?php

namespace App\Repositories\Api;



use App\Interfaces\Api\ReviewInterface;
use App\Models\Restaurant;
use App\Models\RestaurantReview;
use App\Models\Review;
use App\Modules\Core\Helper;
use Illuminate\Support\Facades\Auth;

class ReviewRepository implements ReviewInterface
{

  public function review($restaurant_id)
  {
      // TODO: Implement Review() method.
      $reviews = Review::with(['customer--', 'food'])
          ->whereHas('food', function($query)use($restaurant_id){
              return $query->where('restaurant_id', $restaurant_id);
          })->active()->latest()->get();

      $storage = [];
      foreach ($reviews as $item) {
          $item['attachment'] = json_decode($item['attachment']);
          $item['food_name'] = null;
          $item['food_image'] = null;
          $item['customer_name'] = null;
          if($item->food)
          {
              $item['food_name'] = $item->food->name;
              $item['food_image'] = $item->food->image;

          }
          if($item->customer)
          {
              $item['customer_name'] = $item->customer->f_name.' '.$item->customer->l_name;
          }

          unset($item['food']);
          unset($item['customer--']);
          array_push($storage, $item);
      }

      return response()->json($storage, 200);

  }
  public function add_restaurant_review($request)
  {
      // TODO: Implement add_restaurant_review() method.
       $restaurant_id=$request->restaurant_id;

       $restaurant_old_rating=Restaurant::where('id',$request->restaurant_id)->value('rating');
       $user_rating=$request->rating;
       $update_rate=Helper::update_restaurant_rating($restaurant_old_rating,$user_rating);
        Restaurant::where('id',$request->restaurant_id)->update(['rating'=>$update_rate]);
          $insert=RestaurantReview::insert(['restaurant_id'=>$restaurant_id,'rating'=>$user_rating,'comment'=>$request->comment,'user_id'=>Auth::guard('api')->user()->id]);

     /* $update_rate_toarray =(json_decode(json_encode(json_decode($update_rate)), true));

       $cal_data=Helper::calculate_restaurant_rating($update_rate_toarray);

       print_r($cal_data); exit;*/
  }

  public function get_restaurant_review($request)
  {
      // TODO: Implement get_restaurant_review() method.
      $limit=$request->limit?$request->limit:6;
      $offset=$request->offset?$request->offset:0;
      $restaurant_old_rating=Restaurant::where('id',$request->restaurant_id)->value('rating');
    //  print_r($restaurant_old_rating);
      $total_submit =  $restaurant_old_rating[0]+ $restaurant_old_rating[1]+ $restaurant_old_rating[2]+$restaurant_old_rating[3]+$restaurant_old_rating[4];
   /*   echo $total_submit;
      echo  $restaurant_old_rating[0]*5;
      echo  $restaurant_old_rating[1]*4;
      echo  $restaurant_old_rating[2]*3;
      echo  $restaurant_old_rating[3]*2;
      echo  $restaurant_old_rating[4]*1;*/
     $rate[5]= (($restaurant_old_rating[0])/ $total_submit)*100;
     $rate[4]= (($restaurant_old_rating[1])/ $total_submit)*100;
     $rate[3]= (($restaurant_old_rating[2])/ $total_submit)*100;
     $rate[2]= (($restaurant_old_rating[3])/ $total_submit)*100;
     $rate[1]= (($restaurant_old_rating[4])/ $total_submit)*100;


        $cal_data=Helper::calculate_restaurant_rating( $restaurant_old_rating);
        $cal_data['each_rate']=$rate;
       $cal_data['user_reviews']= RestaurantReview::where('restaurant_id',$request->restaurant_id)->orderBy('id','asc') ->paginate($limit, ['*'], 'page', $offset);

        return($cal_data);
  }


}
