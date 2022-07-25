<?php $__env->startSection('title','Vendor Finance Details'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e($vendor->name); ?>&nbsp;<?php echo e('Finance details'); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/vendor/'.$vendor->id)); ?>"><?php echo e(App\Models\Vendor::find($vendor->id)->name); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('vendor finance details')); ?></div>
        </div>
    </div>

    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Vendor Management System')); ?></h2>
        <p class="section-lead"><?php echo e(__('Finance details')); ?></p>
        <div class="card">
            <div class="card-header text-right">
                <h4><?php echo e(__('Last 7 days earning')); ?></h4>
            </div>
            <div class="card-body">
                <table id="monthFinance" class="table table-striped table-bordered" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th><?php echo e(__('Date')); ?></th>
                            <th><?php echo e(__('Order Amount')); ?></th>
                            <th><?php echo e(__('Admin Commission')); ?></th>
                            <th><?php echo e(__('vendor earning')); ?></th>
                        </tr>
                    </thead>
                    <tbody class="month_finance">
                        <?php $__currentLoopData = $orders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $order): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                        <tr>
                            <td><?php echo e($loop->iteration); ?></td>
                            <td><?php echo e($order['date']); ?></td>
                            <td><?php echo e($currency); ?><?php echo e($order['amount']); ?></td>
                            <td><?php echo e($currency); ?><?php echo e($order['admin_commission']); ?></td>
                            <td><?php echo e($currency); ?><?php echo e($order['vendor_amount']); ?></td>
                        </tr>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="card">
            <div class="card-header text-right">
                <h4><?php echo e(__('Settlements')); ?></h4>
                <span class="badge badge-success"><?php echo e(__('admin gives to vendor')); ?></span>&nbsp;
                <span class="badge badge-danger"><?php echo e(__('vendor gives to admin')); ?></span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="datatable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th><?php echo e(__('duration')); ?></th>
                                <th><?php echo e(__('Order count')); ?></th>
                                <th><?php echo e(__('Admin Earning')); ?></th>
                                <th><?php echo e(__('Vendor earning')); ?></th>
                                <th><?php echo e(__('Settles amount')); ?></th>
                                <th><?php echo e(__('Settles')); ?></th>
                                <th><?php echo e(__('view')); ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $__currentLoopData = $settels; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $settel): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <tr>
                                    <td><?php echo e($loop->iteration); ?></td>
                                    <td id="duration<?php echo e($loop->iteration); ?>"><?php echo e($settel['duration']); ?></td>
                                    <td><?php echo e($settel['d_total_task']); ?></td>
                                    <td><?php echo e($currency); ?><?php echo e($settel['admin_earning']); ?></td>
                                    <td><?php echo e($currency); ?><?php echo e($settel['vendor_earning']); ?></td>
                                    <td>
                                        <?php if($settel['d_balance'] > 0): ?>
                                            
                                            <span class="badge badge-success"><?php echo e($currency); ?><?php echo e(abs($settel['d_balance'])); ?></span>
                                        <?php else: ?>
                                            
                                            <span class="badge badge-danger"><?php echo e($currency); ?><?php echo e(abs($settel['d_balance'])); ?></span>
                                        <?php endif; ?>
                                    </td>
                                    <td>
                                       <?php if(abs($settel['d_balance']) > 0): ?>
                                          <form action="<?php echo e(url('admin/make_payment')); ?>" method="post">
                                            <?php echo csrf_field(); ?>
                                                <input type="hidden" name="duration" value="<?php echo e($settel['duration']); ?>">
                                                <input type="hidden" name="vendor" value="<?php echo e($vendor->id); ?>">
                                                <button type="submit" class="btn btn-primary"><?php echo e(__('Settle')); ?></button>
                                          </form>
                                        <?php else: ?>
                                            <button type="submit" class="btn btn-primary" disabled><?php echo e(__('Settle')); ?></button>
                                        <?php endif; ?>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-primary" onclick="show_settle_details(<?php echo e($loop->iteration); ?>)" data-toggle="modal" data-target="#exampleModal">
                                            <?php echo e(__('Show settlement details')); ?>

                                        </button>
                                    </td>
                                </tr>
                            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><?php echo e(__('Show settlement details')); ?></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body details_body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
            </div>
        </div>
    </div>
</div>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'vendor'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/vendor/finance_details.blade.php ENDPATH**/ ?>