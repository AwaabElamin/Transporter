@extends('layouts.app',['activePage' => 'category'])

@section('title','Edit Category')

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
                        console.log(msg);
                });
            </script>
        @endif
        <div class="section-header">
            <h1>{{__('categorys')}}</h1>
            <div class="section-header-breadcrumb">
                <div class="breadcrumb-item active"><a href="{{ url('admin/home') }}">{{__('Dashboard')}}</a></div>
                <div class="breadcrumb-item active"><a href="{{ url('admin/category') }}">{{__('update category')}}</a></div>
                <div class="breadcrumb-item">{{__('Category')}}</div>
            </div>
        </div>
        <div class="section-body">
            <h2 class="section-title">{{__('Category menu')}}</h2>
            <p class="section-lead">{{__('Add, Edit, Manage Category')}}</p>
            <form class="container-fuild" action="{{ url('admin/category/'.$category->id) }}" method="post" enctype="multipart/form-data">
                @csrf
                @method('PUT')
                <div class="card p-2">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12 mb-5">
                                <label for="Promo code name">{{__('category')}}</label>
                                <div class="logoContainer">
                                    <img id="image" src="{{ $category->image }}" width="180" height="150">
                                </div>
                                <div class="fileContainer sprite">
                                    <span>{{__('Image')}}</span>
                                    <input type="file" name="image" value="Choose File" id="previewImage" data-id="edit" accept=".png, .jpg, .jpeg, .svg">
                                </div>
                                @error('image')
                                 <span class="custom_error" role="alert">
                                     <strong>{{ $message }}</strong>
                                 </span>
                                 @enderror
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="">{{__('Name of Category')}}</label>
                                <input type="text" name="name" placeholder="{{__('Enter Category Name')}}" class="form-control @error('name') is_invalide @enderror" value="{{ $category->name }}" required="true">
                                @error('name')
                                <span class="custom_error" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                            </div>
                        </div>

                        <div class="text-center mt-3">
                            <button type="submit" class="btn btn-primary">{{__('update Category')}}</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
@endsection
