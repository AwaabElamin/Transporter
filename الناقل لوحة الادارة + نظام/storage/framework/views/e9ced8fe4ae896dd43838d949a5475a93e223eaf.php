<?php $__env->startSection('title','Delivery Person'); ?>

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
            console.log(msg);
        });
    </script>
    <?php endif; ?>

    <div class="section-header">
        <h1><?php echo e(__('Delivery person')); ?></h1>
        <div class="section-header-breadcrumb">
            <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/delivery_person/'.$delivery_person->id)); ?>"><?php echo e($delivery_person->first_name .' - '. $delivery_person->last_name); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Delivery person order history')); ?></div>
            <?php endif; ?>
            <?php if(Auth::user()->load('roles')->roles->contains('title', 'vendor')): ?>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('vendor/vendor_home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('vendor/deliveryPerson')); ?>"><?php echo e($delivery_person->first_name .' - '. $delivery_person->last_name); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Delivery person order history')); ?></div>
            <?php endif; ?>
        </div>
    </div>
    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('This is Delivery Person')); ?></h2>
        <p class="section-lead"><?php echo e(__('Delivery person page.')); ?></p>
        <div class="card">
            <div class="card-header">
                <div class="w-100">
                    <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                        <?php if($delivery_person->vendor_id == null): ?>
                            <a href="<?php echo e(url('admin/delivery_person_finance_details/'.$delivery_person->id)); ?>" class="btn btn-primary float-right"><?php echo e(__('View finance details')); ?></a>
                        <?php endif; ?>
                    <?php endif; ?>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped text-center" id="datatable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th><?php echo e(__('Order Id')); ?></th>
                                <th><?php echo e(__('Vendor name')); ?></th>
                                <th><?php echo e(__('Date')); ?></th>
                                <th><?php echo e(__('Time')); ?></th>
                                <?php if($delivery_person->vendor_id == null): ?>
                                    <th><?php echo e(__('Delivery Charge')); ?></th>
                                <?php endif; ?>
                                <th><?php echo e(__('Order status')); ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $__currentLoopData = $orders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $order): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <tr>
                                    <th><?php echo e($loop->iteration); ?></th>
                                    <th><?php echo e($order->order_id); ?></th>
                                    <th><?php echo e($order->vendor['name']); ?></th>
                                    <th><?php echo e($order->date); ?></th>
                                    <th><?php echo e($order->time); ?></th>
                                    <?php if($delivery_person->vendor_id == null): ?>
                                        <th><?php echo e($order->delivery_charge); ?></th>
                                    <?php endif; ?>
                                    <th><?php echo e($order->order_status); ?></th>
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

<?php echo $__env->make('layouts.app',['activePage' => 'delivery_person'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/delivery person/show_delivery_person.blade.php ENDPATH**/ ?>