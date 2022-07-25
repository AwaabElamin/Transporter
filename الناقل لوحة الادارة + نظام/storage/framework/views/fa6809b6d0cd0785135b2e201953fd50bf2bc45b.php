<?php $__env->startSection('title','Wallet WithDraw Report'); ?>

<?php $__env->startSection('content'); ?>
    <section class="section">
        <div class="section-header">
            <h1><?php echo e(__('Wallet WithDraw Report')); ?></h1>
            <div class="section-header-breadcrumb">
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Wallet WithDraw Report')); ?></div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                <div class="card p-3">
                    <form action="<?php echo e(url('admin/wallet_withdraw_report')); ?>" method="post">
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

        <div class="section-body">
            <div class="card">
                <div class="card-header">
                    <h4><?php echo e(__('Wallet Transaction Report')); ?></h4>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered report" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th><?php echo e(__('User')); ?></th>
                                    <th><?php echo e(__('Order Id')); ?></th>
                                    <th><?php echo e(__('vendor name')); ?></th>
                                    <th><?php echo e(__('Amount')); ?></th>
                                    <th><?php echo e(__('Date')); ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $__currentLoopData = $transactions; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $transaction): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <tr>
                                        <td><?php echo e($loop->iteration); ?></td>
                                        <th>
                                            <a href="<?php echo e(url('admin/user/user_wallet/'.$transaction->user['id'])); ?>"><?php echo e($transaction->user['name']); ?></a>
                                        </th>
                                        <td>
                                            <?php if(isset($transaction->order['order_id'])): ?>
                                                <?php echo e($transaction->order['order_id']); ?>

                                            <?php endif; ?>
                                        </td>
                                        <td>
                                            <?php if(isset($transaction->order['vendor']->name)): ?>
                                                <?php echo e($transaction->order['vendor']->name); ?>

                                            <?php endif; ?>
                                        </td>
                                        <td><?php echo e($currency); ?><?php echo e($transaction->amount); ?></td>
                                        <td><?php echo e($transaction->date); ?></td>
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

<?php echo $__env->make('layouts.app',['activePage' => 'wallet_transaction_report'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/report/wallet_withdraw_report.blade.php ENDPATH**/ ?>