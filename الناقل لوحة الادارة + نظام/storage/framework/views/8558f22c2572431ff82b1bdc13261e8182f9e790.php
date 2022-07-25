<?php $__env->startSection('title','Delivery Person'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <?php if(Session::has('msg')): ?>
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
    <?php endif; ?>
    <div class="section-header">
        <h1><?php echo e(__('Delivery person')); ?></h1>
        <div class="section-header-breadcrumb">
            <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Delivery person')); ?></div>
            <?php endif; ?>
            <?php if(Auth::user()->load('roles')->roles->contains('title', 'vendor')): ?>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('vendor/vendor_home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Delivery person')); ?></div>
            <?php endif; ?>
        </div>
    </div>
    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('delivery person management')); ?></h2>
        <p class="section-lead"><?php echo e(__('Add, Edit, Manage Delivery Person.')); ?></p>
         <form class="container-fuild" action="<?php echo e(url('admin/driver_tax/')); ?>" method="post">
                        <?php echo csrf_field(); ?>
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label for="percent"><?php echo e(__('Delivery Percent')); ?></label>
                                <input type="number" max="100" min ="0" value="<?php echo e($settings->driver_percent); ?>" name="percent" class="form-control <?php $__errorArgs = ['percent'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                                

                                <?php $__errorArgs = ['percent'];
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
                <div class="w-100">
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('delivery_person_add')): ?>
                        <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                            <a href="<?php echo e(url('admin/delivery_person/create')); ?>" class="btn btn-primary float-right"><?php echo e(__('Add New')); ?></a>
                        <?php endif; ?>
                        <?php if(Auth::user()->load('roles')->roles->contains('title', 'vendor')): ?>
                            <a href="<?php echo e(url('vendor/deliveryPerson/create')); ?>" class="btn btn-primary float-right"><?php echo e(__('Add New')); ?></a>
                        <?php endif; ?>
                    <?php endif; ?>
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
                                <th><?php echo e(__('Delivery Person profile')); ?></th>
                                <th><?php echo e(__('Delivery Person name')); ?></th>
                                <th><?php echo e(__('Contact')); ?></th>
                                <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                                <th><?php echo e(__('Vendor name')); ?></th>
                                <?php endif; ?>
                                <th><?php echo e(__('Email')); ?></th>
                                <th><?php echo e(__('Driver is online or not ??')); ?></th>
                                <th><?php echo e(__('Enable')); ?></th>
                                <th>يستطيع تغير المنطقة؟</th>
                                <?php if(Gate::check('delivery_person_edit') || Gate::check('delivery_person_delete')): ?>
                                    <th><?php echo e(__('Action')); ?></th>
                                <?php endif; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $__currentLoopData = $delivery_persons; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $delivery_person): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <tr>
                                <td>
                                    <input name="id[]" value="<?php echo e($delivery_person->id); ?>" id="<?php echo e($delivery_person->id); ?>" data-id="<?php echo e($delivery_person->id); ?>" class="sub_chk" type="checkbox" />
                                    <label for="<?php echo e($delivery_person->id); ?>"></label>
                                </td>
                                <td><?php echo e($loop->iteration); ?></td>
                                <td>
                                    <img src="<?php echo e($delivery_person->image); ?>" width="50" height="50" class="rounded" alt="">
                                </td>
                                <th><?php echo e($delivery_person->first_name); ?>&nbsp;<?php echo e($delivery_person->last_name); ?></th>
                                <td><?php echo e($delivery_person->contact); ?></td>
                                <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                                    <td><?php echo e($delivery_person->vendor); ?></td>
                                <?php endif; ?>
                                <td><?php echo e($delivery_person->email_id); ?></td>
                                <td>
                                    <?php if($delivery_person->is_online == 1): ?>
                                        <div class="badge badge-success"><?php echo e(__('Yes')); ?></div>
                                    <?php else: ?>
                                        <div class="badge badge-danger"><?php echo e(__('No')); ?></div>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <label class="switch">
                                        <input type="checkbox" name="status" onclick="change_status('admin/delivery_person',<?php echo e($delivery_person->id); ?>)"
                                            <?php echo e(($delivery_person->status == 1) ? 'checked' : ''); ?>>
                                        <div class="slider"></div>
                                    </label>
                                </td>
                                 <td>
                                    <label class="switch">
                                        <input type="checkbox" name="zoner" onclick="change_zoner('admin/delivery_person',<?php echo e($delivery_person->id); ?>)"
                                            <?php echo e(($delivery_person->zoner == 1) ? 'checked' : ''); ?>>
                                        <div class="slider"></div>
                                    </label>
                                </td>
                                <?php if(Gate::check('delivery_person_edit') || Gate::check('delivery_person_delete')): ?>
                                    <td class="d-flex justify-content-center">
                                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('delivery_person_edit')): ?>
                                            <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                                                <a href="<?php echo e(url('admin/delivery_person/'.$delivery_person->id.'/edit')); ?>" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="<?php echo e(__('Edit')); ?>"><i class="fas fa-pencil-alt"></i></a>
                                            <?php endif; ?>
                                            <?php if(Auth::user()->load('roles')->roles->contains('title', 'vendor')): ?>
                                                <a href="<?php echo e(url('vendor/deliveryPerson/'.$delivery_person->id.'/edit')); ?>" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="<?php echo e(__('Edit')); ?>"><i class="fas fa-pencil-alt"></i></a>
                                            <?php endif; ?>
                                        <?php endif; ?>
                                        <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                                            <a href="<?php echo e(url('admin/delivery_person/'.$delivery_person->id)); ?>" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="<?php echo e(__('show Delivery person')); ?>"><i class="fas fa-eye"></i></a>
                                        <?php endif; ?>
                                        <?php if(Auth::user()->load('roles')->roles->contains('title', 'vendor')): ?>
                                            <a href="<?php echo e(url('vendor/deliveryPerson/'.$delivery_person->id)); ?>" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="<?php echo e(__('show Delivery person')); ?>"><i class="fas fa-eye"></i></a>
                                        <?php endif; ?>
                                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('delivery_person_edit')): ?>
                                            <a href="javascript:void(0);" class="table-action ml-2 btn btn-danger btn-action" onclick="deleteData('admin/delivery_person',<?php echo e($delivery_person->id); ?>,'Delivery Person')">
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
            </div>
            <div class="card-footer">
                <input type="button" value="Delete selected" onclick="deleteAll('delivery_person_multi_delete','Delivery Person')" class="btn btn-primary">
            </div>
        </div>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'delivery_person'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /var/www/html/dev.transporter-sudan.com/resources/views/admin/delivery person/delivery_person.blade.php ENDPATH**/ ?>