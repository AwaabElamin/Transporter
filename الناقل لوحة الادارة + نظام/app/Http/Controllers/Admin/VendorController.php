<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\CustomController;
use App\Mail\VendorMail;
use App\Models\Country;
use App\Models\Category;
use App\Models\DeliveryZone;
use App\Models\DeliveryZoneArea;
use App\Models\GeneralSetting;
use App\Models\Language;
use App\Models\Menu;
use App\Models\MenuCategory;
use App\Models\Order;
use App\Models\PaymentSetting;
use App\Models\SubmenuCusomizationType;
use App\Models\PromoCode;
use App\Models\Review;
use App\Models\Role;
use App\Models\Settle;
use App\Models\Submenu;
use App\Models\User;


use Session;
use App\Models\Vendor;
use App\Models\WorkingHours;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Models\Tax;
use Gate;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use DB;

class VendorController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $settings = GeneralSetting::first();
        abort_if(Gate::denies('admin_vendor_access'), Response::HTTP_FORBIDDEN, '403 Forbidden');
        $vendors = Vendor::orderBy('id','DESC')->get();
        return view('admin.vendor.vendor',compact('vendors','settings'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        abort_if(Gate::denies('admin_vendor_add'), Response::HTTP_FORBIDDEN, '403 Forbidden');
        $categorys = Category::where('status',1)->get();
        $languages = Language::whereStatus(1)->get();
        $phone_codes = Country::get();
        return view('admin.vendor.create_vendor',compact('categorys','languages','phone_codes'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
    */
    public function store(Request $request)
    {
        $data = $request->all();
        $request->validate([
            'name' => 'required',
            'email_id' => 'bail|required|email|unique:users',
            'contact' => 'bail|required|numeric|digits_between:6,12',
            'category_id' => 'bail|required',
            'address' => 'required',
            'min_order_amount' => 'required',
            'sp'=> 'required',
            'mp'=> 'required',
            'lp'=> 'required',
            'avg_delivery_time' => 'required',
            'license_number' => 'required',
            'admin_comission_value' => 'required',
            'vendor_type' => 'required',
            'time_slot' => 'required',
        ]);

        // $password = substr(str_shuffle("0123456789abcdefghijklmnopqrstvwxyz"), 0, 6);
        $password = mt_rand(100000, 999999);
        // $password = $request->phone;
        $user =  User::create([
            'name' => $request->name,
            'email_id' => $request->email_id,
            'password' => Hash::make($password),
            'status' => 1,
            'is_verified' => 1,
            'image' => 'noimage.png',
            'phone' => $request->phone,
            'phone_code' => $request->phone_code,
        ]);
        $message1 = 'عزيزنا التاجر لقد تم تسجيلك في شبكة الناقل كلمة المرور الخاصة بك هي : '.$password;
        try
        {
            Mail::to($user->email_id)->send(new VendorMail($message1));
        }
        catch (\Throwable $th)
        {

        }

        $data['category_id'] = implode(',',$request->category_id);
        if ($file = $request->hasfile('image'))
        {
            $request->validate(
            ['image' => 'max:1000'],
            [
                'image.max' => 'The Image May Not Be Greater Than 1 MegaBytes.',
            ]);
            $data['image'] = (new CustomController)->uploadImage($request->image);
        }
        else
        {
            $data['image'] = 'product_default.jpg';
        }
        if ($file = $request->hasfile('vendor_logo'))
        {
            $request->validate(
            ['vendor_logo' => 'max:1000'],
            [
                'vendor_logo.max' => 'The Image May Not Be Greater Than 1 MegaBytes.',
            ]);
            $data['vendor_logo'] = (new CustomController)->uploadImage($request->vendor_logo);
        }
        else
        {
            $data['vendor_logo'] = 'vendor-logo.png';
        }
        $data['status'] = $request->has('status') ? 1 : 0;
        $data['isTop'] = $request->has('isTop') ? 1 : 0;
        $data['isExplorer'] = $request->has('isExplorer') ? 1 : 0;
        $data['vendor_own_driver'] = $request->has('vendor_own_driver') ? 1 : 0;
        $data['user_id'] = $user->id;
        $vendor = Vendor::create($data);
        $role_id = Role::where('title','vendor')->orWhere('title','Vendor')->first();
        $user->roles()->sync($role_id);

        $start_time = strtolower(GeneralSetting::first()->start_time);
        $end_time = strtolower(GeneralSetting::first()->end_time);
        $days = array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
        for($i = 0; $i < count($days); $i++)
        {
            $master = array();
            $temp['start_time'] = $start_time;
            $temp['end_time'] = $end_time;
            array_push($master,$temp);
            $delivery_time['vendor_id'] = $vendor->id;
            $delivery_time['period_list'] = json_encode($master);
            $delivery_time['type'] = 'delivery_time';
            $delivery_time['day_index'] = $days[$i];
            $delivery_time['status'] = 1;
            WorkingHours::create($delivery_time);
        }

        $days = array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
        for($i = 0; $i < count($days); $i++)
        {
            $master = array();
            $temp['start_time'] = $start_time;
            $temp['end_time'] = $end_time;
            array_push($master,$temp);
            $pickup['vendor_id'] = $vendor->id;
            $pickup['period_list'] = json_encode($master);
            $pickup['type'] = 'pick_up_time';
            $pickup['day_index'] = $days[$i];
            $pickup['status'] = 1;
            WorkingHours::create($pickup);
        }

        $days = array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
        for($i = 0; $i < count($days); $i++)
        {
            $master = array();
            $temp['start_time'] = $start_time;
            $temp['end_time'] = $end_time;
            array_push($master,$temp);
            $selling_time['vendor_id'] = $vendor->id;
            $selling_time['period_list'] = json_encode($master);
            $selling_time['type'] = 'selling_timeslot';
            $selling_time['day_index'] = $days[$i];
            $selling_time['status'] = 1;
            WorkingHours::create($selling_time);
        }
        return redirect('admin/vendor')->with('msg','vendor addedd successfully..!!');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Vendor  $vendor
     * @return \Illuminate\Http\Response
     */
    public function show(Vendor $vendor)
    {
        abort_if(Gate::denies('admin_vendor_access'), Response::HTTP_FORBIDDEN, '403 Forbidden');
        $vendor['menu'] = Menu::where('vendor_id',$vendor->id)->get();
        return view('admin.vendor.show_vendor',compact('vendor'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Vendor  $vendor
     * @return \Illuminate\Http\Response
     */

    public function edit(Vendor $vendor)
    {
        abort_if(Gate::denies('admin_vendor_edit'), Response::HTTP_FORBIDDEN, '403 Forbidden');
        $categorys = Category::where('status',1)->get();
        $languages = Language::whereStatus(1)->get();
        $phone_codes = Country::get();
        $user = User::find($vendor->user_id);
        return view('admin.vendor.edit_vendor',compact('vendor','categorys','languages','phone_codes','user'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Vendor  $vendor
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Vendor $vendor)
    {
        $request->validate([
            'name' => 'required',
            'contact' => 'required|max:15',
            'category_id' => 'bail|required',
            'address' => 'required',
            'min_order_amount' => 'required',
            'sp'=> 'required',
            'mp'=> 'required',
            'lp'=> 'required',
            'avg_delivery_time' => 'required',
            'license_number' => 'required',
            'admin_comission_value' => 'required',
            'vendor_type' => 'required',
            'time_slot' => 'required',
        ]);
        $data = $request->all();
        $data['category_id'] = implode(',',$request->category_id);
        $user = User::find($vendor->user_id);
        $user->phone_code = $request->phone_code;
        $user->phone = $request->phone;
        $user->save();
        if ($file = $request->hasfile('image'))
        {
            $request->validate(
            ['image' => 'max:1000'],
            [
                'image.max' => 'The Image May Not Be Greater Than 1 MegaBytes.',
            ]);
            (new CustomController)->deleteImage(DB::table('vendor')->where('id', $vendor->id)->value('image'));
            $data['image'] = (new CustomController)->uploadImage($request->image);
        }
        if ($file = $request->hasfile('vendor_logo'))
        {
            $request->validate(
            ['vendor_logo' => 'max:1000'],
            [
                'vendor_logo.max' => 'The Image May Not Be Greater Than 1 MegaBytes.',
            ]);
            (new CustomController)->deleteImage(DB::table('vendor')->where('id', $vendor->id)->value('vendor_logo'));
            $data['vendor_logo'] = (new CustomController)->uploadImage($request->vendor_logo);
        }
        $data['status'] = $request->has('status') ? 1 : 0;
        $data['isTop'] = $request->has('isTop') ? 1 : 0;
        $data['isExplorer'] = $request->has('isExplorer') ? 1 : 0;
        $data['vendor_own_driver'] = $request->has('vendor_own_driver') ? 1 : 0;
        $vendor->update($data);
        return redirect('admin/vendor')->with('msg','vendor updated successfully..!!');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Vendor  $vendor
     * @return \Illuminate\Http\Response
     */
    public function destroy(Vendor $vendor)
    {
        $promoCodes = PromoCode::all();
        foreach ($promoCodes as $promoCode)
        {
            $vIds = explode(',',$promoCode->vendor_id);
            if(count($vIds) > 0)
            {
                if (($key = array_search($vendor->id, $vIds)) !== false)
                {
                    unset($vIds[$key]);
                    $promoCode->vendor_id = implode(',',$vIds);
                }
                $promoCode->save();
            }
        }

        $delivery_zone_areas = DeliveryZoneArea::all();
        foreach ($delivery_zone_areas as $delivery_zone_area)
        {
            $vIds = explode(',',$delivery_zone_area->vendor_id);
            if(count($vIds) > 0)
            {
                if (($key = array_search($vendor->id, $vIds)) !== false)
                {
                    unset($vIds[$key]);
                    $delivery_zone_area->vendor_id = implode(',',$vIds);
                }
                $delivery_zone_area->save();
            }
        }

        $users = User::all();
        foreach ($users as $user)
        {
            $favs = explode(',',$user->faviroute);
            if(count($favs) > 0)
            {
                if (($key = array_search($vendor->id, $favs)) !== false)
                {
                    unset($favs[$key]);
                    $users->faviroute = implode(',',$favs);
                }
                $user->save();
            }
        }

        $vendorUsers = User::where('vendor_id',$vendor->id)->get();
        foreach ($vendorUsers as $vendorUser) {
            $vendorUser->vendor_id = null;
            $vendorUser->save();
        }

        foreach (Menu::where('vendor_id',$vendor->id)->get() as $menu) {
            (new CustomController)->deleteImage(DB::table('menu')->where('id', $menu->id)->value('image'));
        }

        foreach (Submenu::where('vendor_id',$vendor->id)->get() as $submenu) {
            (new CustomController)->deleteImage(DB::table('submenu')->where('id', $submenu->id)->value('image'));
        }

        User::find($vendor->user_id)->delete();
        return response(['success' => true]);
    }

    public function change_status(Request $request)
    {
        $data = Vendor::find($request->id);
        if($data->status == 0)
        {
            $data->status = 1;
            $data->save();
            return response(['success' => true]);
        }
        if($data->status == 1)
        {
            $data->status = 0;
            $data->save();
            return response(['success' => true]);
        }
    }

    public function edit_delivery_time($id)
    {
        $vendor = Vendor::find($id);
        $setting = GeneralSetting::first();
        $start_time = carbon::parse($setting["start_time"])->format('h:i a');
        $end_time = carbon::parse($setting["end_time"])->format('h:i a');
        $data = WorkingHours::where([['vendor_id',$id],['type','delivery_time']])->get();
        return view('admin.vendor.edit_delivery_time',compact('vendor','setting','start_time','end_time','data'));
    }

    public function update_delivery_time(Request $request)
    {
        $data = $request->all();
        $days = WorkingHours::where([['vendor_id',$data['vendor_id']],['type','delivery_time']])->get();
        for($i = 0; $i < count($days); $i++)
        {
            $master = array();
            $start_time = [$data['start_time_'.$days[$i]['day_index']]];
            $end_time = [$data['end_time_'.$days[$i]['day_index']]];
            for ($j = 0; $j < count($start_time[0]); $j++)
            {
                $temp['start_time'] = strtolower($start_time[0][$j]);
                $temp['end_time'] = strtolower($end_time[0][$j]);
                array_push($master,$temp);
            }
            $data['vendor_id'] = $request->vendor_id;
            $data['period_list'] = json_encode($master);
            $data['type'] = 'delivery_time';
            $data['day_index'] = $days[$i]['day_index'];
            if(isset($data['status'.$days[$i]['id']]))
            {
                $data['status'] = 1;
            }
            else
            {
                $data['status'] = 0;
            }
            $days[$i]->update($data);
        }
        return redirect()->back()->with('msg','timeslots changed successfully..!!');
    }

    public function edit_pick_up_time($id)
    {
        $vendor = Vendor::find($id);
        $setting = GeneralSetting::first();
        $start_time = carbon::parse($setting["start_time"])->format('h:i a');
        $end_time = carbon::parse($setting["end_time"])->format('h:i a');
        $data = WorkingHours::where([['vendor_id',$id],['type','pick_up_time']])->get();
        return view('admin.vendor.edit_pick_up_time',compact('vendor','setting','start_time','end_time','data'));
    }

    public function update_pick_up_time(Request $request)
    {
        $data = $request->all();
        $days = WorkingHours::where([['vendor_id',$data['vendor_id']],['type','pick_up_time']])->get();
        for($i = 0; $i < count($days); $i++)
        {
            $master = array();
            $start_time = [$data['start_time_'.$days[$i]['day_index']]];
            $end_time = [$data['end_time_'.$days[$i]['day_index']]];
            for ($j = 0; $j < count($start_time[0]); $j++)
            {
                $temp['start_time'] = strtolower($start_time[0][$j]);
                $temp['end_time'] = strtolower($end_time[0][$j]);
                array_push($master,$temp);
            }
            $data['vendor_id'] = $request->vendor_id;
            $data['period_list'] = json_encode($master);
            $data['type'] = 'pick_up_time';
            $data['day_index'] = $days[$i]['day_index'];
            if(isset($data['status'.$days[$i]['id']]))
            {
                $data['status'] = 1;
            }
            else
            {
                $data['status'] = 0;
            }
            $days[$i]->update($data);
        }
        return redirect()->back()->with('msg','timeslots changed successfully..!!');
    }

    public function edit_selling_timeslot($id)
    {
        $vendor = Vendor::find($id);
        $setting = GeneralSetting::first();
        $start_time = carbon::parse($setting["start_time"])->format('h:i a');
        $end_time = carbon::parse($setting["end_time"])->format('h:i a');
        $data = WorkingHours::where([['vendor_id',$id],['type','selling_timeslot']])->get();
        return view('admin.vendor.edit_selling_timeslot',compact('vendor','setting','start_time','end_time','data'));
    }

    public function update_selling_timeslot(Request $request)
    {
        $data = $request->all();
        $days = WorkingHours::where([['vendor_id',$data['vendor_id']],['type','selling_timeslot']])->get();
        for($i = 0; $i < count($days); $i++)
        {
            $master = array();
            $start_time = [$data['start_time_'.$days[$i]['day_index']]];
            $end_time = [$data['end_time_'.$days[$i]['day_index']]];
            for ($j = 0; $j < count($start_time[0]); $j++)
            {
                $temp['start_time'] = strtolower($start_time[0][$j]);
                $temp['end_time'] = strtolower($end_time[0][$j]);
                array_push($master,$temp);
            }
            $data['vendor_id'] = $request->vendor_id;
            $data['period_list'] = json_encode($master);
            $data['type'] = 'selling_timeslot';
            $data['day_index'] = $days[$i]['day_index'];
            if(isset($data['status'.$days[$i]['id']]))
            {
                $data['status'] = 1;
            }
            else
            {
                $data['status'] = 0;
            }
            $days[$i]->update($data);
        }
        return redirect()->back()->with('msg','timeslots changed successfully..!!');
    }

    public function vendor_change_password($id)
    {
        $vendor = Vendor::find($id);
        return view('admin.vendor.change_password',compact('vendor'));
    }

    public function vendor_update_password(Request $request,$id)
    {
        $request->validate([
            'old_password' => 'required|min:6',
            'password' => 'required|min:6',
            'password_confirmation' => 'required|same:password|min:6',
        ]);
        $data = $request->all();
        $id = auth()->user();

        if(Hash::check($data['old_password'], $id->password) == true)
        {
            $id->password = Hash::make($data['password']);
            $id->save();
            return redirect('admin/home')->with('message','Password Update Successfully...!!');
        }
        else
        {
            return redirect()->back()->with('message','Old password does not match');
        }
    }
    public function vendor_tax(Request $request)
    {

        $data = $request->all();
        $settings = GeneralSetting::first();
        $settings->vendor_tax_sp = $data['sptax'];
        $settings->vendor_tax_mp = $data['mptax'];
        $settings->vendor_tax_lp = $data['lptax'];
        $settings->save();
         return redirect('admin/vendor')->with('message','Tax Update Successfully...!!');

    }

    public function finance_details($id)
    {
        $vendor = Vendor::find($id);
        $now = Carbon::today();
        $orders = array();
        for ($i = 0; $i < 7; $i++)
        {
            $order = Order::where('vendor_id',$vendor->id)->whereDate('created_at', $now)->get();
            $discount = $order->sum('promocode_price');
            $vendor_discount = $order->sum('vendor_discount_price');
            $amount = $order->sum('amount');
            $order['amount'] = $discount + $vendor_discount + $amount;
            $order['admin_commission'] = $order->sum('admin_commission');
            $order['vendor_amount'] = $order->sum('vendor_amount');
            $now =  $now->subDay();
            $order['date'] = $now->toDateString();
            array_push($orders,$order);
        }

        $currency = GeneralSetting::first()->currency_symbol;

        $past = Carbon::now()->subDays(35);
        $now = Carbon::today();
        $c = $now->diffInDays($past);
        $loop = $c / 10;
        $data = [];
        while ($now->greaterThan($past)) {
            $t = $past->copy();
            $t->addDay();
            $temp['start'] = $t->toDateString();
            $past->addDays(10);
            if ($past->greaterThan($now)) {
                $temp['end'] = $now->toDateString();
            } else {
                $temp['end'] = $past->toDateString();
            }
            array_push($data, $temp);
        }

        $settels = array();
        $orderIds = array();
        foreach ($data as $key)
        {
            $settle = Settle::where('vendor_id', $vendor->id)->where('created_at', '>=', $key['start'].' 00.00.00')->where('created_at', '<=', $key['end'].' 23.59.59')->get();
            $value['d_total_task'] = $settle->count();
            $value['admin_earning'] = $settle->sum('admin_earning');
            $value['vendor_earning'] = $settle->sum('vendor_earning');
            $value['driver_earning'] = $settle->sum('driver_earning');
            $value['d_total_amount'] = $value['admin_earning'] + $value['vendor_earning'];
            $remainingOnline = Settle::where([['vendor_id', $vendor->id], ['payment', 0],['vendor_status', 0]])->where('created_at', '>=', $key['start'].' 00.00.00')->where('created_at', '<=', $key['end'].' 23.59.59')->get();
            $remainingOffline = Settle::where([['vendor_id', $vendor->id], ['payment', 1],['vendor_status', 0]])->where('created_at', '>=', $key['start'].' 00.00.00')->where('created_at', '<=', $key['end'].' 23.59.59')->get();

            $online = $remainingOnline->sum('vendor_earning'); // admin e devana
            $offline = $remainingOffline->sum('admin_earning'); // admin e levana

            $value['duration'] = $key['start'] . ' - ' . $key['end'];
            $value['d_balance'] = $offline - $online; // + hoy to levana - devana
            array_push($settels,$value);
        }
        return view('admin.vendor.finance_details',compact('vendor', 'orders', 'currency','settels'));
    }

    public function rattings($id)
    {
        $reviews = Review::where('vendor_id',$id)->get();
        $vendor = Vendor::find($id);
        return view('admin.vendor.ratting',compact('reviews','vendor'));
    }

    public function settle(Request $request)
    {
        $data = $request->all();
        $duration = explode(' - ',$data['duration']);
        $settles = Settle::where('vendor_id',$data['vendor'])->where('vendor_status',0)->where('created_at', '>=', $duration[0].' 00.00.00')->where('created_at', '<=', $duration[1].' 23.59.59')->get();
        $vendor = Settle::where('vendor_id',$data['vendor'])->where('vendor_status',0)->where('created_at', '>=', $duration[0].' 00.00.00')->where('created_at', '<=', $duration[1].' 23.59.59')->first(['vendor_id']);
        foreach ($settles as $settle)
        {
            if(isset($data['payment_token']))
            {
                $settle->payment_token = $data['payment_token'];
                $settle->payment_type = $data['payment_type'];
            }
            $settle->payment_type = 'COD';
            $settle->vendor_status = 1;
            $settle->save();
        }
        return response(['success' => true , 'data' => $vendor->vendor_id]);
    }

    public function make_payment(Request $request)
    {
        $data = $request->all();
        $vendor = Vendor::find($request->vendor);
        $duration = explode(' - ',$data['duration']);
        $amount = Settle::where([['vendor_id', $vendor->id], ['vendor_status', 0]])->where('created_at', '>=', $duration[0].' 00.00.00')->where('created_at', '<=', $duration[1].' 23.59.59')->sum('vendor_earning');
        $paymentSetting = PaymentSetting::first();
        $duration = $data['duration'];
        $currency = GeneralSetting::first()->currency;
        return view('admin.vendor.make_payment',compact('vendor','currency','duration','amount','paymentSetting'));
    }

    public function stripePayment(Request $request)
    {
        $data = $request->all();
        $currency = GeneralSetting::find(1)->currency;
        $paymentSetting = PaymentSetting::find(1);
        $stripe_sk = $paymentSetting->stripe_secret_key;
        $currency = GeneralSetting::find(1)->currency;
        $stripe = new \Stripe\StripeClient($stripe_sk);
        $charge = $stripe->charges->create([
            "amount" => $data['payment'] * 100,
            "currency" => $currency,
            "source" => $request->stripeToken,
        ]);
        return response(['success' => true , 'data' => $charge->id]);
    }

    public function fluterPayment(Request $request)
    {
        $temp = $request->all();
        $vendor = Vendor::find($temp['vendor']);
        $data['amount'] = $temp['amount'];
        $data['email'] = $vendor->email_id;
        $data['phone'] = $vendor->contact;
        $data['name'] = $vendor->name;
        $data['duration'] = $temp['duration'];
        $data['vendor'] = $vendor->id;
        return view('admin.vendor.flutterpayment',compact('data'));
    }

    public function transction(Request $request,$duration,$vendor)
    {
        $id = $request->input('transaction_id');
        $data = $request->all();
        $duration = explode(' - ',$duration);
        $settles = Settle::where('vendor_id',$vendor)->where('vendor_status',0)->where('created_at', '>=', $duration[0].' 00.00.00')->where('created_at', '<=', $duration[1].' 23.59.59')->get();
        $vendor = Settle::where('vendor_id',$vendor)->where('vendor_status',0)->where('created_at', '>=', $duration[0].' 00.00.00')->where('created_at', '<=', $duration[1].' 23.59.59')->first(['vendor_id']);
        if($request->input('status') != 'cancelled')
        {
            foreach ($settles as $settle)
            {
                $settle->payment_token = $id;
                $settle->payment_type = 'FLUTTERWAVE';
                $settle->vendor_status = 1;
                $settle->save();
            }
        }
        return redirect('admin/finance_details/'.$vendor->vendor_id);
    }

    public function show_settalement($duration)
    {
        $duration = explode(' - ',$duration);
        $currency = GeneralSetting::first()->currency_symbol;
        $settle = Settle::where('created_at', '>=', $duration[0].' 00.00.00')->where('created_at', '<=', $duration[1].' 23.59.59')->get();
        foreach($settle as $s)
        {
            $s->date = $s->created_at->toDateString();
        }
        return response(['success' => true , 'data' => $settle , 'currency' => $currency]);
    }





    ///////////order
    public function order($id)
    {
        $total_item = 0;
        $grand_total = 0;
        Session::put('vendor_id', $id);

        if (Session::get('cart') != null)
        {
            $carts = Session::get('cart');
            foreach ($carts as $key => $cart)
            {
                $grand_total += intval($cart['price']);
                if (isset($cart['custimization']))
                {
                    foreach (json_decode($cart['custimization']) as $cust)
                    {
                        $grand_total += intval($cust->data->price);
                    }
                }
                $total_item++;
            }
        }
        $promoCodes = PromoCode::whereStatus(1)->get();
        $vendor = Vendor::where('id',$id)->first();
        $menus = Menu::where('vendor_id',$vendor->id)->orderBy('id','DESC')->get();
        $currency = GeneralSetting::first()->currency_symbol;
        $sub_menus = Submenu::whereStatus(1)->where('vendor_id',$vendor->id)->get();
        $tax = GeneralSetting::first()->isItemTax;
        foreach ($sub_menus as $submenu)
        {
            if ($tax == 0)
            {
                $price_tax = GeneralSetting::first()->item_tax;
                $disc = $submenu->price * $price_tax;
                $discount = $disc / 100;
                $submenu->price = strval($submenu->price + $discount);
            }
            else
            {
                $submenu->price = strval($submenu->price);
            }
        }
        $temps = [];
        $orderUsers = Order::where('vendor_id',$vendor->id)->get();
        foreach ($orderUsers as $orderUser)
        {
            $temp = User::find($orderUser->user_id);
            array_push($temps,$temp->id);
        }
        $vendorUsers = User::where('vendor_id',$vendor->id)->get();
        foreach ($vendorUsers as $vendorUser)
        {
            array_push($temps,$vendorUser->id);
        }
        $users = User::all();
        return view('admin.vendor.neworder',compact('id','vendor','menus','users','promoCodes','currency','sub_menus','total_item','grand_total'));
    }

    // public function change_status_order(Request $request)
    // {
    //     $status = strtoupper($request->status);
    //     $order = Order::find($request->id);
    //     $vendor = Vendor::where('id',$order->vendor_id)->first();
    //     $order->order_status = $request->status;
    //     $order->save();
    //     $user = User::find($order->user_id);
    //     if ($request->status == 'APPROVE' || $request->status == 'approve')
    //     {
    //         $start_time = Carbon::now(env('timezone'))->format('h:i a');
    //         $order->order_start_time = $start_time;
    //         $order->save();
    //     }
    //     if ($request->status == 'COMPLETE' || $request->status == 'complete')
    //     {
    //         $order->order_end_time = Carbon::now(env('timezone'))->format('h:i a');
    //         $order->payment_status = 1;
    //         $order->save();
    //         $settle = array();
    //         $settle['vendor_id'] = $order->vendor_id;
    //         $settle['order_id'] = $order->id;
    //         if ($order->payment_type == 'COD')
    //         {
    //             $settle['payment'] = 0;
    //         } else {
    //             $settle['payment'] = 1;
    //         }
    //         $settle['vendor_status'] = 0;
    //         $settle['admin_earning'] = $order->admin_commission;
    //         $settle['vendor_earning'] = $order->vendor_amount;
    //         Settle::create($settle);
    //     }
    //     if (Session::get('vendor_driver') == 0)
    //     {
    //         if ($order->delivery_type == 'HOME' && ($request->status == 'APPROVE' || $request->status == 'approve'))
    //         {
    //             $areas = DeliveryZoneArea::all();
    //             $ds = array();
    //             foreach ($areas as $value)
    //             {
    //                 $vendorss = explode(',', $value->vendor_id);
    //                 if (($key = array_search($vendor->id, $vendorss)) !== false)
    //                 {
    //                     $ts = DB::select(DB::raw('SELECT id,delivery_zone_id,( 3959 * acos( cos( radians(' . $vendor->lat . ') ) * cos( radians( lat ) ) * cos( radians( lang ) - radians(' . $vendor->lang . ') ) + sin( radians(' . $vendor->lat . ') ) * sin( radians(lat) ) ) ) AS distance FROM delivery_zone_area HAVING distance < ' . $value->radius . ' ORDER BY distance'));
    //                     foreach ($ts as $t)
    //                     {
    //                         array_push($ds, $t->delivery_zone_id);
    //                     }
    //                 }
    //             }
    //             $near_drivers = DeliveryPerson::whereIn('delivery_zone_id', $ds)->get();
    //             foreach ($near_drivers as $near_driver)
    //             {
    //                 $driver_notification = GeneralSetting::first()->driver_notification;
    //                 $driver_mail = GeneralSetting::first()->driver_mail;
    //                 $content = NotificationTemplate::where('title', 'delivery person order')->first();
    //                 $detail['drive_name'] = $near_driver->first_name . ' - ' . $near_driver->last_name;
    //                 $detail['vendor_name'] = $vendor->name;
    //                 if (UserAddress::find($order->address_id))
    //                 {
    //                     $detail['address'] = UserAddress::find($order->address_id)->address;
    //                 }
    //                 $h = ["{driver_name}", "{vendor_name}", "{address}"];
    //                 $notification_content = str_replace($h, $detail, $content->notification_content);
    //                 if ($driver_notification == 1)
    //                 {
    //                     Config::set('onesignal.app_id', env('driver_app_id'));
    //                     Config::set('onesignal.rest_api_key', env('driver_api_key'));
    //                     Config::set('onesignal.user_auth_key', env('driver_auth_key'));
    //                     try {
    //                         OneSignal::sendNotificationToUser(
    //                             $notification_content,
    //                             $near_driver->device_token,
    //                             $url = null,
    //                             $data = null,
    //                             $buttons = null,
    //                             $schedule = null,
    //                             GeneralSetting::find(1)->business_name
    //                         );
    //                     }
    //                     catch (\Throwable $th)
    //                     {

    //                     }
    //                 }
    //                 $p_notification = array();
    //                 $p_notification['title'] = 'create order';
    //                 $p_notification['user_type'] = 'driver';
    //                 $p_notification['user_id'] = $near_driver->id;
    //                 $p_notification['message'] = $notification_content;
    //                 Notification::create($p_notification);
    //                 if ($driver_mail == 1) {
    //                     $mail_content = str_replace($h, $detail, $content->mail_content);
    //                     try
    //                     {
    //                         Mail::to($near_driver->email_id)->send(new DriverOrder($mail_content));
    //                     }
    //                     catch (\Throwable $th) {
    //                     }
    //                 }
    //             }
    //         }
    //     }

    //     if ($user->language == 'العربية')
    //     {
    //         $status_change = NotificationTemplate::where('title','change status')->first();
    //         $mail_content = $status_change->arabic_mail_content;
    //         $notification_content = $status_change->arabic_notification_content;
    //         $detail['user_name'] = $user->name;
    //         $detail['order_id'] = $order->order_id;
    //         $detail['date'] = $order->date;
    //         $detail['order_status'] = $order->order_status;
    //         $detail['company_name'] = GeneralSetting::find(1)->business_name;
    //         $data = ["{user_name}","{order_id}","{date}","{order_status}","{company_name}"];

    //         $message1 = str_replace($data, $detail, $notification_content);
    //         $mail = str_replace($data, $detail, $mail_content);
    //         if(GeneralSetting::find(1)->customer_notification == 1)
    //         {
    //             if($user->device_token != null)
    //             {
    //                 try {
    //                     Config::set('onesignal.app_id', env('customer_app_id'));
    //                     Config::set('onesignal.rest_api_key', env('customer_auth_key'));
    //                     Config::set('onesignal.user_auth_key', env('customer_api_key'));
    //                     OneSignal::sendNotificationToUser(
    //                         $message1,
    //                         $user->device_token,
    //                         $url = null,
    //                         $data = null,
    //                         $buttons = null,
    //                         $schedule = null,
    //                         GeneralSetting::find(1)->business_name
    //                     );
    //                 } catch (\Throwable $th) {

    //                 }
    //             }
    //         }

    //         if (GeneralSetting::find(1)->customer_mail == 1)
    //         {
    //             try {
    //                 Mail::to($user->email_id)->send(new StatusChange($mail));
    //             } catch (\Throwable $th) {

    //             }
    //         }
    //     }
    //     else
    //     {
    //         $status_change = NotificationTemplate::where('title','change status')->first();
    //         $mail_content = $status_change->mail_content;
    //         $notification_content = $status_change->notification_content;
    //         $detail['user_name'] = $user->name;
    //         $detail['order_id'] = $order->order_id;
    //         $detail['date'] = $order->date;
    //         $detail['order_status'] = $order->order_status;
    //         $detail['company_name'] = GeneralSetting::find(1)->business_name;
    //         $data = ["{user_name}","{order_id}","{date}","{order_status}","{company_name}"];

    //         $message1 = str_replace($data, $detail, $notification_content);
    //         $mail = str_replace($data, $detail, $mail_content);
    //         if(GeneralSetting::find(1)->customer_notification == 1)
    //         {
    //             if($user->device_token != null)
    //             {
    //                 try {
    //                     Config::set('onesignal.app_id', env('customer_app_id'));
    //                     Config::set('onesignal.rest_api_key', env('customer_auth_key'));
    //                     Config::set('onesignal.user_auth_key', env('customer_api_key'));
    //                     OneSignal::sendNotificationToUser(
    //                         $message1,
    //                         $user->device_token,
    //                         $url = null,
    //                         $data = null,
    //                         $buttons = null,
    //                         $schedule = null,
    //                         GeneralSetting::find(1)->business_name
    //                     );
    //                 } catch (\Throwable $th) {

    //                 }
    //             }
    //         }

    //         if (GeneralSetting::find(1)->customer_mail == 1)
    //         {
    //             try {
    //                 Mail::to($user->email_id)->send(new StatusChange($mail));
    //             } catch (\Throwable $th) {

    //             }
    //         }
    //     }
    //     $notification = array();
    //     $notification['user_id'] = $user->id;
    //     $notification['user_type'] = 'user';
    //     $notification['title'] = $status;
    //     $notification['message'] = $message1;
    //     Notification::create($notification);

    //     if($order->delivery_type == 'SHOP')
    //     {
    //         $end_time = Carbon::now(env('timezone'))->format('h:i a');
    //         $order->order_start_time = $end_time;
    //         $order->save();
    //         if ($request->status == 'complete' || $request->status == 'COMPLETE')
    //         {
    //             $settle = array();
    //             $settle['vendor_id'] = $order->vendor_id;
    //             $settle['order_id'] = $order->id;
    //             if ($order->payment_type == 'COD')
    //             {
    //                 $settle['payment'] = 0;
    //             } else {
    //                 $settle['payment'] = 1;
    //             }
    //             $settle['vendor_status'] = 0;
    //             $settle['admin_earning'] = $order->admin_commission;
    //             $settle['vendor_earning'] = $order->vendor_amount;
    //             Settle::create($settle);
    //         }
    //     }
    //     return response(['success' => true, 'data' => ['status' => $status , 'order_id' => $order->id]]);
    // }

    public function driver_assign(Request $request)
    {
        $order = Order::find($request->order_id);
        $order->delivery_person_id = $request->driver_id;
        $order->save();
        $driver = DeliveryPerson::find($request->driver_id);
        $vendor = Vendor::where('id',Session::get('vendor_id'))->first();
        $driver_notification = GeneralSetting::first()->driver_notification;
        $driver_mail = GeneralSetting::first()->driver_mail;
        $content = NotificationTemplate::where('title', 'delivery person order')->first();
        $detail['drive_name'] = $driver->first_name . ' ' . $driver->last_name;
        $detail['vendor_name'] = $vendor->name;
        if (UserAddress::find($request->address_id))
        {
            $detail['address'] = UserAddress::find($request->address_id)->address;
        }
        $h = ["{driver_name}", "{vendor_name}", "{address}"];
        $notification_content = str_replace($h, $detail, $content->notification_content);
        if ($driver_notification == 1)
        {
            Config::set('onesignal.app_id', env('driver_app_id'));
            Config::set('onesignal.rest_api_key', env('driver_api_key'));
            Config::set('onesignal.user_auth_key', env('driver_auth_key'));
            try
            {
                OneSignal::sendNotificationToUser(
                    $notification_content,
                    $driver->device_token,
                    $url = null,
                    $data = null,
                    $buttons = null,
                    $schedule = null,
                    GeneralSetting::find(1)->business_name
                );
            } catch (\Throwable $th)
            {
            }
        }
        $p_notification = array();
        $p_notification['title'] = 'create order';
        $p_notification['user_type'] = 'driver';
        $p_notification['user_id'] = $driver->id;
        $p_notification['message'] = $notification_content;
        Notification::create($p_notification);

        if ($driver_mail == 1) {
            $mail_content = str_replace($h, $detail, $content->mail_content);
            try
            {
                Mail::to($driver->email_id)->send(new DriverOrder($mail_content));
            } catch (\Throwable $th) {
            }
        }
        return response(['success' => true]);
    }

    public function cart(Request $request)
    {
        $data = $request->all();
        $qty = 0;
        $price = 0;
        $grand_total = 0;
        $total_item = 0;
        if (Session::get('cart') == null)
        {
            if ($data['operation'] == "plus")
            {
                $master = array();
                $master['id'] = $request->id;
                $master['price'] = intval($request->price);
                $master['qty'] = 1;
                Session::push('cart', $master);
                $price = intval($request->price);
                $qty = 1;
            }
            foreach (Session::get('cart') as $key => $cart)
            {
                $grand_total += intval($cart['price']);
                $total_item++;
                if (isset($cart['custimization']))
                {
                    foreach (json_decode($cart['custimization']) as $cust)
                    {
                        $grand_total += intval($cust->data->price);
                    }
                }
            }
            return response(['success' => true, 'data' => ['if' => 'if','grand_total' => $grand_total , 'total_item' => $total_item , 'itemPrice' => $price ,'qty' => $qty]]);
        }
        else
        {
            $session = Session::get('cart');
            $submenuItem = Submenu::where('id', $request->id)->get()->first();
            $tax = GeneralSetting::first()->isItemTax;
            if ($tax == 0)
            {
                $price_tax = GeneralSetting::first()->item_tax;
                $disc = $submenuItem->price * $price_tax;
                $discount = $disc / 100;
                $original_price = strval($submenuItem->price + $discount);
            }
            else
            {
                $original_price = strval($submenuItem->price);
            }
            if (in_array($request->id, array_column(Session::get('cart'), 'id')))
            {
                foreach ($session as $key => $value)
                {
                    if ($session[$key]['id'] == $request->id)
                    {
                        if ($data['operation'] == "plus")
                        {
                            $qty = $session[$key]['qty'] + 1;
                            $price = intval($session[$key]['price']) +  intval($original_price);
                            $session[$key]['qty'] = $session[$key]['qty'] + 1;
                            $session[$key]['price'] = $session[$key]['price'] +  $original_price;
                        }
                        else
                        {
                            if (intval($session[$key]['qty']) > 0)
                            {
                                $qty = $session[$key]['qty'] - 1;
                                $price = intval($session[$key]['price']) - intval($original_price);
                                $session[$key]['qty'] = $session[$key]['qty'] - 1;
                                $session[$key]['price'] = $session[$key]['price'] - $original_price;
                            }
                            if(intval($session[$key]['qty']) == 0)
                            {
                                unset($session[$key]);
                            }
                        }
                    }
                }
            }
            else
            {
                if ($data['operation'] == "plus")
                {
                    $master = array();
                    $master['id'] = $request->id;
                    $master['price'] = intval($request->price);
                    $master['qty'] = 1;
                    $price = intval($request->price);
                    $qty = 1;
                    array_push($session, $master);
                }
            }
            Session::put('cart', array_values($session));

            foreach (Session::get('cart') as $key => $cart)
            {
                $grand_total += intval($cart['price']);
                $total_item++;
                if (isset($cart['custimization']))
                {
                    foreach (json_decode($cart['custimization']) as $cust)
                    {
                        $grand_total += intval($cust->data->price);
                    }
                }
            }
            return response(['success' => true,'data' => ['grand_total' => $grand_total , 'total_item' => $total_item , 'itemPrice' => $price , 'qty' => $qty]]);
        }
    }

    public function custimization($submenu_id)
    {
        $vendor = Vendor::where('id',Session::get('vendor_id'))->first();
        $custimization_item = SubmenuCusomizationType::where([['submenu_id',$submenu_id],['vendor_id',$vendor->id]])->get();
        $cust = '';
        $session = Session::get('cart');
        foreach ($session as $key => $item)
        {
            $k = intval($item['id']);
            if ($k == intval($submenu_id))
            {
                if(isset($item['custimization']))
                {
                    $cust = $item['custimization'];
                }
            }
        }
        $currency = GeneralSetting::first()->currency_symbol;
        return response(['success' => true , 'data' => ['item' => $custimization_item , 'session' => $cust], 'currency' => $currency]);
    }

    public function add_user(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'email_id' => 'required|email|unique:users',
            'phone' => 'required|digits_between:6,12'
        ]);
        $vendor = Vendor::where('id',Session::get('vendor_id'))->first();
        $user = User::create([
            'name' => $request->name,
            'email_id' => $request->email_id,
            'phone' => $request->phone,
            'is_verified' => 1,
            'status' => 1,
            'password' => Hash::make(123456),
            'image' => 'noimage.png',
            'vendor_id' => $vendor->id,
        ]);
        $role_id = Role::where('title','user')->orWhere('title','User')->first();
        $user->roles()->sync($role_id);
        return response(['success' => true , 'data' => $user , 'from' => 'addUser']);
    }

    public function update_custimization(Request $request)
    {
        $data = $request->all();
        $custimize = array();
        $session = Session::get('cart');
        $custimization = SubmenuCusomizationType::where('submenu_id',$data['submenu_id'])->get();
        foreach ($session as $key => &$item)
        {
            $k = intval($session[$key]['id']);
            if ($k == $data['submenu_id'])
            {
                if(isset($data['custimization']))
                {
                    $item['custimization'] = [];
                    $item['custimization'] = json_encode($data['custimization']);
                }
                else
                {
                    unset($item['custimization']);
                }
            }
        }
        Session::put('cart', array_values($session));
        $totalamount = 0;
        foreach (Session::get('cart') as $key => $cart)
        {
            $totalamount += intval($cart['price']);
            if (isset($cart['custimization']))
            {
                foreach (json_decode($cart['custimization']) as $cust)
                {
                    $totalamount += intval($cust->data->price);
                }
            }
        }
        return response(['success' => true , 'data' => ['grand_total' => $totalamount]]);
    }

    public function displayBillWithCoupen(Request $request)
    {
        $tt = 0;
        foreach (json_decode($request->tax) as $tax)
        {
            $tt = $tt + $tax->tax;
        }
        $promoCode = PromoCode::find($request->promo_id);
        $currency = GeneralSetting::first()->currency_symbol;
        $users = explode(',', $promoCode->customer_id);
        if (($key = array_search($request->user_id, $users)) !== false)
        {
            $exploded_date = explode(' - ', $promoCode->start_end_date);
            $currentDate = date('Y-m-d', strtotime(Carbon::now()->toDateString()));
            if (($currentDate >= $exploded_date[0]) && ($currentDate <= $exploded_date[1]))
            {
                if ($promoCode->min_order_amount < $request->amount)
                {
                    if ($promoCode->coupen_type == 'both')
                    {
                        if ($promoCode->count_max_count < $promoCode->max_count && $promoCode->count_max_order < $promoCode->max_order && $promoCode->count_max_user < $promoCode->max_user)
                        {
                            $discount = [];
                            if ($promoCode->isFlat == 1)
                            {
                                $discount['discount'] = intval($promoCode->flatDiscount);
                                $discount['totalAmount'] = intval($request->amount);
                                $discount['tax'] = $request->tax;
                                $discount['finalTotal'] = intval($request->amount) + $tt;
                                $discount['grandTotal'] = $discount['finalTotal'] - $discount['discount'];
                                $discount['procode_id'] = $promoCode->id;
                                return response(['success' => true , 'data' => $discount , 'currency' => $currency , 'promo' => $promoCode]);
                            }
                            else
                            {
                                if($promoCode->discountType == 'percentage')
                                {
                                    $disc = intval($promoCode->discount) * intval($request->amount);
                                    $discount['discount'] = intval($disc/100);
                                    $discount['totalAmount'] = intval($request->amount);
                                    $discount['tax'] = $request->tax;
                                    $discount['finalTotal'] = intval($request->amount) + $tt;
                                    $discount['grandTotal'] = $discount['finalTotal'] - $discount['discount'];
                                    $discount['procode_id'] = $promoCode->id;
                                    return response(['success' => true , 'data' => $discount ,'currency' => $currency , 'promo' => $promoCode]);
                                }
                                if($promoCode->discountType == 'amount')
                                {
                                    $discount['discount'] = intval($promoCode->discount);
                                    $discount['totalAmount'] = intval($request->amount);
                                    $discount['tax'] = $request->tax;
                                    $discount['finalTotal'] = intval($request->amount) + $tt;
                                    $discount['grandTotal'] = $discount['finalTotal'] - $discount['discount'];
                                    $discount['procode_id'] = $promoCode->id;
                                    return response(['success' => true , 'data' => $discount ,'currency' => $currency , 'promo' => $promoCode]);
                                }
                                if(intval($discount) > $promoCode->max_disc_amount)
                                {
                                    $discount = $promoCode->max_disc_amount;
                                }
                            }
                            return response(['success' => true, 'data' => $discount->amount,'currency' => $currency ,'promo' => $promoCode]);
                        }
                        else
                        {
                            return response(['success' => false, 'data' => 'This coupen is expire..!!']);
                        }
                    }
                    else
                    {
                        if ($promoCode->coupen_type == 'pickup')
                        {
                            if ($promoCode->count_max_count < $promoCode->max_count && $promoCode->count_max_order < $promoCode->max_order && $promoCode->count_max_user < $promoCode->max_user)
                            {
                                $promo = PromoCode::where('id', $request->promo_id)->first(['id', 'image', 'isFlat', 'flatDiscount', 'discount', 'discountType']);
                                return response(['success' => true, 'data' => $promo]);
                            }
                            else
                            {
                                return response(['success' => false, 'data' => 'This coupen is expire..!!']);
                            }
                        }
                        else
                        {
                            return response(['success' => false, 'data' => 'This coupen is valid only for home delivery type']);
                        }
                    }
                }
                else {
                    return response(['success' => false, 'data' => 'This coupen not valid for less than ' . $currency . $promoCode->min_order_amount . ' amount']);
                }
            } else {
                return response(['success' => false, 'data' => 'Coupen is expire..!!']);
            }
        } else {
            return response(['success' => false, 'data' => 'Coupen is not valid for this user..!!']);
        }
        return response(['success' => true , 'data' => 'hello']);
    }

    public function change_submenu(Request $request)
    {
        $submenus = Submenu::where('menu_id',$request->menu_id)->get();
        $tax = GeneralSetting::first()->isItemTax;
        foreach ($submenus as $submenu)
        {
            if ($tax == 0)
            {
                $price_tax = GeneralSetting::first()->item_tax;
                $disc = $submenu->price * $price_tax;
                $discount = $disc / 100;
                $submenu->price = strval($submenu->price + $discount);
            }
            else
            {
                $submenu->price = strval($submenu->price);
            }
        }
        foreach ($submenus as $submenu)
        {
            $submenu->qty = 0;
            if (Session::get('cart') != null)
            {
                foreach (Session::get('cart') as $cart)
                {
                    if($cart['id'] == $submenu->id)
                    {
                        $submenu->qty = $cart['qty'];
                    }
                }
            }
        }
        $currency = GeneralSetting::first()->currency_symbol;
        return response(['success' => true , 'data' => $submenus , 'currency' => $currency]);
    }

    public function display_bill()
    {
        $totalamount = 0;
        $tax = 0;
        $finalTotal = 0;
        $vendor_tax = Vendor::where('id',Session::get('vendor_id'))->first(['tax'])->makeHidden(['image','category','vendor_logo','rate','review','vendor_name']);
        foreach (Session::get('cart') as $key => $cart)
        {
            $totalamount += intval($cart['price']);
            if (isset($cart['custimization']))
            {
                foreach (json_decode($cart['custimization']) as $cust)
                {
                    $totalamount += intval($cust->data->price);
                }
            }
        }
        $finalTotal = $totalamount;
        $taxs = Tax::whereStatus(1)->get();
        $t = [];
        foreach ($taxs as $tax)
        {
            $temp = array();
            if($tax->type == 'percentage')
            {
                $d = intval($totalamount) * intval($tax->tax);
                $temp['tax'] = intval($d / 100);
                $temp['name'] = $tax->name;
                $finalTotal += $temp['tax'];
            }
            if($tax->type == 'amount')
            {
                $temp['tax'] = intval($tax->tax);
                $temp['name'] = $tax->name;
                $finalTotal += $temp['tax'];
            }
            array_push($t,$temp);
        }
        $currency = GeneralSetting::first()->currency_symbol;
        $h = array();
        $taxDisc = intval($totalamount) * intval($vendor_tax->tax);
        $h['tax'] = intval($taxDisc / 100);
        $h['name'] = 'other tax';
        array_push($t,$h);
        $finalTotal = $finalTotal + $h['tax'];
        return response(['success' => true , 'currency' => $currency ,'data' =>['totalAmount' => intval(round($totalamount)),'finalTotal' => intval(round($finalTotal)) , 'admin_tax' => $t]]);
    }

    public function print_thermal($order_id)
    {
        $order = Order::find($order_id);
        $vendor = Vendor::find($order->vendor_id);
        $currency_code = GeneralSetting::first()->currency_code;
        $tax = 0;
        foreach (json_decode($order->tax) as $value) {
            $tax += $value->tax;
        }
        $store_name = $vendor->name;
        $store_address = $vendor->map_address;
        $store_phone = $vendor->contact;
        $store_email = $vendor->email_id;
        $tax_percentage = $tax;
        $transaction_id = $order->order_id;
        $currency = $currency_code;

        $items = [];
        foreach ($order->orderItems as $item) {
            $temp['name'] = $item['itemName'];
            $temp['qty'] = $item['qty'];
            if(isset($item['custimization']))
            {
                foreach ($item['custimization'] as $value) {
                    $temp['custimization'] = $value->data->name;
                }
            }
            else
            {
                $temp['custimization'] = "Doesn't Apply";
            }
            $temp['price'] = $item['price'];
            array_push($items,$temp);
        }
        // Init printer
        try {
            $printer = new ReceiptPrinter;
            $printer->init(
                config($vendor->connector_type),
                config($vendor->connector_descriptor)
            );

            // Set store info
            $printer->setStore($store_name, $store_address, $store_phone, $store_email);

            // Set currency
            $printer->setCurrency($currency);

            // Add items
            foreach ($items as $item)
            {
                $printer->addItem(
                    $item['name'],
                    $item['qty'],
                    $item['custimization'],
                    $item['price']
                );
            }
            // Set tax
            $printer->setTax($tax_percentage);

            // Calculate total
            $printer->calculateSubTotal();
            $printer->calculateGrandTotal();

            // Set transaction ID
            $printer->setTransactionID($transaction_id);

            // Set qr code
            $printer->setQRcode([
                'tid' => $transaction_id,
            ]);

            // Print receipt
            $printer->printReceipt();
        }
        catch (\Throwable $th) {
            //throw $th;
        }
        return redirect()->back();
    }
}
