<?php

namespace App\Http\Resources\Api;

use Illuminate\Http\Resources\Json\JsonResource;

class TrackOrderResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
       // return parent::toArray($request);
        return [
            'id'=>$this->id,
            'user_id'=>$this->user_id,
            'order_status'=>$this->order_status,
            'delivery_address_id'=>$this->delivery_address_id??0,
            'accepted'=>$this->accepted??"00:00:00",
            'confirmed'=>$this->confirmed??"00:00:00",
            'delivered'=>$this->delivered??"00:00:00",
            'picked_up'=>$this->picked_up??"00:00:00",
           // 'delivery_address'=>$this->delivery_address,
            'processing_time'=>$this->processing_time??"00:00:00",
            'details_count'=>$this->details_count??0,
            'payment_method'=>$this->payment_method??"",
            'order_note'=>$this->order_note??"",
            'restaurant_id'=>$this->restaurant_id??0,
            'restaurant_name'=>$this->restaurant->name??"",
            'delivery_time'=>$this->restaurant->delivery_time??0,
            'delivery_time_unit'=>$this->restaurant->delivery_time_unit?__($this->restaurant->delivery_time_unit):__("minutes"),
            'restaurant_logo_url'=>$this->restaurant->logo_url??"",
            'delivery_charge'=>$this->delivery_charge,
            'order_amount'=>$this->order_amount,
            'address'=> $this->whenLoaded('customer_address', function () {
                return   ( ($this->customer_address->address?$this->customer_address->address:'') ." - " .($this->customer_address->floor?$this->customer_address->floor:'')." - " .($this->customer_address->road?$this->customer_address->road:'')." - " .($this->customer_address->house?$this->customer_address->house:''));
                 //return AddressResource::collection($this->customer_address->address ." -" .$this->customer_address->floor ." -" .$this->customer_address->road ." -" .$this->customer_address->house);
            })??"",


         //

        ];
    }
}
