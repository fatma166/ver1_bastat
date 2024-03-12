<?php

namespace App\Repositories\Api;
use App\Http\Resources\Api\ListFoodResource;
use App\Interfaces\Api\FoodInterface;
use App\Models\Food;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FoodRepository implements FoodInterface
{
    public function get_food($zone_ids,$restaurant_id,$category_ids,$limit,$offset,$location,$filter_data)
    {

        // TODO: Implement get_food() method.
      //  DB::enableQueryLog();
        $paginator= Food::active()
           /* ->whereHas('restaurant', function($q)use($zone_ids,$location){

               // $q->whereIn('zone_id', $zone_ids);
              //  $q->WithLocation($location);
            })*/
           ->when($restaurant_id, function($query) use($restaurant_id){
               if($restaurant_id!="all")
               return $query->where('restaurant_id', $restaurant_id);
           })
            ->when($category_ids, function($query)use($category_ids) {
                if ($category_ids != "all"){
                    $query->whereHas('category', function ($q) use ($category_ids) {
                        //   print_r($category_ids); exit;
                        return $q->where('categories.id', $category_ids)->orWhere('parent_id', $category_ids);
                    });
                }
            });
        $paginator= $paginator->where(function ($query) use ($filter_data) {
                              if (($filter_data != []) && ($filter_data != "all")) {
                                  foreach ($filter_data as $filter_item => $value) {

                                      if ($filter_item == "compilation_id") {
                                         // echo $value; exit;
                                          $paginator = $query->whereHas('restaurant', function ($q) use ($filter_item, $value) {
                                              //   print_r($category_ids); exit;
                                              return $q->where('restaurants.compilation_id', $value);
                                          });
                                      } elseif($filter_item=="name") {
                                          $paginator = $query->where($filter_item, 'like', '%' . $value . '%');
                                      }
                                      elseif ($filter_item=="except_id") {
                                          $paginator= $query->where('id','!=',$value);
                                      }else
                                      {
                                          $paginator = $query->where($filter_item,$value);
                                      }
                                  }

                              }
                     });

           /* ->where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->orWhere('name', 'like', "%{$value}%");
                }
            })*/
        $foods=$paginator->paginate($limit, ['*'], 'page', $offset);

     //  print_r( DB::getQueryLog()); exit;
       //print_r($foods); exit;
        return ListFoodResource::collection($foods);
       /* $data =  [
            'total_size' => $foods->total(),
            'limit' => $limit,
            'offset' => $offset,
            'products' => $foods->items()
        ];*/

     //   return($data);exit;

    }

    public function single_food($food_id,$related_limit)
    {
        // TODO: Implement single_food() method.
        return  $food= Food::active()->with('slider')->find($food_id);


    }


}
