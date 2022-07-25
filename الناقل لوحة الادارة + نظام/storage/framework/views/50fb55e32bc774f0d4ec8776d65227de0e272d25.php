<?php $__env->startSection('title','Order Report'); ?>

<?php $__env->startSection('content'); ?>
    <section class="section">
        <div class="section-header">
            <h1><?php echo e(__('order report')); ?></h1>
            <div class="section-header-breadcrumb">
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('order report')); ?></div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                <div class="card p-3">
                    <form action="<?php echo e(url('admin/order_report')); ?>" method="post">
                        <?php echo csrf_field(); ?>
                        <div class="row">
                            <div class="col-md-6 col-lg-6 col-12">
                                <input type="text" name="date_range" class="form-control">
                            </div>
                            <div class="col-md-6 col-lg-6 col-12">
                                <input type="submit" value="<?php echo e(__('apply')); ?>" class="btn btn-primary">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-md-6 col-sm-6 col-12">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-danger"><i class="far fa-user"></i></div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4><?php echo e(__('Total orders')); ?></h4>
                        </div>
                        <div class="card-body">
                            <?php echo e(count($orders)); ?>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6 col-12">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-success"><i class="fas fa-circle"></i></div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4><?php echo e(__('This month earning')); ?></h4>
                        </div>
                        <div class="card-body">
                            <?php echo e($currency); ?><?php echo e($month_earning); ?>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6 col-12">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-warning"><i class="fas fa-circle"></i></div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4><?php echo e(__('This year earning')); ?></h4>
                        </div>
                        <div class="card-body">
                            <?php echo e($currency); ?><?php echo e($year_earning); ?>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section-body">
            <div class="card">
                <div class="card-header">
                    <div class="w-100">
                        <h4><?php echo e(__('Order report')); ?></h4>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered report" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th><?php echo e(__('Order Id')); ?></th>
                                    <th><?php echo e(__('Vendor name')); ?></th>
                                    <th><?php echo e(__('User name')); ?></th>
                                    <th><?php echo e(__('Order date')); ?></th>
                                    <th><?php echo e(__('Order time')); ?></th>
                                    <th><?php echo e(__('amount')); ?></th>
                                    <th><?php echo e(__('Tax')); ?></th>
                                    <th><?php echo e(__('promo code price')); ?></th>
                                    <th><?php echo e(__('vendor discount price')); ?></th>
                                    <th><?php echo e(__('delivery charge')); ?></th>
                                    <th><?php echo e(__('payment type')); ?></th>
                                    <th><?php echo e(__('Order status')); ?></th>
                                    <th><?php echo e(__('Payment Status')); ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $__currentLoopData = $orders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $order): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <tr>
                                        <td><?php echo e($loop->iteration); ?></td>
                                        <td><?php echo e($order->order_id); ?></td>
                                        <td><?php echo e($order->vendor['name']); ?></td>
                                        <td><?php echo e($order->user['name']); ?></td>
                                        <td><?php echo e($order->date); ?></td>
                                        <td><?php echo e($order->time); ?></td>
                                        <td><?php echo e($currency); ?><?php echo e($order->amount); ?></td>
                                        <td>
                                            <?php if($order->tax == null): ?>
                                                <?php echo e($currency); ?>00
                                            <?php else: ?>
                                                <?php
                                                    $t = 0;
                                                    $taxs = json_decode($order->tax);
                                                    if(is_array($taxs))
                                                    {
                                                        foreach ($taxs as $tax)
                                                        {
                                                            $t += intval($tax->tax);
                                                        }
                                                    }
                                                ?>
                                            <?php endif; ?>
                                            <?php echo e($currency); ?><?php echo e($t); ?>

                                        </td>
                                        <td>
                                            <?php if($order->promocode_price == null): ?>
                                                <?php echo e($currency); ?><?php echo e(00); ?>

                                            <?php else: ?>
                                                <?php echo e($currency); ?><?php echo e($order->promocode_price); ?>

                                            <?php endif; ?>
                                        </td>
                                        <td><?php echo e($currency); ?><?php echo e($order->vendor_discount_price); ?></td>
                                            <?php if($order->delivery_charge == null): ?>
                                                <td><?php echo e($currency); ?>00</td>
                                            <?php else: ?>
                                                <td><?php echo e($currency); ?><?php echo e($order->delivery_charge); ?></td>
                                            <?php endif; ?>
                                            <td><?php echo e($order->payment_type); ?></td>
                                            <td>
                                                <?php if($order->order_status == 'PENDING'): ?>
                                                    <span class="badge badge-pill pending"><?php echo e(__('PENDING')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'APPROVE'): ?>
                                                    <span class="badge badge-pill approve"><?php echo e(__('APPROVE')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'REJECT'): ?>
                                                    <span class="badge badge-pill reject"><?php echo e(__('REJECT')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'CANCEL'): ?>
                                                    <span class="badge badge-pill cancel"><?php echo e(__('CANCEL')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'PICKUP'): ?>
                                                    <span class="badge badge-pill pickup"><?php echo e(__('PICKUP')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'DELIVERED'): ?>
                                                    <span class="badge badge-pill delivered"><?php echo e(__('DELIVERED')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'COMPLETE'): ?>
                                                    <span class="badge badge-pill complete"><?php echo e(__('COMPLETE')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'PREPARE_FOR_ORDER'): ?>
                                                    <span class="badge badge-pill preparre-food"><?php echo e(__('PREPARE FOR ORDER')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'READY_FOR_ORDER'): ?>
                                                    <span class="badge badge-pill ready_for_food"><?php echo e(__('READY FOR ORDER')); ?></span>
                                                <?php endif; ?>
                                            </td>
                                        <td>
                                            <?php if($order->payment_status == 1): ?>
                                                <div class="badge badge-success"><?php echo e(__('Complete')); ?></div>
                                            <?php else: ?>
                                                <div class="badge badge-danger"><?php echo e(__('Not complete')); ?></div>
                                            <?php endif; ?>
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

<?php $__env->stopSection(); ?>


<?php echo $__env->make('layouts.app',['activePage' => 'order_report'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/report/order_report.blade.php ENDPATH**/ ?>