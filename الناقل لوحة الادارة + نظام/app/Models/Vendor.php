<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DB;

class Vendor extends Model
{
    use HasFactory;

    protected $table = 'vendor';

    protected $fillable = ['name','vendor_own_driver','vendor_language','image','vendor_logo','user_id','email_id','password','contact','category_id','address','lat','lang','map_address','min_order_amount','sp','mp','lp','avg_delivery_time','license_number','admin_comission_type','admin_comission_value','vendor_type','time_slot','tax','delivery_type_timeSlot','status','isExplorer','isTop','connector_type','connector_descriptor','connector_port'];

    protected $appends = ['image','category','vendor_logo','rate','review'];

    public function getImageAttribute()
    {
        return url('images/upload') . '/'.$this->attributes['image'];
    }

    public function getCategoryAttribute()
    {
        // if ($this->category_id != null)
        // {
            $categoryIds = explode(",",$this->category_id);
            $category = [];
            foreach ($categoryIds as $id)
            {
                array_push($category, Category::where('id',$id)->first(['name','image']));
            }
            return $category;
        // }
    }

    public function getVendorLogoAttribute()
    {
        return url('images/upload') . '/'.$this->attributes['vendor_logo'];
    }

    public function getRateAttribute()
    {
        $review = Review::where('vendor_id',$this->attributes['id'])->get();
        if (count($review) > 0) {
            $totalRate = 0;
            foreach ($review as $r)
            {
                $totalRate = $totalRate + $r->rate;
            }
            return round($totalRate / count($review), 1);
        }
        else
        {
            return 0;
        }
    }

    public function getReviewAttribute()
    {
        return Review::where('vendor_id',$this->attributes['id'])->count();
    }

    public function scopeGetByDistance($query, $lat, $lang, $radius)
    {
        $results = DB::select(DB::raw('SELECT id, ( 3959 * acos( cos( radians(' . $lat . ') ) * cos( radians( lat ) ) * cos( radians( lang ) - radians(' . $lang . ') ) + sin( radians(' . $lat . ') ) * sin( radians(lat) ) ) ) AS distance FROM vendor HAVING distance < ' . $radius . ' ORDER BY distance'));
        if (!empty($results))
        {
            $ids = [];
            //Extract the id's
            foreach ($results as $q)
            {
                array_push($ids, $q->id);
            }
            return $query->whereIn('id', $ids);
        }
        return $query->whereIn('id', []);
    }
}
