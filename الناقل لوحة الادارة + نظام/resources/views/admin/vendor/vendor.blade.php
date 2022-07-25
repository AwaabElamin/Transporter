@extends('layouts.app',['activePage' => 'vendor'])

@section('title','Vendor')

@section('content')

<section class="section">
    <div class="section-header">
        <h1>{{__('Vendor')}}</h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="{{ url('admin/home') }}">{{__('Dashboard')}}</a></div>
            <div class="breadcrumb-item">{{__('Vendor')}}</div>
        </div>
    </div>
    <div class="section-body">
        <h2 class="section-title">{{__('Vendor Management System')}}</h2>
        <p class="section-lead">{{__('Add, Edit, Manage Vendors.')}}</p>
          <form class="container-fuild" action="{{ url('admin/vendor_tax/') }}" method="post">
                        @csrf
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label for="sptax">{{__('Small Package')}}</label>
                                <input type="number" value="{{$settings->vendor_tax_sp}}" name="sptax" class="form-control @error('sptax') is-invalid @enderror">

                                <label for="mptax">{{__('Medium Package')}}</label>
                                <input type="number" value="{{$settings->vendor_tax_mp}}" name="mptax" class="form-control @error('mptax') is-invalid @enderror">

                                <label for="lptax">{{__('Large Package')}}</label>
                                <input type="number" value="{{$settings->vendor_tax_lp}}" name="lptax" class="form-control @error('ltax') is-invalid @enderror">

                                @error('sptax')
                                <span class="custom_error" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                                @enderror
                                 @error('mptax')
                                <span class="custom_error" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                                @enderror
                                 @error('lptax')
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
                @can('admin_vendor_add')
                    <div class="w-100">
                        <a href="{{ url('admin/vendor/create') }}" class="btn btn-primary float-right">{{__('Add New')}}</a>
                    </div>
                @endcan
            </div>
            <div class="card-body table-responsive">
                <table id="datatable" class="table table-striped table-bordered text-center" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>
                                <input name="select_all" value="1" id="master" type="checkbox" />
                                <label for="master"></label>
                            </th>
                            <th>#</th>
                            <th>{{__('vendor profile')}}</th>
                            <th>{{__('vendor name')}}</th>
                            <th>{{__('Location')}}</th>
                            <th>{{__('Email')}}</th>
                            <th>{{__('Enable')}}</th>
                            @if(Gate::check('admin_vendor_edit'))
                                <th>{{__('Action')}}</th>
                            @endif
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($vendors as $vendor)
                        <tr>
                            <td>
                                <input name="id[]" value="{{$vendor->id}}" id="{{$vendor->id}}" data-id="{{ $vendor->id }}" class="sub_chk" type="checkbox" />
                                <label for="{{$vendor->id}}"></label>
                            </td>
                            <td>{{ $loop->iteration }}</td>
                            <td>
                                <img src="{{ $vendor->image }}" width="50" height="50" class="rounded" alt="">
                            </td>
                            <th>{{$vendor->name}}</th>
                            <td>{{$vendor->address}}</td>
                            <td>{{$vendor->email_id}}</td>
                            <td>
                                <label class="switch">
                                    <input type="checkbox" name="status" onclick="change_status('admin/vendor',{{ $vendor->id }})" {{($vendor->status == 1) ? 'checked' : ''}}>
                                    <div class="slider"></div>
                                </label>
                            </td>

                            @if(Gate::check('admin_vendor_edit'))
                                <td class="d-flex justify-content-center">
                                    <a href="{{ url('admin/vendor/'.$vendor->id.'/order') }}" class="btn btn-success btn-action mr-1" data-toggle="tooltip" title="" data-original-title="{{__('Edit')}}"><i class="fas fa-cart-plus"></i></a>
                                    <a href="{{ url('admin/vendor/'.$vendor->id) }}" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="{{__('show vendor')}}"><i class="fas fa-eye"></i></a>
                                    @can('admin_vendor_edit')
                                        <a href="{{ url('admin/vendor/'.$vendor->id.'/edit') }}" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="{{__('Edit')}}"><i class="fas fa-pencil-alt"></i></a>
                                    @endcan

                                    @can('admin_vendor_delete')
                                        <a href="javascript:void(0);" class="table-action btn btn-danger btn-action" onclick="deleteData('admin/vendor',{{ $vendor->id }},'Vendor')">
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
                <input type="button" value="Delete selected" onclick="deleteAll('vendor_multi_delete','Vendor')" class="btn btn-primary">
            </div>
        </div>
    </div>
</section>

@endsection
