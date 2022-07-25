<?php $__env->startSection('title','Create A Faq'); ?>

<?php $__env->startSection('content'); ?>


<section class="section">
    <div class="section-header">
        <h1><?php echo e(__('Create new faq')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item"><a href="<?php echo e(url('admin/faq')); ?>"><?php echo e(__('faq')); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('create a faq')); ?></div>
        </div>
    </div>

    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('This is faq')); ?></h2>
        <p class="section-lead"><?php echo e(__('create faq')); ?></p>
        <form class="container-fuild" action="<?php echo e(url('admin/faq')); ?>" method="post"
            enctype="multipart/form-data">
            <?php echo csrf_field(); ?>
            <div class="card mt-2">
                <div class="card-body">
                    <div class="mT-30">
                        <div class="row">
                            <div class="col-md-12 mb-5">
                                <label for="type"><?php echo e(__('Faq for..')); ?><span class="text-danger">&nbsp;*</span></label>
                                <select class="form-control" name="type">
                                    <option value="customer"><?php echo e(__('customer')); ?></option>
                                    <option value="vendor"><?php echo e(__('vendor')); ?></option>
                                    <option value="driver"><?php echo e(__('driver')); ?></option>
                                </select>

                                <?php $__errorArgs = ['type'];
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
                            <div class="col-md-12 mb-5">
                                <label for="question"><?php echo e(__('question')); ?><span class="text-danger">&nbsp;*</span></label>
                                <textarea name="question" placeholder="<?php echo e(__('Question')); ?>" class="form-control"
                                    cols="30" rows="10"></textarea>
                                <?php $__errorArgs = ['question'];
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
                            <div class="col-md-12 mb-5">
                                <label for="<?php echo e(__('answer')); ?>"><?php echo e(__('answer')); ?><span class="text-danger">&nbsp;*</span></label>
                                <textarea name="answer" placeholder="<?php echo e(__('Answer')); ?>"
                                    class="form-control"><?php echo e(old('answer')); ?></textarea>
                                <?php $__errorArgs = ['answer'];
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

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary"
                                type="submit"><?php echo e(__('Add Faq')); ?></button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'faq'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/faq/create_faq.blade.php ENDPATH**/ ?>