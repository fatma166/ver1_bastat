<?php

namespace App\Repositories\Api;
use App\CentralLogics\Helpers;
use App\Http\Resources\Api\BannerResource;
use App\Interfaces\Api\BannerInterface;
use App\Models\Banner;
use App\Models\Food;
use App\Models\Restaurant;
use App\Modules\Core\Helper;
use Illuminate\Http\Request;

class BannerRepositories implements BannerInterface
{
    public function get_banner($zone_ids)
    {
        // TODO: Implement get_banner() method.

       /* if (!$request->hasHeader('zoneId')) {
            $errors = [];
            array_push($errors, ['code' => 'zoneId', 'message' => trans('messages.zone_id_required')]);
            return response()->json([
                'errors' => $errors
            ], 403);
        }*/
       // $zone_id= json_decode($request->header('zoneId'), true);
        $data = [];
        if(isset($zone_ids)&& count($zone_ids)!=0) {
            // $banners = BannerLogic::get_banners($zone_id);
            $banners = Banner::active()->whereIn('zone_id',$zone_ids)->get();

            foreach ($banners as  $banner) {
                if ($banner->type == 'restaurant_wise') {
                    $restaurant = Restaurant::find($banner->data);
                    $banner->restaurant=$restaurant ? Helper::restaurant_data_formatting($restaurant, false) : "";
                   /* $data[] = [
                        'id' => $banner->id,
                        'title' => $banner->title,
                        'type' => $banner->type,
                        'image' => $banner->image,
                        'restaurant' => $restaurant ? Helper::restaurant_data_formatting($restaurant, false) : null,
                        'food' => null
                    ];*/
                }
                if ($banner->type == 'item_wise') {
                    $food = Food::find($banner->data);
                    $banner->food=$food ? Helper::product_data_formatting($food, false, false, app()->getLocale()) : "";
                   /* $data[] = [
                        'id' => $banner->id,
                        'title' => $banner->title,
                        'type' => $banner->type,
                        'image' => $banner->image,
                        'restaurant' => null,
                        'food' =>
                    ];*/
                }
            }
        }

         return  BannerResource::collection($banners);

    }



}
