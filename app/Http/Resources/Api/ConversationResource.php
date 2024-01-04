<?php

namespace App\Http\Resources\Api;

use Illuminate\Http\Resources\Json\JsonResource;

class ConversationResource extends JsonResource
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
            "id"=>$this->id,
        "sender_id"=>$this-> sender_id,
        "sender_type"=> $this->sender_type,
        "receiver_id"=>$this->receiver_id,
        "receiver_type"=> $this->receiver_type,
        "last_message_id"=>$this->last_message_id,
        "last_message_time"=> $this->last_message_time,
        "unread_message_count"=>$this->unread_message_count,
       /* "sender": {
        "id": 1,
            "f_name": "fatmaapi",
            "l_name": "gh_7",
            "phone": "+2001022752344",
            "email": "fatmaghareeb@gmail.com",
            "image": null,
            "admin_id": null,
            "user_id": 2,
            "vendor_id": null,
            "deliveryman_id": null,
            "created_at": "2023-12-11T14:49:23.000000Z",
            "updated_at": "2023-12-11T14:49:23.000000Z"
        },
        "receiver": null,
        "last_message": {
        "id": 48,
            "conversation_id": 2,
            "sender_id": 1,
            "message": null,
            "file": null,
            "is_seen": false,
            "created_at": "2023-12-31T13:14:48.000000Z",
            "updated_at": "2023-12-31T13:14:48.000000Z"
            "id"=> $this->id,
            "conversation_id"=> $this->conversation_id,
            "sender_id"=>$this->sender_id,
            "message"=>$this->message,
            "file"=> $this->file,
            "is_seen"=> $this->is_seen,
            "user_id"=>$this->whenLoaded('sender', function () {
                    return   $this->sender->user_id;

                })??0,
            "created_at"=>$this->created_at*/
            ];

    }
}
