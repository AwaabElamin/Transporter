<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\CustomController;
use App\Imports\CusineImport;
use App\Mail\Verification;
use App\Models\Category;
use App\Models\Vendor;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Gate;
use DB;
use Mail;
use Symfony\Component\HttpFoundation\Response;


class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        abort_if(Gate::denies('category_access'), Response::HTTP_FORBIDDEN, '403 Forbidden');
        $categorys = Category::orderBy('id','DESC')->get();
        return view('admin.category.category',compact('categorys'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        abort_if(Gate::denies('category_add'), Response::HTTP_FORBIDDEN, '403 Forbidden');
        return view('admin.category.create_category');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate(
        ['name' => 'required','unique:category'],
        [
            'name.required' => 'The Name Of Category Field Is Required',
        ]);
        $data = $request->all();
        if(isset($data['status']))
        {
            $data['status'] = 1;
        }
        else
        {
            $data['status'] = 0;
        }
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
        Category::create($data);
        return redirect('admin/category')->with('msg','Category created successfully..!!');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function show(Category $category)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */

    public function edit(Category $category)
    {
        abort_if(Gate::denies('category_edit'), Response::HTTP_FORBIDDEN, '403 Forbidden');
        return view('admin.category.edit_category',compact('category'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Category $category)
    {
        $request->validate(
        ['name' => 'required','unique:category,name,' . $category . ',id'],
        [
            'name.required' => 'The Name Of Category Field Is Required',
        ]);
        $data = $request->all();
        if ($file = $request->hasfile('image'))
        {
            $request->validate(
            ['image' => 'max:1000'],
            [
                'image.max' => 'The Image May Not Be Greater Than 1 MegaBytes.',
            ]);
            (new CustomController)->deleteImage(DB::table('category')->where('id', $category->id)->value('image'));
            $data['image'] = (new CustomController)->uploadImage($request->image);
        }
        $category->update($data);
        return redirect('admin/category')->with('msg','Category updated successfully..!!');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function destroy(Category $category)
    {
        $cusine = Category::find($category);
        $vendors = Vendor::all();
        foreach ($vendors as $value)
        {
            $cIds = explode(',',$value->category_id);
            if(count($cIds) > 0)
            {
                if (($key = array_search($category->id, $cIds)) !== false)
                {
                    return response(['success' => false , 'data' => __('this categorys connected with vendor first delete vendor')]);
                }
            }
        }
        (new CustomController)->deleteImage(DB::table('category')->where('id', $category->id)->value('image'));
        $category->delete();
        return response(['success' => true]);
    }

    public function change_status(Request $request)
    {
        $data = Category::find($request->id);

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
}
