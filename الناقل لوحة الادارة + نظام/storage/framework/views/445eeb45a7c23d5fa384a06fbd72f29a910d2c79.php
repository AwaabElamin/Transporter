<?php $__env->startSection('title','Category'); ?>

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
        <h1><?php echo e(__('categorys')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('Category')); ?></div>
        </div>
    </div>
    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Category menu')); ?></h2>
        <p class="section-lead"><?php echo e(__('Add, Edit, Manage Category')); ?></p>
        <div class="card">
            <div class="card-header">
                <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('category_add')): ?>
                    <div class="w-100">
                        <a href="<?php echo e(url('admin/category/create')); ?>" class="btn btn-primary float-right"><?php echo e(__('add new')); ?></a>
                    </div>
                <?php endif; ?>
            </div>
            <div class="card-body">
                <table id="datatable" class="table table-striped table-bordered text-center" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>
                                <input name="select_all" value="1" id="master" type="checkbox" />
                                <label for="master"></label>
                            </th>
                            <th>#</th>
                            <th><?php echo e(__('Image')); ?></th>
                            <th><?php echo e(__('Category name')); ?></th>
                            <th><?php echo e(__('Enable')); ?></th>
                            <?php if(Gate::check('category_edit')): ?>
                                <th><?php echo e(__('Action')); ?></th>
                            <?php endif; ?>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $__currentLoopData = $categorys; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $category): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <tr>
                                <td>
                                    <input name="id[]" value="<?php echo e($category->id); ?>" id="<?php echo e($category->id); ?>" data-id="<?php echo e($category->id); ?>" class="sub_chk" type="checkbox" />
                                    <label for="<?php echo e($category->id); ?>"></label>
                                </td>
                                <td><?php echo e($loop->iteration); ?></td>
                                <td>
                                    <img src="<?php echo e($category->image); ?>" class="rounded" width="50" height="50" alt="">
                                </td>
                                <td><?php echo e($category->name); ?></td>
                                <td>
                                    <label class="switch">
                                        <input type="checkbox" name="status" onclick="change_status('admin/category',<?php echo e($category->id); ?>)" <?php echo e(($category->status == 1) ? 'checked' : ''); ?>>
                                        <div class="slider"></div>
                                    </label>
                                </td>
                                <?php if(Gate::check('category_edit')): ?>
                                    <td>
                                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('category_edit')): ?>
                                            <a href="<?php echo e(url('admin/category/'.$category->id.'/edit')); ?>" class="btn btn-primary btn-action mr-1"><i class="fas fa-pencil-alt"></i></a>
                                        <?php endif; ?>
                                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('category_delete')): ?>
                                            <a href="javascript:void(0);" class="table-action ml-2 btn btn-danger btn-action" onclick="deleteData('admin/category',<?php echo e($category->id); ?>,'Category')">
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
                <input type="button" value="Delete selected" onclick="deleteAll('category_multi_delete','Category')" class="btn btn-primary">
            </div>
        </div>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'category'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/category/category.blade.php ENDPATH**/ ?>