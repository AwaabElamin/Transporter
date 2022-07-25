<?php $__env->startSection('title','User Report'); ?>

<?php $__env->startSection('content'); ?>
    <section class="section">
        <div class="section-header">
            <h1><?php echo e(__('user report')); ?></h1>
            <div class="section-header-breadcrumb">
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('user report')); ?></div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-12">
                <div class="card p-3">
                    <form action="<?php echo e(url('admin/user_report')); ?>" method="post">
                        <?php echo csrf_field(); ?>
                        <div class="row">
                            <div class="col-md-6 col-lg-6 col-12">
                                <input type="text" name="date_range" value="" class="form-control">
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
                    <div class="card-icon bg-warning"><i class="fas fa-user-friends"></i></div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4><?php echo e(__('Total user')); ?></h4>
                        </div>
                        <div class="card-body">
                            <?php echo e(count($users)); ?>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6 col-12">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-success">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4><?php echo e(__('Total active users')); ?></h4>
                        </div>
                        <div class="card-body">
                            <?php echo e($active_user); ?>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6 col-12">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-danger"><i class="fas fa-user-lock"></i></div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4><?php echo e(__('Total block users')); ?></h4>
                        </div>
                        <div class="card-body">
                            <?php echo e($block_user); ?>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section-body">
            <div class="card">
                <div class="card-header">
                    <h4><?php echo e(__('user report')); ?></h4>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered report" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th><?php echo e(__('Name')); ?></th>
                                    <th><?php echo e(__('user profile')); ?></th>
                                    <th><?php echo e(__('email')); ?></th>
                                    <th><?php echo e(__('contact number')); ?></th>
                                    <th><?php echo e(__('Total order')); ?></th>
                                    <th><?php echo e(__('Remaining payment')); ?></th>
                                    <th><?php echo e(__('Active / Deactive')); ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $__currentLoopData = $users; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $user): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <tr>
                                        <td><?php echo e($loop->iteration); ?></td>
                                        <td>
                                            <a class="nav-link active" href="<?php echo e(url('admin/user/'.$user->id)); ?>"><?php echo e($user->name); ?></a></td>
                                        <td>
                                            <img src="<?php echo e($user->image); ?>" width="50" height="50" class="rounded-circle" alt="">
                                        </td>
                                        <td><?php echo e($user->email_id); ?></td>
                                        <td><?php echo e($user->phone); ?></td>
                                        <td><?php echo e(count($user->total_order)); ?></td>
                                        <td><?php echo e($currency); ?><?php echo e($user->remain_amount); ?></td>
                                        <td>
                                            <?php if($user->status == 1): ?>
                                                <div class="badge badge-success"><?php echo e(__('Active')); ?></div>
                                            <?php else: ?>
                                                <div class="badge badge-danger"><?php echo e(__('Deactive')); ?></div>
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


<?php echo $__env->make('layouts.app',['activePage' => 'user_report'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/report/user_report.blade.php ENDPATH**/ ?>