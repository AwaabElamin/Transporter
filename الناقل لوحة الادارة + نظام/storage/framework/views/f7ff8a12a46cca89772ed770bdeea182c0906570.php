<?php $__env->startSection('title','Create A Role'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e(__('Create new role')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item"><a href="<?php echo e(url('admin/roles')); ?>"><?php echo e(__('role')); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('create a role')); ?></div>
        </div>
    </div>

    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Role and Permission Management System')); ?></h2>
        <p class="section-lead"><?php echo e(__('create role')); ?></p>
        <div class="card">
            <div class="card-body">
                <form class="container-fuild" action="<?php echo e(url('admin/roles')); ?>" method="post">
                    <?php echo csrf_field(); ?>
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="role"><?php echo e(__('role title')); ?></label>
                            <input type="text" name="title" class="form-control <?php $__errorArgs = ['title'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" placeholder="<?php echo e(__('Role Name')); ?>" value="<?php echo e(old('title')); ?>" required="">
                            <?php $__errorArgs = ['title'];
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
                    </div>

                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="role"><?php echo e(__('Permissions')); ?></label>
                            <select name="permissions[]" class="select2 form-control" multiple>
                                <?php $__currentLoopData = $permissions; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $permission): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <option value="<?php echo e($permission->id); ?>"><?php echo e($permission->title); ?></option>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                            </select>

                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-primary" type="submit"><?php echo e(__('Add role')); ?></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'role'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/role/create_role.blade.php ENDPATH**/ ?>