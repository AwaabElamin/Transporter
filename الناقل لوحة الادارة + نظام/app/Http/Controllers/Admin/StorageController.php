<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\StorageItem;
use App\Models\Storage;
use Gate;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class StorageController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
          abort_if(Gate::denies('storage_access'), Response::HTTP_FORBIDDEN, '403 Forbidden');

        $orders = Storage::orderBy('id','desc')->get();

        return view('admin.storage.index',compact('orders'));
    }

    public function incoming()
    {
          abort_if(Gate::denies('storage_access'), Response::HTTP_FORBIDDEN, '403 Forbidden');

        $orders = Storage::where('order_status', 'incoming')->orderBy('id','desc')->get();

        return view('admin.storage.incoming',compact('orders'));
    }


     public function exporting()
    {
          abort_if(Gate::denies('storage_access'), Response::HTTP_FORBIDDEN, '403 Forbidden');

        $orders = Storage::where('order_status', 'exporting')->orderBy('id','desc')->get();

        return view('admin.storage.exporting',compact('orders'));
    }

    public function change_storage_status(Request $request){
          $data = Storage::find($request->id);
          $data->order_status = $request->status;
            $data->save();
            return response(['success' => true]);

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\StorageItem  $storageItem
     * @return \Illuminate\Http\Response
     */
    public function show(StorageItem $storageItem)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\StorageItem  $storageItem
     * @return \Illuminate\Http\Response
     */
    public function edit(StorageItem $storageItem)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\StorageItem  $storageItem
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, StorageItem $storageItem)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\StorageItem  $storageItem
     * @return \Illuminate\Http\Response
     */
    public function destroy(StorageItem $storageItem)
    {
        //
    }
}
