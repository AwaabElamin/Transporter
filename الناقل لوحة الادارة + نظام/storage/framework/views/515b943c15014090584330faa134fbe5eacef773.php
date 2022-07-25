<?php $__env->startSection('title','Banner'); ?>

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
    });
    </script>
    <?php endif; ?>
    <div class="section-header">
        <h1><?php echo e(__('Banner')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="section-header-breadcrumb">
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Banner')); ?></div>
            </div>
        </div>
    </div>
    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Banner Management System')); ?></h2>
        <p class="section-lead"><?php echo e(__('Manage Your Banners Within App.')); ?></p>
        <div class="card">
            <div class="card-header">
                <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('banner_add')): ?>
                    <div class="w-100">
                        <a href="<?php echo e(url('admin/banner/create')); ?>" class="btn btn-primary float-right"><?php echo e(__('Add banner')); ?></a>
                    </div>
                <?php endif; ?>
            </div>
            <div class="card-body">
                <table id="datatable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>
                                <input name="select_all" value="1" id="master" type="checkbox" />
                                <label for="master"></label>
                            </th>
                            <th>#</th>
                            <th><?php echo e(__('banner image')); ?></th>
                            <th><?php echo e(__('banner name')); ?></th>
                            <th><?php echo e(__('Enable')); ?></th>
                            <?php if(Gate::check('banner_edit') && Gate::check('banner_delete')): ?>
                                <th><?php echo e(__('Action')); ?></th>
                            <?php endif; ?>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $__currentLoopData = $banners; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $banner): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <tr>
                                <td>
                                    <input name="id[]" value="<?php echo e($banner->id); ?>" id="<?php echo e($banner->id); ?>" data-id="<?php echo e($banner->id); ?>" class="sub_chk" type="checkbox" />
                                    <label for="<?php echo e($banner->id); ?>"></label>
                                </td>
                                <th><?php echo e($loop->iteration); ?></th>
                                <td>
                                    <img src="<?php echo e($banner->image); ?>" width="50" height="50" class="rounded" alt="">
                                </td>
                                <td><?php echo e($banner->name); ?></td>
                                <td>
                                    <label class="switch">
                                        <input type="checkbox" name="status" onclick="change_status('admin/banner',<?php echo e($banner->id); ?>)" <?php echo e(($banner->status == 1) ? 'checked' : ''); ?>>
                                        <div class="slider"></div>
                                    </label>
                                </td>
                                <?php if(Gate::check('banner_edit') && Gate::check('banner_delete')): ?>
                                    <td>
                                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('banner_edit')): ?>
                                            <a href="<?php echo e(url('admin/banner/'.$banner->id.'/edit')); ?>" class="btn btn-primary" data-toggle="tooltip" title="" data-original-title="<?php echo e(__('Edit')); ?>"><i class="fas fa-pencil-alt"></i></a>
                                        <?php endif; ?>
                                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('banner_delete')): ?>
                                            <a href="javascript:void(0);" class="table-action ml-2 btn btn-danger btn-action" onclick="deleteData('admin/banner',<?php echo e($banner->id); ?>,'Banner')">
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
                <input type="button" value="Delete selected" onclick="deleteAll('banner_multi_delete','Banner')" class="btn btn-primary">
            </div>
        </div>
    </div>
</section>

<?php $__env->stopSection(); ?>


<?php echo $__env->make('layouts.app',['activePage' => 'banner'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/banner/banner.blade.php ENDPATH**/ ?>