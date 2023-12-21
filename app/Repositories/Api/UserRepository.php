<?php

namespace App\Repositories\Api;
use App\CentralLogics\Helpers;
use App\Http\Resources\Api\UserInfoResource;
use App\Interfaces\Api\BannerInterface;
use App\Interfaces\Api\CategoryInterface;
use App\Interfaces\Api\UseInterface;
use App\Models\Banner;
use App\Models\Category;
use App\Models\CustomerAddress;
use App\Models\Food;
use App\Models\Restaurant;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class UserRepository implements UseInterface
{

    public function add_new_address($request,$zone_ids,$type)
    {

        // TODO: Implement list_cats() method.
        if($request->has('address_id'))
            $address_id=$request->address_id;
        $address[ 'user_id']=Auth::->user()->id;
        if($request->has('contact_person_number'))
        $address[ 'contact_person_number']=$request->contact_person_number;
        if($request->has('address'))
        $address[ 'address']=$request->address;
        if($request->has('floor'))
        $address[ 'floor']=$request->floor;
        if($request->has('road'))
        $address[ 'road']=$request->road;
        if($request->has('house'))
        $address [ 'house']=$request->house;
        $address [ 'longitude']=$request->longitude;
        $address [ 'latitude']=$request->latitude;
        $address [ 'zone_id']=$zone_ids[0];
        $address['created_at'] = now();
        $address['updated_at'] = now();



        if($type=='update') {
            $id = auth()->user()->id;
            DB::table('customer_addresses')->where(['id'=> $address_id,'user_id'=>$id])->update($address);
        }else{
            DB::table('customer_addresses')->insert($address);
        }
         return true;

    }

    public function delete_address($address_id)
    {
        // TODO: Implement delete_address() method.
        if (DB::table('customer_addresses')->where(['id' => $address_id, 'user_id' => auth()->user()->id])->first()) {
            DB::table('customer_addresses')->where(['id' => $address_id, 'user_id' => auth()->user()->id])->delete();
            return true;
        }
        return false;
    }

    public function info($request)
    {
        // TODO: Implement info() method.
        $user_id=auth()->user()->id;
        $user_info=User::where('id',$user_id)->first();
        return new UserInfoResource($user_info);
    }


}
