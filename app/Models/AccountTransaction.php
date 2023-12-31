<?php

namespace App\Models;

use App\Models\DeliveryMan;
use App\Models\Restaurant;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class AccountTransaction extends Model
{
    use HasFactory;

    protected $casts = [
        'amount' => 'float',
        'current_balance' => 'float',
        'created_at' => 'datetime',
        'updated_at' => 'datetime'
    ];

    public function getRestaurantAttribute()
    {
        if($this->from_type == 'restaurant'){
            return Restaurant::find($this->from_id);
        }
        return null;
    }

    public function getDeliverymanAttribute()
    {
        if($this->from_type == 'deliveryman'){
            return DeliveryMan::find($this->from_id);
        }
        return null;
    }

}
