<?php $__env->startSection('title','Invoice'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e(__('Invoice')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('Invoice')); ?></div>
        </div>
    </div>
    <?php
        $discount = intval(00);
        $cust = "";
        $totalCust= 0;
        $itemPrice = 0;
    ?>
    <?php if($order->promo_code_price != null): ?>
        <?php
            $discount += intval($order->promo_code_price);
        ?>
    <?php elseif($order->vendor_discount_price != null): ?>
        <?php
            $discount += intval($order->vendor_discount_price);
        ?>
    <?php endif; ?>

    <?php
        $delivery_charge = 0;
    ?>
    <?php if($order->delivery_charge != null): ?>
        <?php
            $delivery_charge = $order->delivery_charge
        ?>
    <?php endif; ?>

    <?php
        $tax = 0;
    ?>
    <?php if($order->tax != null): ?>
        <?php
            $taxs = $order->tax;
            foreach (json_decode($taxs) as $t)
            {
                $tax = $tax + $t->tax;
            }
        ?>
    <?php endif; ?>

    <div class="section-body">
        <div class="invoice">
            <div class="invoice-print">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="invoice-title">
                            <h2><?php echo e(__('Invoice')); ?></h2>
                            <div class="invoice-number"><?php echo e(__('Order')); ?> <?php echo e($order->order_id); ?></div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-6">
                                <address>
                                    <strong><?php echo e(__('Billed To:')); ?></strong><br>
                                    <?php echo e($general_setting->business_name); ?><br>
                                    <?php echo e($general_setting->business_address); ?>

                                </address>
                            </div>
                            <div class="col-md-6 text-md-right">
                                <address>
                                    <strong><?php echo e(__('user')); ?></strong><br>
                                    <?php echo e($order['user']->name); ?><br>
                                    <?php echo e($order['user']->email); ?><br>
                                    <?php echo e($order['user']->phone); ?><br>
                                </address>
                            </div>
                        </div>
                        <div class="row">
                            <div class="offset-md-6 col-md-6 text-md-right">
                                <address>
                                    <strong><?php echo e(__('Order Date:')); ?></strong><br>
                                    <?php echo e($order->date); ?>&nbsp;<?php echo e($order->time); ?><br><br>
                                </address>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="section-title"><?php echo e(__('Order Summary')); ?></div>
                        <p class="section-lead"><?php echo e(__('All items here cannot be deleted.')); ?></p>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover table-md">
                                <tbody>
                                    <tr>
                                        <th data-width="40" style="width: 40px;">#</th>
                                        <th><?php echo e(__('Item')); ?></th>
                                        <th class="text-center"><?php echo e(__('Price')); ?></th>
                                        <th class="text-center"><?php echo e(__('Quantity')); ?></th>
                                        <th class="text-center"><?php echo e(__('Custimization')); ?></th>
                                        <th class="text-center"><?php echo e(__('Custimization price')); ?></th>
                                        <th class="text-right"><?php echo e(__('Totals')); ?></th>
                                    </tr>
                                    <?php $__currentLoopData = $order->orderItems; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $item): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <tr>
                                        <td><?php echo e($loop->iteration); ?></td>
                                        <td><?php echo e($item['itemName']); ?></td>
                                        <td class="text-center">
                                            <?php echo e($general_setting->currency_symbol); ?><?php echo e($item->price); ?>

                                        </td>
                                        <td class="text-center"><?php echo e($item->qty); ?></td>
                                        <?php if($item->custimization != null): ?>
                                            <?php $__currentLoopData = $item->custimization; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $custimize): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                <?php
                                                    $cust = $cust ." ". $custimize->data->name.",";
                                                    $totalCust += $custimize->data->price;
                                                ?>
                                            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                            <td class="text-center"><?php echo e($cust); ?></td>
                                            <td class="text-center"><?php echo e($totalCust); ?></td>
                                        <?php else: ?>
                                            <?php
                                                $totalCust= 0;
                                            ?>

                                            <td class="text-center"><?php echo e(__('Not included')); ?></td>
                                            <td class="text-center"><?php echo e(__('Not included')); ?></td>
                                        <?php endif; ?>
                                        <td class="text-right"><?php echo e($general_setting->currency_symbol); ?><?php echo e($item->price + $totalCust); ?></td>
                                        <?php
                                            $itemPrice = $item->price + $totalCust;
                                        ?>
                                    </tr>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </tbody>
                            </table>

                            <div class="section-title mt-5"><?php echo e(__('Tax')); ?></div>
                            <p class="section-lead"><?php echo e(__('Tax Description.')); ?></p>
                            <table class="table table-striped table-hover table-md text-center">
                                <tbody>
                                    <tr>
                                        <th data-width="40" style="width: 40px;">#</th>
                                        <th><?php echo e(__('Tax Name')); ?></th>
                                        <th><?php echo e(__('Tax value')); ?></th>
                                    </tr>
                                    <?php $__currentLoopData = json_decode($order->tax); $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $ts): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <tr>
                                        <td><?php echo e($loop->iteration); ?></td>
                                        <td><?php echo e($ts->name); ?></td>
                                        <td>
                                            <?php echo e($general_setting->currency_symbol); ?><?php echo e($ts->tax); ?>

                                        </td>
                                    </tr>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </tbody>
                            </table>
                        </div>
                        <div class="row mt-4">
                            <div class="offset-lg-8 col-lg-4 text-right">
                                <div class="invoice-detail-item">
                                    <div class="invoice-detail-name"><?php echo e(__('Tax')); ?></div>
                                    <div class="invoice-detail-value">
                                        <?php echo e($general_setting->currency_symbol); ?><?php echo e($tax); ?></div>
                                </div>
                                <div class="invoice-detail-item">
                                    <div class="invoice-detail-name"><?php echo e(__('Subtotal')); ?></div>
                                    <div class="invoice-detail-value">
                                        <?php echo e($general_setting->currency_symbol); ?><?php echo e($itemPrice); ?></div>
                                </div>
                                <div class="invoice-detail-item">
                                    <div class="invoice-detail-name"><?php echo e(__('Shipping')); ?></div>
                                    <div class="invoice-detail-value">
                                        <?php echo e($general_setting->currency_symbol); ?><?php echo e($delivery_charge); ?>

                                    </div>
                                </div>

                                <div class="invoice-detail-item">
                                    <div class="invoice-detail-name"><?php echo e(__('Discount')); ?></div>
                                    <div class="invoice-detail-value">
                                        <?php echo e($general_setting->currency_symbol); ?><?php echo e($discount); ?>

                                    </div>
                                </div>
                                <hr class="mt-2 mb-2">
                                <div class="invoice-detail-item">
                                    <div class="invoice-detail-name"><?php echo e(__('Total')); ?></div>
                                    <div class="invoice-detail-value invoice-detail-value-lg">
                                        <?php echo e($general_setting->currency_symbol); ?><?php echo e($order->amount); ?>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <div class="text-md-left">
                <a href="<?php echo e(url('admin/order/invoice_print/'.$order->id)); ?>" target="_blank" class="btn btn-primary btn-icon icon-left"><i class="fas fa-print"></i> <?php echo e(__('Print')); ?></a>
            </div>
        </div>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'order'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/order/invoice.blade.php ENDPATH**/ ?>