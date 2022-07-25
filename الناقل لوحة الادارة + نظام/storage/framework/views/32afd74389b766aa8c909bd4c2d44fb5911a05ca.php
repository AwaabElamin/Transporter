<?php $__env->startSection('title','Vendor Discount'); ?>

<?php $__env->startSection('content'); ?>
<?php if(Session::has('msg')): ?>
    <script>
        var msg = "<?php echo Session::get('msg'); ?>"
        $(window).on('load', function()
        {
            iziToast.success(
            {
                message: msg,
                position: 'topRight'
            });
    });
    </script>
<?php endif; ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e(__('vendor discount')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/vendor/'.$id)); ?>"><?php echo e(App\Models\Vendor::find($id)->name); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('Vendor Discount')); ?></div>
        </div>
    </div>
    <div class="section-body">
        <h2 class="section-title"><?php echo e(__("Vendor discount")); ?></h2>
        <p class="section-lead"><?php echo e(__('Vendor discount')); ?></p>
        <div class="card">
            <div class="card-header">
                <div class="w-100">
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('vendor_discount_add')): ?>
                        <a href="<?php echo e(url('admin/vendor_discount/create/'.$id)); ?>" class="btn btn-primary float-right"><?php echo e(__('Add New')); ?></a>
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
                                <th><?php echo e(__('Discount image')); ?></th>
                                <th><?php echo e(__('Discount type')); ?></th>
                                <th><?php echo e(__('Discount')); ?></th>
                                <th><?php echo e(__('Start to end date')); ?></th>
                                <?php if(Gate::check('vendor_discount_edit') || Gate::check('vendor_discount_delete')): ?>
                                    <th><?php echo e(__('Action')); ?></th>
                                <?php endif; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $__currentLoopData = $discounts; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $discount): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <tr>
                                    <td>
                                        <input name="id[]" value="<?php echo e($discount->id); ?>" id="<?php echo e($discount->id); ?>" data-id="<?php echo e($discount->id); ?>" class="sub_chk" type="checkbox" />
                                        <label for="<?php echo e($discount->id); ?>"></label>
                                    </td>
                                    <td><?php echo e($loop->iteration); ?></td>
                                    <td>
                                        <img src="<?php echo e(url('images/upload/'.$discount->image)); ?>" width="50" height="50" class="rounded" alt="">
                                    </td>
                                    <td><?php echo e($discount->type); ?></td>
                                    <td>
                                        <?php if($discount->type == 'amount'): ?>
                                            <?php echo e($currency); ?><?php echo e($discount->discount); ?>

                                        <?php endif; ?>
                                        <?php if($discount->type == 'percentage'): ?>
                                            <?php echo e($discount->discount); ?>%
                                        <?php endif; ?>
                                    </td>
                                    <td><?php echo e($discount->start_end_date); ?></td>
                                    <?php if(Gate::check('vendor_discount_edit') || Gate::check('vendor_discount_delete')): ?>
                                        <td>
                                            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('vendor_discount_edit')): ?>
                                                <a href="<?php echo e(url('admin/vendor_discount/'.$discount->id.'/edit')); ?>" class="btn btn-primary btn-action mr-1" data-toggle="tooltip" title="" data-original-title="Edit"><i class="fas fa-pencil-alt"></i></a>
                                            <?php endif; ?>

                                            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('vendor_discount_delete')): ?>
                                                <a href="javascript:void(0);" class="table-action btn btn-danger btn-action" onclick="deleteData('vendor/vendor_discount',<?php echo e($discount->id); ?>,'Vendor Discount')">
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
                <input type="button" value="Delete selected" onclick="deleteAll('vendor_discount_multi_delete','Vendor Discount')" class="btn btn-primary">
            </div>
        </div>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'vendor'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/vendor discount/vendor_discount.blade.php ENDPATH**/ ?>