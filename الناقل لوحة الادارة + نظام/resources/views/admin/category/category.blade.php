@extends('layouts.app',['activePage' => 'category'])

@section('title','Category')

@section('content')

<section class="section">
    @if (Session::has('msg'))
        <script>
            var msg = "<?php echo Session::get('msg'); ?>"
            $(window).on('load', function()
            {
                iziToast.success({
                    message: msg,
                    position: 'topRight'
                });
            });
        </script>
    @endif
    <div class="section-header">
        <h1>{{__('categorys')}}</h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="{{ url('admin/home') }}">{{__('Dashboard')}}</a></div>
            <div class="breadcrumb-item">{{__('Category')}}</div>
        </div>
    </div>
    <div class="section-body">
        <h2 class="section-title">{{__('Category menu')}}</h2>
        <p class="section-lead">{{__('Add, Edit, Manage Category')}}</p>
        <div class="card">
            <div class="card-header">
                @can('category_add')
                    <div class="w-100">
                        <a href="{{ url('admin/category/create') }}" class="btn btn-primary float-right">{{__('add new')}}</a>
                    </div>
                @endcan
            </div>
            <div class="card-body">
                <table id="datatable" class="table table-striped table-bordered text-center" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>
                                <input name="select_all" value="1" id="master" type="checkbox" />
                                <label for="master"></label>
                            </th>
                            <th>#</th>
                            <th>{{__('Image')}}</th>
                            <th>{{__('Category name')}}</th>
                            <th>{{__('Enable')}}</th>
                            @if(Gate::check('category_edit'))
                                <th>{{__('Action')}}</th>
                            @endif
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($categorys as $category)
                            <tr>
                                <td>
                                    <input name="id[]" value="{{$category->id}}" id="{{$category->id}}" data-id="{{ $category->id }}" class="sub_chk" type="checkbox" />
                                    <label for="{{$category->id}}"></label>
                                </td>
                                <td>{{ $loop->iteration }}</td>
                                <td>
                                    <img src="{{ $category->image }}" class="rounded" width="50" height="50" alt="">
                                </td>
                                <td>{{$category->name}}</td>
                                <td>
                                    <label class="switch">
                                        <input type="checkbox" name="status" onclick="change_status('admin/category',{{ $category->id }})" {{($category->status == 1) ? 'checked' : ''}}>
                                        <div class="slider"></div>
                                    </label>
                                </td>
                                @if(Gate::check('category_edit'))
                                    <td>
                                        @can('category_edit')
                                            <a href="{{ url('admin/category/'.$category->id.'/edit') }}" class="btn btn-primary btn-action mr-1"><i class="fas fa-pencil-alt"></i></a>
                                        @endcan
                                        @can('category_delete')
                                            <a href="javascript:void(0);" class="table-action ml-2 btn btn-danger btn-action" onclick="deleteData('admin/category',{{ $category->id }},'Category')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        @endcan
                                    </td>
                                @endif
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <input type="button" value="Delete selected" onclick="deleteAll('category_multi_delete','Category')" class="btn btn-primary">
            </div>
        </div>
    </div>
</section>

@endsection
