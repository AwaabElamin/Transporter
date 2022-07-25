<?php $__env->startSection('title','Vendor'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e(__('Vendor')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('Vendor')); ?></div>
        </div>
    </div>
    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Vendor Management System')); ?></h2>
        <p class="section-lead"><?php echo e(__('Add, Edit, Manage Vendors.')); ?></p>
          <form class="container-fuild" action="<?php echo e(url('admin/vendor_tax/')); ?>" method="post">
                        <?php echo csrf_field(); ?>
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label for="sptax"><?php echo e(__('Small Package')); ?></label>
                                <input type="number" value="<?php echo e($settings->vendor_tax_sp); ?>" name="sptax" class="form-control <?php $__errorArgs = ['sptax'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                                <label for="mptax"><?php echo e(__('Medium Package')); ?></label>
                                <input type="number" value="<?php echo e($settings->vendor_tax_mp); ?>" name="mptax" class="form-control <?php $__errorArgs = ['mptax'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                                <label for="lptax"><?php echo e(__('Large Package')); ?></label>
                                <input type="number" value="<?php echo e($settings->vendor_tax_lp); ?>" name="lptax" class="form-control <?php $__errorArgs = ['ltax'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                                <?php $__errorArgs = ['sptax'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                <span class="custom_error" role="alert">
                                    <strong><?php echo e($message); ?></strong>
                                </span>
                                <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                                 <?php $__errorArgs = ['mptax'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                <span class="custom_error" role="alert">
                                    <strong><?php echo e($message); ?></strong>
                                </span>
                                <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                                 <?php $__errorArgs = ['lptax'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                <span class="custom_error" role="alert">
                                    <strong><?php echo e($message); ?></strong>
                                </span>
                                <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                            </div>
                              <div class="text-center">
                            <input type="submit" class="btn btn-primary" value="<?php echo e(__('Update')); ?>">
                        </div>
                        </div>
                      
</form>
        <div class="card">
            <div class="card-header">
                <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_add')): ?>
                    <div class="w-100">
                        <a href="<?php echo e(url('admin/vendor/create')); ?>" class="btn btn-primary float-right"><?php echo e(__('Add New')); ?></a>
                    </div>
                <?php endif; ?>
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
                            <th><?php echo e(__('vendor profile')); ?></th>
                            <th><?php echo e(__('vendor name')); ?></th>
                            <th><?php echo e(__('Location')); ?></th>
                            <th><?php echo e(__('Email')); ?></th>
                            <th><?php echo e(__('Enable')); ?></th>
                            <?php if(Gate::check('admin_vendor_edit')): ?>
                                <th><?php echo e(__('Action')); ?></th>
                            <?php endif; ?>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $__currentLoopData = $vendors; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $vendor): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                        <tr>
                            <td>
                                <input name="id[]" value="<?php echo e($vendor->id); ?>" id="<?php echo e($vendor->id); ?>" data-id="<?php echo e($vendor->id); ?>" class="sub_chk" type="checkbox" />
                                <label for="<?php echo e($vendor->id); ?>"></label>
                            </td>
                            <td><?php echo e($loop->iteration); ?></td>
                            <td>
                                <img src="<?php echo e($vendor->image); ?>" width="50" height="50" class="rounded" alt="">
                            </td>
                            <th><?php echo e($vendor->name); ?></th>
                            <td><?php echo e($vendor->address); ?></td>
                            <td><?php echo e($vendor->email_id); ?></td>
                            <td>
                                <label class="switch">
                                    <input type="checkbox" name="status" onclick="change_status('admin/vendor',<?php echo e($vendor->id); ?>)" <?php echo e(($vendor->status == 1) ? 'checked' : ''); ?>>
                                    <div class="slider"></div>
                                </label>
                            </td>

                            <?php if(Gate::check('admin_vendor_edit')): ?>
                                <td class="d-flex justify-content-center">
                                    <a href="<?php echo e(url('admin/vendor/'.$vendor->id.'/order')); ?>" class="btn btn-success btn-action mr-1" data-toggle="tooltip" title="" data-original-title="<?php echo e(__('Edit')); ?>"><i class="fas fa-cart-plus"></i></a>
                                    <a href="<?php echo e(url('admin/vendor/'.$vendor->id)); ?>" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="<?php echo e(__('show vendor')); ?>"><i class="fas fa-eye"></i></a>
                                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_edit')): ?>
                                        <a href="<?php echo e(url('admin/vendor/'.$vendor->id.'/edit')); ?>" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="<?php echo e(__('Edit')); ?>"><i class="fas fa-pencil-alt"></i></a>
                                    <?php endif; ?>

                                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_delete')): ?>
                                        <a href="javascript:void(0);" class="table-action btn btn-danger btn-action" onclick="deleteData('admin/vendor',<?php echo e($vendor->id); ?>,'Vendor')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    <?php endif; ?>
                                </td>
                            <?php endif; ?>
                        </tr>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <input type="button" value="Delete selected" onclick="deleteAll('vendor_multi_delete','Vendor')" class="btn btn-primary">
            </div>
        </div>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'vendor'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/vendor/vendor.blade.php ENDPATH**/ ?>