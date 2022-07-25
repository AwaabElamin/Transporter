<?php $__env->startSection('title','User Profile'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
    <h1><?php echo e(__('User profile')); ?></h1>
    <div class="section-header-breadcrumb">
        <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
        <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/user')); ?>"><?php echo e(__('user')); ?></a></div>
        <div class="breadcrumb-item"><?php echo e(__('User Profile')); ?></div>
    </div>
    </div>
    <div class="section-body">
    <h2 class="section-title"><?php echo e($user->name); ?></h2>
    <p class="section-lead">
        <?php echo e(__('Information about user')); ?>

    </p>

   <div class="row mt-sm-4">
        <div class="col-12 col-md-12 col-lg-12">
            <div class="card profile-widget">
                <div class="profile-widget-header">
                    <img alt="image" src="<?php echo e($user->image); ?>" class="rounded-circle profile-widget-picture">
                    <div class="profile-widget-items">
                        <div class="profile-widget-item">
                            <div class="profile-widget-item-label"><?php echo e(__('Total order')); ?></div>
                            <div class="profile-widget-item-value"><?php echo e(count($orders)); ?></div>
                        </div>
                        <div class="profile-widget-item">
                            <div class="profile-widget-item-label"><?php echo e(__('Pending')); ?></div>
                            <div class="profile-widget-item-value"><?php echo e(count($pending_orders)); ?></div>
                        </div>
                        <div class="profile-widget-item">
                            <div class="profile-widget-item-label"><?php echo e(__('Approve')); ?></div>
                            <div class="profile-widget-item-value"><?php echo e(count($complete_orders)); ?></div>
                        </div>
                    </div>
                </div>
                <div class="profile-widget-description">
                    <div class="profile-widget-name">
                        <?php echo e(__('User Name')); ?> : <?php echo e($user->name); ?><br>
                        <?php echo e(__('Phone number')); ?> : <?php echo e($user->phone); ?><br>
                        <?php echo e(__('Email')); ?> : <?php echo e($user->email_id); ?><br>
                    </div>
                </div>
            </div>
        </div>
   </div>
   <div class="row mt-sm-4">
        <div class="col-12 col-sm-12 col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h4><?php echo e($user->name); ?>  <?php echo e(__('order details')); ?></h4>
                </div>
                <div class="card-body">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active show" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home"
                                aria-selected="false"><?php echo e(__('All')); ?></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab"
                                aria-controls="profile" aria-selected="false"><?php echo e(__('Approve')); ?></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab"
                                aria-controls="contact" aria-selected="true"><?php echo e(__('Pending')); ?></a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade active show" id="home" role="tabpanel" aria-labelledby="home-tab">
                            <table class="datatable table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th><?php echo e(__('Order Id')); ?></th>
                                        <th><?php echo e(__('Vendor name')); ?></th>
                                        <th><?php echo e(__('User Name')); ?></th>
                                        <th><?php echo e(__('Date')); ?></th>
                                        <th><?php echo e(__('Time')); ?></th>
                                        <th><?php echo e(__('Order Status')); ?></th>
                                        <th><?php echo e(__('Payment status')); ?></th>
                                        <th><?php echo e(__('View')); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $__currentLoopData = $orders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $order): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <tr>
                                            <td><?php echo e($loop->iteration); ?></td>
                                            <td><?php echo e($order->order_id); ?></td>
                                            <td><?php echo e($order['vendor']->name); ?></td>
                                            <td><?php echo e($order['user']->name); ?></td>
                                            <td><?php echo e($order->date); ?></td>
                                            <td><?php echo e($order->time); ?></td>
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
                                                    <span class="badge badge-pill cancel"><?php echo e(__('REJECT')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'PICKUP'): ?>
                                                    <span class="badge badge-pill pickup"><?php echo e(__('PICKUP')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'DELIVERED'): ?>
                                                    <span class="badge badge-pill delivered"><?php echo e(__('REJECT')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'COMPLETE'): ?>
                                                    <span class="badge badge-pill complete"><?php echo e(__('COMPLETE')); ?></span>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php if($order->payment_status == 1): ?>
                                                    <div class="span"><?php echo e(__('payment complete')); ?></div>
                                                <?php endif; ?>

                                                <?php if($order->payment_status == 0): ?>
                                                    <div class="span"><?php echo e(__('payment not complete')); ?></div>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <a href="<?php echo e(url('admin/order/'.$order->id)); ?>" onclick="show_admin_order(<?php echo e($order->id); ?>)" data-toggle="modal" data-target="#view_order"><?php echo e(__('View Order')); ?></a>
                                            </td>
                                        </tr>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </tbody>
                            </table>
                        </div>
                        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                            <table class="datatable table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th><?php echo e(__('Order Id')); ?></th>
                                        <th><?php echo e(__('Vendor name')); ?></th>
                                        <th><?php echo e(__('User Name')); ?></th>
                                        <th><?php echo e(__('Date')); ?></th>
                                        <th><?php echo e(__('Time')); ?></th>
                                        <th><?php echo e(__('Order Status')); ?></th>
                                        <th><?php echo e(__('Payment status')); ?></th>
                                        <th><?php echo e(__('View')); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $__currentLoopData = $approve_orders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $order): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <tr>
                                            <td><?php echo e($loop->iteration); ?></td>
                                            <td><?php echo e($order->order_id); ?></td>
                                            <td><?php echo e($order['vendor']->name); ?></td>
                                            <td><?php echo e($order['user']->name); ?></td>
                                            <td><?php echo e($order->date); ?></td>
                                            <td><?php echo e($order->time); ?></td>
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
                                                    <span class="badge badge-pill cancel"><?php echo e(__('REJECT')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'PICKUP'): ?>
                                                    <span class="badge badge-pill pickup"><?php echo e(__('PICKUP')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'DELIVERED'): ?>
                                                    <span class="badge badge-pill delivered"><?php echo e(__('REJECT')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'COMPLETE'): ?>
                                                    <span class="badge badge-pill complete"><?php echo e(__('COMPLETE')); ?></span>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php if($order->payment_status == 1): ?>
                                                    <div class="span"><?php echo e(__('payment complete')); ?></div>
                                                <?php endif; ?>

                                                <?php if($order->payment_status == 0): ?>
                                                    <div class="span"><?php echo e(__('payment not complete')); ?></div>
                                                <?php endif; ?>
                                            </td>

                                            <td>
                                                <a href="<?php echo e(url('admin/order/'.$order->id)); ?>" onclick="show_admin_order(<?php echo e($order->id); ?>)" data-toggle="modal" data-target="#view_order"><?php echo e(__('View Order')); ?></a>
                                            </td>
                                        </tr>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </tbody>
                            </table>
                        </div>
                        <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
                            <table class="datatable table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th><?php echo e(__('Order Id')); ?></th>
                                        <th><?php echo e(__('Vendor name')); ?></th>
                                        <th><?php echo e(__('User Name')); ?></th>
                                        <th><?php echo e(__('Date')); ?></th>
                                        <th><?php echo e(__('Time')); ?></th>
                                        <th><?php echo e(__('Order Status')); ?></th>
                                        <th><?php echo e(__('Payment status')); ?></th>
                                        <th><?php echo e(__('View')); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php $__currentLoopData = $pending_orders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $order): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <tr>
                                            <td><?php echo e($loop->iteration); ?></td>
                                            <td><?php echo e($order->order_id); ?></td>
                                            <td><?php echo e($order['vendor']->name); ?></td>
                                            <td><?php echo e($order['user']->name); ?></td>
                                            <td><?php echo e($order->date); ?></td>
                                            <td><?php echo e($order->time); ?></td>
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
                                                    <span class="badge badge-pill cancel"><?php echo e(__('REJECT')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'PICKUP'): ?>
                                                    <span class="badge badge-pill pickup"><?php echo e(__('PICKUP')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'DELIVERED'): ?>
                                                    <span class="badge badge-pill delivered"><?php echo e(__('REJECT')); ?></span>
                                                <?php endif; ?>

                                                <?php if($order->order_status == 'COMPLETE'): ?>
                                                    <span class="badge badge-pill complete"><?php echo e(__('COMPLETE')); ?></span>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <?php if($order->payment_status == 1): ?>
                                                    <div class="span"><?php echo e(__('payment complete')); ?></div>
                                                <?php endif; ?>

                                                <?php if($order->payment_status == 0): ?>
                                                    <div class="span"><?php echo e(__('payment not complete')); ?></div>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <a href="<?php echo e(url('admin/order/'.$order->id)); ?>" onclick="show_admin_order(<?php echo e($order->id); ?>)" data-toggle="modal" data-target="#view_order"><?php echo e(__('View Order')); ?></a>
                                            </td>
                                        </tr>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="modal right fade" id="view_order" data-keyboard="false" tabindex="-1"
    aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-primary" id="staticBackdropLabel"><?php echo e(__('View order')); ?></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tr>
                        <th><?php echo e(__('Order Id')); ?></th>
                        <td class="show_order_id"></td>
                    </tr>
                    <tr>
                        <th><?php echo e(__('User name')); ?></th>
                        <td class="show_user_name"></td>
                    </tr>
                    <tr>
                        <th><?php echo e(__('date')); ?></th>
                        <td class="show_date"></td>
                    </tr>
                    <tr>
                        <th><?php echo e(__('time')); ?></th>
                        <td class="show_time"></td>
                    </tr>
                    <tr>
                        <th><?php echo e(__('Delivery At')); ?></th>
                        <td class="show_delivery_at"></td>
                    </tr>
                    <tr>
                        <th><?php echo e(__('Discount')); ?></th>
                        <td class="show_discount"></td>
                    </tr>
                    <tr>
                        <th><?php echo e(__('Total Amount')); ?></th>
                        <td class="show_total_amount"></td>
                    </tr>
                    <tr>
                        <th><?php echo e(__('Admin Commission')); ?></th>
                        <td class="show_admin_commission"></td>
                    </tr>
                    <tr>
                        <th><?php echo e(__('Vendor Commission')); ?></th>
                        <td class="show_vendor_amount"></td>
                    </tr>
                </table>
                <h6><?php echo e(__('tax')); ?></h6>
                <table class="table TaxTable">
                </table>
                <h6><?php echo e(__('Items')); ?></h6>
                <table class="table show_order_table">
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
            </div>
        </div>
    </div>
</div>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'user'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/user/show_user.blade.php ENDPATH**/ ?>