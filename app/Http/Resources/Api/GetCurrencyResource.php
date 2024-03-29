<?php

namespace App\Http\Resources\Api;

use Illuminate\Http\Resources\Json\JsonResource;

class GetCurrencyResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {

        //  return parent::toArray($request);
        return [
            'id'=>$this->id,
            'currency_code'=>__($this->currency_code)??"",
            'currency_symbol'=>$this->currency_symbol??"",


        ];

    }
}
