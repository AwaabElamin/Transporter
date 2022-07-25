<?php $__env->startSection('title','Admin Profile'); ?>

<?php $__env->startSection('content'); ?>
    <?php if(Session::has('msg')): ?>
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
    <?php endif; ?>

    <?php if(Session::has('message')): ?>
    <div class="alert alert-danger alert-dismissible show fade">
        <div class="alert-body">
            <button class="close" data-dismiss="alert">
                <span>×</span>
            </button>
            <?php echo e(Session::get('message')); ?>

        </div>
    </div>
    <?php endif; ?>

    <section class="section">
        <div class="section-header">
            <h1><?php echo e(__('Admin profile')); ?></h1>
            <div class="section-header-breadcrumb">
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Admin profile')); ?></div>
            </div>
        </div>
        <div class="section-body">
            <h2 class="section-title"><?php echo e(__("Admin profile")); ?></h2>
            <p class="section-lead"><?php echo e(__('Admin profile')); ?></p>
        </div>
        <div class="card">
            <div class="card-body">
                <form method="post" action="<?php echo e(url('admin/update_admin_profile')); ?>" autocomplete="off" enctype="multipart/form-data">
                    <?php echo csrf_field(); ?>
                    <h6 class="heading-small text-muted mb-4"><?php echo e(__('Admin Information')); ?></h6>
                    <input type="hidden" name="id" value="<?php echo e($admin->id); ?>">
                    <div class="text-center">
                        <img src="<?php echo e($admin->image); ?>" id="update_image"  width="180" height="150"/>
                    </div>
                    <div class="form-group">
                        <div class="file-upload p-2">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" name="image" accept=".png, .jpg, .jpeg, .svg" id="customFileLang" lang="en">
                                <label class="custom-file-label" for="customFileLang"><?php echo e(__('Select file')); ?></label>
                            </div>
                        </div>
                        <?php $__errorArgs = ['image'];
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
                    <div class="pl-lg-4">
                        <div class="form-group">
                            <label class="form-control-label" for="input-name"><?php echo e(__('Name')); ?></label>
                            <input type="text" name="name" id="input-name" class="form-control" placeholder="<?php echo e(__('Name')); ?>" value="<?php echo e($admin->name); ?>" required="" autofocus="">

                        </div>
                        <div class="form-group">
                            <label class="form-control-label" for="input-email"><?php echo e(__('Email')); ?></label>
                            <input type="email" name="email" id="input-email" class="form-control"
                                placeholder="<?php echo e(__('Email')); ?>" value="<?php echo e($admin->email_id); ?>" readonly>
                        </div>

                        <div class="text-center">
                            <input type="submit" value="<?php echo e(__('Save')); ?>" class="btn btn-primary">
                        </div>
                    </div>
                </form>
                <hr class="my-4">

                <form method="post" action="<?php echo e(url('admin/update_password')); ?>">
                    <?php echo csrf_field(); ?>

                    <input type="hidden" name="id" value="">

                    <h6 class="heading-small text-muted mb-4"><?php echo e(__('Password')); ?></h6>

                    <div class="pl-lg-4">
                        <div class="form-group">
                            <label class="form-control-label" for="input-current-password"><?php echo e(__('Current Password')); ?></label>
                            <input type="password" name="old_password" id="input-current-password" class="form-control" placeholder="<?php echo e(__('Current Password')); ?>" required="">

                                <?php $__errorArgs = ['old_password'];
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
                        <div class="form-group">
                            <label class="form-control-label" for="input-password"><?php echo e(__('New Password')); ?></label>
                            <input type="password" name="password" id="input-password" class="form-control"
                                placeholder="<?php echo e(__('New Password')); ?>" required="">
                                <?php $__errorArgs = ['password'];
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
                        <div class="form-group">
                            <label class="form-control-label" for="input-password-confirmation"><?php echo e(__('Confirm New Password')); ?></label>
                            <input type="password" name="password_confirmation"
                                id="input-password-confirmation" class="form-control"
                                placeholder="<?php echo e(__('Confirm New Password')); ?>" required="">

                                <?php $__errorArgs = ['password_confirmation'];
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
                            <button type="submit" class="btn btn-primary mt-4"><?php echo e(__('Change password')); ?></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'admin_setting'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/admin setting/admin_profile.blade.php ENDPATH**/ ?>