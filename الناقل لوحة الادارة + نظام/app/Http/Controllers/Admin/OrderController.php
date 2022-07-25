<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\GeneralSetting;
use App\Models\Order;
use App\Models\Vendor;
use App\Models\PromoCode;
use App\Models\Menu;
use Carbon\Carbon;
use App\Models\OrderChild;
use App\Models\User;
use Session;
use App\Models\Submenu;
use DateTime;
use Gate;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class OrderController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function index()
    {
        abort_if(Gate::denies('order_access'), Response::HTTP_FORBIDDEN, '403 Forbidden');
        $vendor = Vendor::where('user_id',auth()->user()->id)->first();
        $orders = Order::where('delivery_type','HOME')->orderBy('id','desc')->get();
        app('App\Http\Controllers\Vendor\VendorSettingController')->cancel_max_order();
        app('App\Http\Controllers\DriverApiController')->driver_cancel_max_order();
        return view('admin.order.order',compact('orders'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
       
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
       
        $id = Session::get('vendor_id');
         $vendor = Vendor::where('id',$id)->first();
        $cartData = Session::get('cart');
        $items = [];
        $tt = 0;
        // dd(is_array(json_decode($request->tax)),$request->tax);
        foreach (json_decode($request->tax) as $tax)
        {
            $tt = $tt + $tax->tax;
        }
        $data['tax'] = $request->tax;
        $cust_price = intval(0);
        foreach($cartData as $cart)
        {
            array_push($items,$cart['id']);
            // if (isset($cart['custimization']))
            // {
            //     foreach (json_decode($cart['custimization']) as $cust)
            //     {
            //         $cust_price += intval($cust->data->price);
            //     }
            // }
        }
        $amount = $request->amount + $tt;
        if ($vendor->admin_comission_type == 'percentage')
        {
            $comm = $amount * $vendor->admin_comission_value;
            $data['admin_commission'] = intval($comm / 100);
            $data['vendor_amount'] = intval($amount - $data['admin_commission']);
        }
        if ($vendor->admin_comission_type == 'amount') {
            $data['vendor_amount'] = $amount - $vendor->admin_comission_value;
            $data['admin_commission'] = $amount - $data['vendor_amount'];
        }
        $data['date'] = Carbon::now()->toDateString();
        $data['time'] = Carbon::now(env('timezone'))->format('h:i a');
        $data['order_id'] = '#' . rand(100000, 999999);
        $data['amount'] = $amount;

        if (intval($request->promocode_id) != 0)
        {
            $promocode = PromoCode::find($request->promocode_id);
            $data['amount'] = intval($data['amount']) - intval(round($request->promocode_price));
            $data['promocode_price'] = $request->promocode_price;
            $data['promocode_id'] = intval($request->promocode_id);
            $promocode->count_max_user = $promocode->count_max_user + 1;
            $promocode->count_max_count = $promocode->count_max_count + 1;
            $promocode->count_max_order = $promocode->count_max_order + 1;
            $promocode->save();
        }
        $data['delivery_type'] = 'SHOP';
        $data['item'] = implode(',',$items);
        $data['payment_type'] = 'COD';
        $data['payment_status'] = 0;
        $data['order_status'] = 'APPROVE';
        $data['vendor_id'] = $vendor->id;
        $data['user_id'] = $request->user_id;
        $data['tax'] = $request->tax;
        $order = Order::create($data);
        foreach (Session::get('cart') as $cart)
        {
            $order_child = array();
            $order_child['order_id'] = $order->id;
            $order_child['item'] = $cart['id'];
            $order_child['price'] = $cart['price'];
            $order_child['qty'] = $cart['qty'];
            if(isset($cart['custimization']))
            {
                $order_child['custimization'] = $cart['custimization'];
            }
            OrderChild::create($order_child);
        }
        session()->forget('cart');
        return response(['success' => true]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $order = Order::find($id);
        $currency = GeneralSetting::first()->currency_symbol;
        return response(['success' => true , 'data' => ['order' => $order , 'currency' => $currency]]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Order $order)
    {
        $order->delete();
        return response(['success' => true]);
    }

    public function invoice($id)
    {
        $order = Order::find($id);
        $general_setting = GeneralSetting::first();
        return view('admin.order.invoice',compact('order','general_setting'));
    }

    public function invoice_print($id)
    {
        $order = Order::find($id);
        $general_setting = GeneralSetting::first();
        return view('admin.order.invoice_print',compact('order','general_setting'));
    }
    public function change_status(Request $request)
    {
        $status = strtoupper($request->status);
        $order = Order::find($request->id);
        $vendor = Vendor::where('id',$order->vendor_id)->first();
        $order->order_status = $request->status;
        $order->save();
        $user = User::find($order->user_id);
        if ($request->status == 'APPROVE' || $request->status == 'approve')
        {
            $start_time = Carbon::now(env('timezone'))->format('h:i a');
            $order->order_start_time = $start_time;
            $order->save();
        }
        if ($request->status == 'COMPLETE' || $request->status == 'complete')
        {
            $order->order_end_time = Carbon::now(env('timezone'))->format('h:i a');
            $order->payment_status = 1; 
            $order->save();
            $settle = array();
            $settle['vendor_id'] = $order->vendor_id;
            $settle['order_id'] = $order->id;
            if ($order->payment_type == 'COD')
            {
                $settle['payment'] = 0;
            } else {
                $settle['payment'] = 1;
            }
            $settle['vendor_status'] = 0;
            $settle['admin_earning'] = $order->admin_commission;
            $settle['vendor_earning'] = $order->vendor_amount;
            Settle::create($settle);
        }
        if (Session::get('vendor_driver') == 0)
        {
            if ($order->delivery_type == 'HOME' && ($request->status == 'APPROVE' || $request->status == 'approve'))
            {
                $areas = DeliveryZoneArea::all();
                $ds = array();
                foreach ($areas as $value)
                {
                    $vendorss = explode(',', $value->vendor_id);
                    if (($key = array_search($vendor->id, $vendorss)) !== false)
                    {
                        $ts = DB::select(DB::raw('SELECT id,delivery_zone_id,( 3959 * acos( cos( radians(' . $vendor->lat . ') ) * cos( radians( lat ) ) * cos( radians( lang ) - radians(' . $vendor->lang . ') ) + sin( radians(' . $vendor->lat . ') ) * sin( radians(lat) ) ) ) AS distance FROM delivery_zone_area HAVING distance < ' . $value->radius . ' ORDER BY distance'));
                        foreach ($ts as $t)
                        {
                            array_push($ds, $t->delivery_zone_id);
                        }
                    }
                }
                $near_drivers = DeliveryPerson::whereIn('delivery_zone_id', $ds)->get();
                foreach ($near_drivers as $near_driver)
                {
                    $driver_notification = GeneralSetting::first()->driver_notification;
                    $driver_mail = GeneralSetting::first()->driver_mail;
                    $content = NotificationTemplate::where('title', 'delivery person order')->first();
                    $detail['drive_name'] = $near_driver->first_name . ' - ' . $near_driver->last_name;
                    $detail['vendor_name'] = $vendor->name;
                    if (UserAddress::find($order->address_id))
                    {
                        $detail['address'] = UserAddress::find($order->address_id)->address;
                    }
                    $h = ["{driver_name}", "{vendor_name}", "{address}"];
                    $notification_content = str_replace($h, $detail, $content->notification_content);
                    if ($driver_notification == 1)
                    {
                        Config::set('onesignal.app_id', env('driver_app_id'));
                        Config::set('onesignal.rest_api_key', env('driver_api_key'));
                        Config::set('onesignal.user_auth_key', env('driver_auth_key'));
                        try {
                            OneSignal::sendNotificationToUser(
                                $notification_content,
                                $near_driver->device_token,
                                $url = null,
                                $data = null,
                                $buttons = null,
                                $schedule = null,
                                GeneralSetting::find(1)->business_name
                            );
                        }
                        catch (\Throwable $th)
                        {

                        }
                    }
                    $p_notification = array();
                    $p_notification['title'] = 'create order';
                    $p_notification['user_type'] = 'driver';
                    $p_notification['user_id'] = $near_driver->id;
                    $p_notification['message'] = $notification_content;
                    Notification::create($p_notification);
                    if ($driver_mail == 1) {
                        $mail_content = str_replace($h, $detail, $content->mail_content);
                        try
                        {
                            Mail::to($near_driver->email_id)->send(new DriverOrder($mail_content));
                        }
                        catch (\Throwable $th) {
                        }
                    }
                }
            }
        }

        if ($user->language == 'العربية')
        {
            $status_change = NotificationTemplate::where('title','change status')->first();
            $mail_content = $status_change->arabic_mail_content;
            $notification_content = $status_change->arabic_notification_content;
            $detail['user_name'] = $user->name;
            $detail['order_id'] = $order->order_id;
            $detail['date'] = $order->date;
            $detail['order_status'] = $order->order_status;
            $detail['company_name'] = GeneralSetting::find(1)->business_name;
            $data = ["{user_name}","{order_id}","{date}","{order_status}","{company_name}"];

            $message1 = str_replace($data, $detail, $notification_content);
            $mail = str_replace($data, $detail, $mail_content);
            if(GeneralSetting::find(1)->customer_notification == 1)
            {
                if($user->device_token != null)
                {
                    try {
                        Config::set('onesignal.app_id', env('customer_app_id'));
                        Config::set('onesignal.rest_api_key', env('customer_auth_key'));
                        Config::set('onesignal.user_auth_key', env('customer_api_key'));
                        OneSignal::sendNotificationToUser(
                            $message1,
                            $user->device_token,
                            $url = null,
                            $data = null,
                            $buttons = null,
                            $schedule = null,
                            GeneralSetting::find(1)->business_name
                        );
                    } catch (\Throwable $th) {

                    }
                }
            }

            if (GeneralSetting::find(1)->customer_mail == 1)
            {
                try {
                    Mail::to($user->email_id)->send(new StatusChange($mail));
                } catch (\Throwable $th) {

                }
            }
        }
        else
        {
            $status_change = NotificationTemplate::where('title','change status')->first();
            $mail_content = $status_change->mail_content;
            $notification_content = $status_change->notification_content;
            $detail['user_name'] = $user->name;
            $detail['order_id'] = $order->order_id;
            $detail['date'] = $order->date;
            $detail['order_status'] = $order->order_status;
            $detail['company_name'] = GeneralSetting::find(1)->business_name;
            $data = ["{user_name}","{order_id}","{date}","{order_status}","{company_name}"];

            $message1 = str_replace($data, $detail, $notification_content);
            $mail = str_replace($data, $detail, $mail_content);
            if(GeneralSetting::find(1)->customer_notification == 1)
            {
                if($user->device_token != null)
                {
                    try {
                        Config::set('onesignal.app_id', env('customer_app_id'));
                        Config::set('onesignal.rest_api_key', env('customer_auth_key'));
                        Config::set('onesignal.user_auth_key', env('customer_api_key'));
                        OneSignal::sendNotificationToUser(
                            $message1,
                            $user->device_token,
                            $url = null,
                            $data = null,
                            $buttons = null,
                            $schedule = null,
                            GeneralSetting::find(1)->business_name
                        );
                    } catch (\Throwable $th) {

                    }
                }
            }

            if (GeneralSetting::find(1)->customer_mail == 1)
            {
                try {
                    Mail::to($user->email_id)->send(new StatusChange($mail));
                } catch (\Throwable $th) {

                }
            }
        }
        $notification = array();
        $notification['user_id'] = $user->id;
        $notification['user_type'] = 'user';
        $notification['title'] = $status;
        $notification['message'] = $message1;
        Notification::create($notification);

        if($order->delivery_type == 'SHOP')
        {
            $end_time = Carbon::now(env('timezone'))->format('h:i a');
            $order->order_start_time = $end_time;
            $order->save();
            if ($request->status == 'complete' || $request->status == 'COMPLETE')
            {
                $settle = array();
                $settle['vendor_id'] = $order->vendor_id;
                $settle['order_id'] = $order->id;
                if ($order->payment_type == 'COD')
                {
                    $settle['payment'] = 0;
                } else {
                    $settle['payment'] = 1;
                }
                $settle['vendor_status'] = 0;
                $settle['admin_earning'] = $order->admin_commission;
                $settle['vendor_earning'] = $order->vendor_amount;
                Settle::create($settle);
            }
        }
        return response(['success' => true, 'data' => ['status' => $status , 'order_id' => $order->id]]);
    }

 
}
