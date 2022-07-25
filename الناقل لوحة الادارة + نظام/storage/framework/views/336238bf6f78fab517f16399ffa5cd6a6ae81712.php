<?php $__env->startSection('title','Vendor Payment'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e($vendor->name); ?>&nbsp;<?php echo e("Settlement"); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item active">
                <a href="<?php echo e(url('admin/vendor/'.$vendor->id)); ?>"><?php echo e(App\Models\Vendor::find($vendor->id)->name); ?></a>
            </div>
            <div class="breadcrumb-item"><?php echo e(__('vendor payment')); ?></div>
        </div>
    </div>

    <div class="section-body">
        <div class="loading" style="display: none;"></div>
        <div class="content">
        </div>
        <input type="hidden" name="amount" value="<?php echo e($amount); ?>">
        <input type="hidden" name="duration" value="<?php echo e($duration); ?>">
        <input type="hidden" name="hidden_currency" value="<?php echo e($currency); ?>">
        <input type="hidden" name="vendor" value="<?php echo e($vendor->id); ?>">

        <h2 class="section-title"><?php echo e(__("Vendor payment")); ?></h2>
        <p class="section-lead"><?php echo e(__('Vendor payment')); ?></p>
        <div class="row">
            <div class="col-12 col-sm-6 col-md-6 col-lg-3">
                <div class="card">
                    <div class="card-body">
                        <table class="table">
                            <?php if($paymentSetting->paypal == 1): ?>
                            <tr>
                                <td>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="paypal" name="paymentradio" class="custom-control-input">
                                        <label class="custom-control-label float-right" for="paypal"><?php echo e(__('Paypal')); ?></label>
                                    </div>
                                </td>
                            </tr>
                            <?php endif; ?>
                            <?php if($paymentSetting->razorpay == 1): ?>
                            <tr>
                                <td>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="razor" name="paymentradio" class="custom-control-input">
                                        <label class="custom-control-label" for="razor"><?php echo e(__('Razorpay')); ?></label>
                                    </div>
                                </td>
                            </tr>
                            <?php endif; ?>
                            <?php if($paymentSetting->stripe == 1): ?>
                            <tr>
                                <td>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="stripe" name="paymentradio"
                                            class="custom-control-input">
                                        <label class="custom-control-label" for="stripe"><?php echo e(__('Stripe')); ?></label>
                                    </div>
                                </td>
                            </tr>
                            <?php endif; ?>
                            <?php if($paymentSetting->flutterwave == 1): ?>
                            <tr>
                                <td>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="flutterwave" name="paymentradio"
                                            class="custom-control-input">
                                        <label class="custom-control-label"
                                            for="flutterwave"><?php echo e(__('Flutterwave')); ?></label>
                                    </div>
                                </td>
                            </tr>
                            <?php endif; ?>
                            <tr>
                                <td>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="cod" checked name="paymentradio"
                                            class="custom-control-input">
                                        <label class="custom-control-label" for="cod"><?php echo e(__('COD')); ?></label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-9">
                
                <div class="card hide paypal_card">
                    <div class="card-header">
                        <h4><?php echo e(__('settlement with paypal')); ?></h4>
                    </div>
                    <div class="card-body paypal_card_body">
                    </div>
                </div>

                
                <div class="card hide razor_card">
                    <div class="card-header">
                        <h4><?php echo e(__('settlement with Razorpay')); ?></h4>
                    </div>
                    <div class="card-body">
                        <form id="rzp-footer-form" action="<?php echo e(url('razor')); ?>" method="POST">
                            <?php echo csrf_field(); ?>
                            <br />
                            <?php
                            $razor_publish_key = App\Models\PaymentSetting::find(1)->razorpay_publish_key
                            ?>
                            <input type="hidden" name="RAZORPAY_KEY" id="RAZORPAY_KEY" value="<?php echo e($razor_publish_key); ?>">
                            <div class="pay">
                                <button class="razorpay-payment-button btn btn-primary" id="paybtn" type="button"><?php echo e(__('Pay with Razorpay')); ?></button>
                            </div>
                        </form>
                    </div>
                </div>

                
                <div class="card hide stripe_card">
                    <div class="card-header">
                        <h4><?php echo e(__('settlement with stripe')); ?></h4>
                    </div>
                    <div class="alert alert-warning alert-dismissible fade show hide stripe_alert" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="card-body">
                        <form role="form" action="" method="post" class="require-validation customform" data-cc-on-file="false" data-stripe-publishable-key="<?php echo e(App\Models\PaymentSetting::find(1)->stripe_publish_key); ?>" id="stripe-payment-form">
                            <?php echo csrf_field(); ?>
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <label><?php echo e(__('Email')); ?></label>
                                        <input type="email" class="email form-control required" title="Enter Your Email"
                                            name="email" required />
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <label><?php echo e(__('Card Information')); ?></label>
                                        <input type="text" class="card-number required form-control"
                                            title="please input only number." pattern="[0-9]{16}" name="card-number"
                                            placeholder="1234 1234 1234 1234" title="Card Number" required />
                                        <div class="row" style="margin-top:-2px;">
                                            <div class="col-lg-6 pr-0">
                                                <input type="text" class="expiry-date required form-control" name="expiry-date" title="Expiration date" title="please Enter data in MM/YY format." pattern="(0[1-9]|10|11|12)/[0-9]{2}$" placeholder="MM/YY" required />
                                                <input type="hidden" class="card-expiry-month required form-control" name="card-expiry-month" />
                                                <input type="hidden" class="card-expiry-year required form-control" name="card-expiry-year" />
                                            </div>

                                            <div class="col-lg-6 pl-0">
                                                <input type="text" class="card-cvc required form-control" title="please input only number." pattern="[0-9]{3}" name="card-cvc" placeholder="CVC" title="CVC" required />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-group">
                                        <label><?php echo e(__('Name on card')); ?></label>
                                        <input type="text" class="required form-control" name="name"
                                            title="Name on Card" required />
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group text-center">
                                        <input type="submit" class="btn btn-primary mt-4 btn-submit" value="Pay" />
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                
                <div class="card hide flutter_card">
                    <div class="card-header">
                        <h4><?php echo e(__('Settlement with flutterwave')); ?></h4>
                    </div>
                    <div class="card-body">
                        <form action="<?php echo e(url('admin/fluterPayment')); ?>" method="post">
                            <?php echo csrf_field(); ?>
                            <input type="hidden" name="vendor" value="<?php echo e($vendor->id); ?>">
                            <input type="hidden" name="amount" value="<?php echo e($amount); ?>">
                            <input type="hidden" name="duration" value="<?php echo e($duration); ?>">
                            <input type="submit" value="Flutterwave" class="btn btn-primary">
                            
                        </form>
                    </div>
                </div>

                
                <div class="card cod_card">
                    <div class="card-header">
                        <h4><?php echo e(__('settlement with cod')); ?></h4>
                    </div>
                    <div class="card-body">
                        <input type="button" onclick="settlement()" value="<?php echo e(__('Pay offline')); ?>" class="btn btn-primary">
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'vendor'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/vendor/make_payment.blade.php ENDPATH**/ ?>