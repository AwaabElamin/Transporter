<?php $__env->startSection('title','show delivery person'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e(__('Show delivery zone')); ?></h1>
        <div class="section-header-breadcrumb">
            <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><a href="<?php echo e(url('admin/delivery_zone')); ?>"><?php echo e(__('Delivery zone')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Show Delivery zone')); ?></div>
            <?php endif; ?>
            <?php if(Auth::user()->load('roles')->roles->contains('title', 'vendor')): ?>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('vendor/vendor_home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><a href="<?php echo e(url('vendor/deliveryZone')); ?>"><?php echo e(__('Delivery zone')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Show Delivery zone')); ?></div>
            <?php endif; ?>
        </div>
    </div>

    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Delivery zone area management')); ?></h2>
        <p class="section-lead"><?php echo e(__('Delivery zone Area.')); ?></p>

        <input type="hidden" name="delivery_zone_id" id="delivery_zone_id" value="<?php echo e($delivery_zone->id); ?>">
        <div class="container-fluid mt-4">
            <div class="row">
                <div class="col-lg-4">
                    <div class="row">
                        <div class="card w-75">
                            <div class="card-body">
                                <h5 class="text-dark"><?php echo e($delivery_zone->name); ?></h5>
                                <p><?php echo e(__('Zone admin name : ')); ?> <span class="font-weight-bold"><?php echo e($delivery_zone->admin_name); ?></span></p>
                                <p><?php echo e(__('number of delivery person  : ')); ?> <span class="font-weight-bold"><?php echo e(count($delivery_persons)); ?></span></p>
                                <a href="javascript:void(0);" class="btn btn-primary float-right" data-toggle="modal"
                                data-target="#show_delivery_person"><?php echo e(__('View delivery person')); ?></a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="card w-75">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12 col-12 text-right">
                                        <button type="button" class="btn btn-primary p-1" data-toggle="modal" data-target="#staticBackdrop"><?php echo e(__('Add Area')); ?></button>
                                    </div>
                                </div>

                                <?php $__currentLoopData = $areas; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $area): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <?php if($loop->iteration == 1): ?>
                                        <?php
                                            $first = $area;
                                        ?>
                                        <?php break; ?>
                                    <?php endif; ?>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                <ul class="nav nav-pills nav-pills-rose nav-pills-icons flex-column" role="tablist">
                                    <?php $__currentLoopData = $areas; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $area): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <li class="nav-item mt-2">
                                            <div class="nav-link w-100 h-100 <?php echo e($loop->iteration == 1 ? 'active show' : ''); ?>" onclick="delivery_zone_area_map(<?php echo e($area->id); ?>)" data-toggle="tab" href="#link110" role="tablist">
                                                <?php echo e($area->name); ?>

                                                <span>
                                                    <a class="float-right text-light" data-toggle="modal" data-target="#edit_delivery_zone" onclick="edit_delivery_person(<?php echo e($area->id); ?>)">
                                                        <i class="fas fa-pencil-alt"></i>
                                                    </a>
                                                    <a href="javascript:void(0);" class="ml-2 float-right text-light" onclick="deleteData('admin/delivery_zone_area',<?php echo e($area->id); ?>,'Delivery Zone Area')">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </li>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="row">
                        <div class="card w-100 p-1">
                            <div class="card-header">
                                <h4 class="text-primary"><?php echo e(__('MAP')); ?></h4>
                            </div>
                            <div class="card-body" style="height: 750px">
                                <?php if(isset($first)): ?>
                                <div class="tab-content">
                                    <div class="tab-pane active show" id="link110">
                                        <div class="form-group">
                                            <div id="abcd" style="border: 1px solid black; height:650px;"></div>
                                            <input type="hidden" id="show_lat" value="<?php echo e($first->lat); ?>">
                                            <input type="hidden" id="show_lang" value="<?php echo e($first->lang); ?>">
                                            <input type="hidden" id="show_name" value="<?php echo e($first->name); ?>">
                                            <input type="hidden" id="show_radius" value="<?php echo e($first->radius); ?>">
                                        </div>
                                    </div>
                                </div>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="modal fade" id="show_delivery_person" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel"><?php echo e(__('Delivery person')); ?></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table id="datatable" class="table table-striped table-bordered text-center" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th><?php echo e(__('Delivery person profile')); ?></th>
                            <th><?php echo e(__('Delivery person name')); ?></th>
                            <th><?php echo e(__('status')); ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $__currentLoopData = $delivery_persons; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $delivery_person): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <tr>
                                <td><?php echo e($loop->iteration); ?></td>
                                <td>
                                    <img src="<?php echo e($delivery_person->image); ?>" width="50" height="50" alt="">
                                </td>
                                <td><?php echo e($delivery_person->first_name); ?>&nbsp;<?php echo e($delivery_person->last_name); ?></td>
                                <td><?php echo e($delivery_person->status); ?></td>
                            </tr>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="staticBackdrop" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel"><?php echo e(__('Add area')); ?></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="alert alert-dark alert-dismissible fade show hide show_alert" role="alert">
                    <strong class="display"></strong>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <label for=""><?php echo e(__('Name of area')); ?></label>
                        <input type="text" name="area_name" id="name" class="form-control">
                    </div>
                </div>
                <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                    <div class="row pt-3">
                        <div class="col-md-12">
                            <label for=""><?php echo e(__('Vendor')); ?></label>
                            <select name="vendor_id[]" class="select2" multiple>
                                <?php $__currentLoopData = $vendors; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $vendor): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <option value="<?php echo e($vendor->id); ?>"><?php echo e($vendor->name); ?></option>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                            </select>
                        </div>
                    </div>
                <?php endif; ?>
                <div class="row pt-3">
                    <div class="col-md-6">
                        <label for=""><?php echo e(__('Radius of area')); ?></label>
                        <input type="number" min=1 name="radius" id="radius" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <div class="pac-card col-md-12 mb-3" id="pac-card">
                            <label for="pac-input"><?php echo e(__('Location based on latitude/lontitude')); ?></label>
                            <div id="pac-container">
                                <input id="pac-input" type="text" name="map_address" class="form-control"
                                    placeholder="Enter a location" />
                                <input type="hidden" name="lat" value="<?php echo e(15.500654); ?>" id="lat">
                                <input type="hidden" name="lang" value="<?php echo e(32.559898); ?>" id="lang">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col w-100 text-right">
                        <button class="btn btn-primary" onclick="remove_coordinates()"><?php echo e(__('clear area')); ?></button>
                    </div>
                </div>
                <div class="row pt-2">
                    <div class="col-md-12">
                        <div id="map" style="height: 650px;"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
                <button type="button" class="btn btn-primary" onclick="add_area()"><?php echo e(__('Submit')); ?></button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade bd-example-modal-lg" id="edit_delivery_zone" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <input type="hidden" name="delivery_zone_area_id">
            <form id="update_zone_area_form" method="post">
                <div class="modal-body">
                    <div class="alert alert-dark alert-dismissible fade show hide show_alert" role="alert">
                        <strong class="display"></strong>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label for=""><?php echo e(__('Name of area')); ?></label>
                            <input type="text" name="name" id="edit_name" class="form-control">
                        </div>
                    </div>
                    <div class="row pt-3">
                        <div class="col-md-6">
                            <label for=""><?php echo e(__('Radius of area')); ?></label>
                            <input type="number" min=1 name="radius" id="edit_radius" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <div class="edit-pac-card col-md-12 mb-3" id="edit-pac-card">
                                <label for="edit-pac-input"><?php echo e(__('Location based on latitude/lontitude')); ?></label>
                                <div id="pac-container">
                                    <input id="edit_pac-input" type="text" name="map_address" class="form-control"
                                        placeholder="Enter a location" />
                                    <input type="hidden" name="lat" value="" id="edit_lat">
                                    <input type="hidden" name="lang" value="" id="edit_lang">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row pt-3">
                        <div class="col-md-12">
                            <label for=""><?php echo e(__('Vendor')); ?></label>
                            <select name="vendor_id[]" id="edit_vendor_id" class="form-control select2" multiple>
                                <?php $__currentLoopData = $vendors; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $vendor): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <option value="<?php echo e($vendor->id); ?>"><?php echo e($vendor->name); ?></option>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                            </select>
                        </div>
                    </div>
                    <div class="row pt-3">
                        <div class="col-md-12">
                            <div id="edit_map" style="height: 650px;"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" onclick="update_area()" class="btn btn-primary"><?php echo e(__('Submit')); ?></button>
                </div>
            </form>
        </div>
    </div>
</div>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'delivery_zone'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/delivery zone area/delivery_zone_area.blade.php ENDPATH**/ ?>