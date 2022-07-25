@extends('layouts.app',['activePage' => 'delivery_person'])

@section('title','Delivery Person')

@section('content')

<section class="section">
    @if (Session::has('msg'))
        <script>
            var msg = "<?php echo Session::get('msg');  ?>"
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
        <h1>{{__('Delivery person')}}</h1>
        <div class="section-header-breadcrumb">
            @if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin'))
                <div class="breadcrumb-item active"><a href="{{ url('admin/home') }}">{{__('Dashboard')}}</a></div>
                <div class="breadcrumb-item">{{__('Delivery person')}}</div>
            @endif
            @if(Auth::user()->load('roles')->roles->contains('title', 'vendor'))
                <div class="breadcrumb-item active"><a href="{{ url('vendor/vendor_home') }}">{{__('Dashboard')}}</a></div>
                <div class="breadcrumb-item">{{__('Delivery person')}}</div>
            @endif
        </div>
    </div>
    <div class="section-body">
        <h2 class="section-title">{{__('delivery person management')}}</h2>
        <p class="section-lead">{{__('Add, Edit, Manage Delivery Person.')}}</p>
         <form class="container-fuild" action="{{ url('admin/driver_tax/') }}" method="post">
                        @csrf
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label for="percent">{{__('Delivery Percent')}}</label>
                                <input type="number" max="100" min ="0" value="{{$settings->driver_percent}}" name="percent" class="form-control @error('percent') is-invalid @enderror">

                                

                                @error('percent')
                                <span class="custom_error" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                                @enderror
                               
                            </div>
                              <div class="text-center">
                            <input type="submit" class="btn btn-primary" value="{{__('Update')}}">
                        </div>
                        </div>
                      
</form>
        <div class="card">
            <div class="card-header">
                <div class="w-100">
                    @can('delivery_person_add')
                        @if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin'))
                            <a href="{{ url('admin/delivery_person/create') }}" class="btn btn-primary float-right">{{__('Add New')}}</a>
                        @endif
                        @if(Auth::user()->load('roles')->roles->contains('title', 'vendor'))
                            <a href="{{ url('vendor/deliveryPerson/create') }}" class="btn btn-primary float-right">{{__('Add New')}}</a>
                        @endif
                    @endcan
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped text-center" id="datatable">
                        <thead>
                            <tr>
                                <th>
                                    <input name="select_all" value="1" id="master" type="checkbox" />
                                    <label for="master"></label>
                                </th>
                                <th>#</th>
                                <th>{{__('Delivery Person profile')}}</th>
                                <th>{{__('Delivery Person name')}}</th>
                                <th>{{__('Contact')}}</th>
                                @if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin'))
                                <th>{{__('Vendor name')}}</th>
                                @endif
                                <th>{{__('Email')}}</th>
                                <th>{{__('Driver is online or not ??')}}</th>
                                <th>{{__('Enable')}}</th>
                                <th>يستطيع تغير المنطقة؟</th>
                                @if(Gate::check('delivery_person_edit') || Gate::check('delivery_person_delete'))
                                    <th>{{__('Action')}}</th>
                                @endif
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($delivery_persons as $delivery_person)
                            <tr>
                                <td>
                                    <input name="id[]" value="{{$delivery_person->id}}" id="{{$delivery_person->id}}" data-id="{{ $delivery_person->id }}" class="sub_chk" type="checkbox" />
                                    <label for="{{$delivery_person->id}}"></label>
                                </td>
                                <td>{{ $loop->iteration }}</td>
                                <td>
                                    <img src="{{ $delivery_person->image }}" width="50" height="50" class="rounded" alt="">
                                </td>
                                <th>{{$delivery_person->first_name}}&nbsp;{{$delivery_person->last_name}}</th>
                                <td>{{$delivery_person->contact}}</td>
                                @if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin'))
                                    <td>{{ $delivery_person->vendor }}</td>
                                @endif
                                <td>{{$delivery_person->email_id}}</td>
                                <td>
                                    @if ($delivery_person->is_online == 1)
                                        <div class="badge badge-success">{{__('Yes')}}</div>
                                    @else
                                        <div class="badge badge-danger">{{__('No')}}</div>
                                    @endif
                                </td>
                                <td>
                                    <label class="switch">
                                        <input type="checkbox" name="status" onclick="change_status('admin/delivery_person',{{ $delivery_person->id }})"
                                            {{($delivery_person->status == 1) ? 'checked' : ''}}>
                                        <div class="slider"></div>
                                    </label>
                                </td>
                                 <td>
                                    <label class="switch">
                                        <input type="checkbox" name="zoner" onclick="change_zoner('admin/delivery_person',{{ $delivery_person->id }})"
                                            {{($delivery_person->zoner == 1) ? 'checked' : ''}}>
                                        <div class="slider"></div>
                                    </label>
                                </td>
                                @if(Gate::check('delivery_person_edit') || Gate::check('delivery_person_delete'))
                                    <td class="d-flex justify-content-center">
                                        @can('delivery_person_edit')
                                            @if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin'))
                                                <a href="{{ url('admin/delivery_person/'.$delivery_person->id.'/edit') }}" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="{{__('Edit')}}"><i class="fas fa-pencil-alt"></i></a>
                                            @endif
                                            @if(Auth::user()->load('roles')->roles->contains('title', 'vendor'))
                                                <a href="{{ url('vendor/deliveryPerson/'.$delivery_person->id.'/edit') }}" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="{{__('Edit')}}"><i class="fas fa-pencil-alt"></i></a>
                                            @endif
                                        @endcan
                                        @if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin'))
                                            <a href="{{ url('admin/delivery_person/'.$delivery_person->id) }}" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="{{__('show Delivery person')}}"><i class="fas fa-eye"></i></a>
                                        @endif
                                        @if(Auth::user()->load('roles')->roles->contains('title', 'vendor'))
                                            <a href="{{ url('vendor/deliveryPerson/'.$delivery_person->id) }}" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="{{__('show Delivery person')}}"><i class="fas fa-eye"></i></a>
                                        @endif
                                        @can('delivery_person_edit')
                                            <a href="javascript:void(0);" class="table-action ml-2 btn btn-danger btn-action" onclick="deleteData('admin/delivery_person',{{ $delivery_person->id }},'Delivery Person')">
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
            </div>
            <div class="card-footer">
                <input type="button" value="Delete selected" onclick="deleteAll('delivery_person_multi_delete','Delivery Person')" class="btn btn-primary">
            </div>
        </div>
    </div>
</section>

@endsection
