<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
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
        return
            [    'id' => $this->id,
                //  'role_id' => RoleResource::collection($this->role_id),
                'name' => $this->name??'',
                'last_name' => $this->last_name??'',
                'email' => $this->email??'',
                'phone'=>$this->phone??'',
                'city_id' => $this->city_id??'',
                'birth_date'=>$this->birth_date??'',
                'avatar'=>$this->	avatar??'',
                'device_token'=>$this->	device_token??'',
                'join_date'=>$this->join_date??'',
                'device_info'=>$this->device_info??'',
                'last_login'=>$this->last_login??'',
                'online_flag'=>$this->online_flag??'',
                'gender'=>$this->gender??'',
                'token'=>$this->token??''

            ];
    }
}
