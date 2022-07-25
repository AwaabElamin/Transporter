<?php $__env->startSection('title','role'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <?php if(Session::has('msg')): ?>
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
    <?php endif; ?>

    <div class="section-header">
        <h1><?php echo e(__('Roles')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('role')); ?></div>
        </div>
    </div>

    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Role and Permission Management System')); ?></h2>
        <p class="section-lead"><?php echo e(__('Add, Edit, Update Or Delete User Roles.')); ?></p>
        <div class="card">
            <div class="card-header">
                <div class="w-100">
                    <a href="<?php echo e(url('admin/roles/create')); ?>" class="btn btn-primary float-right"><?php echo e(__('Add New')); ?></a>
                </div>
            </div>
            <div class="card-body table-responsive">
                <table id="datatable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th><?php echo e(__('Role name')); ?></th>
                            <th><?php echo e(__('permissions')); ?></th>
                            <th><?php echo e(__('Action')); ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $__currentLoopData = $roles; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $role): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <tr>
                                <td><?php echo e($loop->iteration); ?></td>
                                <td><?php echo e($role->title); ?></td>
                                <td>
                                    <?php $__empty_1 = true; $__currentLoopData = $role->permissions; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $permission): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
                                        <span class="badge badge-lg badge-primary m-1"><?php echo e($permission->title); ?></span>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
                                        <span class="badge  badge-lg badge-warning m-1"><?php echo e(__('No Data')); ?></span>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <a href="<?php echo e(url('admin/roles/'.$role->id.'/edit')); ?>" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="<?php echo e(__('Edit roles')); ?>"><i class="fas fa-pencil-alt"></i></a>
                                </td>
                            </tr>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'role'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/role/role.blade.php ENDPATH**/ ?>