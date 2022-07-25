<?php $__env->startSection('title','Edit Vendor'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e(__('Edit Vendor')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item"><a href="<?php echo e(url('admin/vendor')); ?>"><?php echo e(__('vendor')); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('Edit vendor')); ?></div>
        </div>
    </div>
    <?php if($errors->any()): ?>
        <div class="alert alert-primary alert-dismissible show fade">
            <div class="alert-body">
                <button class="close" data-dismiss="alert">
                    <span>×</span>
                </button>
                <?php $__currentLoopData = $errors->all(); $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $item): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                <?php echo e($item); ?>

                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
            </div>
        </div>
    <?php endif; ?>
   <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Vendor Management System')); ?></h2>
        <p class="section-lead"><?php echo e(__('Edit vendor detail')); ?></p>
        <form class="container-fuild" action="<?php echo e(url('admin/vendor/'.$vendor->id)); ?>" method="post" enctype="multipart/form-data">
            <?php echo csrf_field(); ?>
            <?php echo method_field('PUT'); ?>
            <div class="card">
                <div class="card-header">
                    <h6 class="c-grey-900"><?php echo e(__('Vendor')); ?></h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="Promo code name"><?php echo e(__('Vendor image')); ?></label>
                            <div class="logoContainer">
                                <img id="image" src="<?php echo e($vendor->image); ?>" width="180" height="150">
                            </div>
                            <div class="fileContainer sprite">
                                <span><?php echo e(__('Image')); ?></span>
                                <input type="file" name="image" value="Choose File" id="previewImage" data-id="edit" accept=".png, .jpg, .jpeg, .svg">
                            </div>
                            <?php $__errorArgs = ['image'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                            <span class="custom_error" role="alert">
                                <strong><?php echo e($message); ?></strong>
                            </span>
                            <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                        </div>
                        <div class="col-md-6 mb-5">
                            <label for="Image"><?php echo e(__('Vendor logo')); ?></label>
                            <div class="logoContainer">
                                <img id="licence_doc" src="<?php echo e($vendor->vendor_logo); ?>" width="180" height="150">
                            </div>
                            <div class="fileContainer">
                                <span><?php echo e(__('Image')); ?></span>
                                <input type="file" name="vendor_logo" data-id="edit" value="Choose File" id="previewlicence_doc" accept=".png, .jpg, .jpeg, .svg">
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="Vendor name"><?php echo e(__('Vendor Name')); ?><span class="text-danger">&nbsp;*</span></label>
                            <input type="text" name="name" class="form-control <?php $__errorArgs = ['name'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" placeholder="<?php echo e(__('Vendor Name')); ?>" value="<?php echo e($vendor->name); ?>" required="">

                            <?php $__errorArgs = ['name'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                            <span class="custom_error" role="alert">
                                <strong><?php echo e($message); ?></strong>
                            </span>
                            <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="<?php echo e(__('Email')); ?>"><?php echo e(__('Email Address')); ?><span class="text-danger">&nbsp;*</span></label>
                            <input type="email" name="email_id" value="<?php echo e($vendor->email_id); ?>" class="form-control <?php $__errorArgs = ['email_id'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" placeholder="<?php echo e(__('Email Address')); ?>" readonly>

                            <?php $__errorArgs = ['email_id'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                            <span class="custom_error" role="alert">
                                <strong><?php echo e($message); ?></strong>
                            </span>
                            <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                        </div>
                        <div class="col-md-6 mb-5">
                            <label for="<?php echo e(__('contact')); ?>"><?php echo e(__('Contact')); ?><span class="text-danger">&nbsp;*</span></label>
                            <div class="row">
                                <div class="col-md-3 p-0">
                                    <select name="phone_code" required class="form-control select2">
                                        <?php $__currentLoopData = $phone_codes; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $phone_code): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                            <option value="+<?php echo e($phone_code->phonecode); ?>" <?php echo e($user->phone_code == $phone_code->phonecode ? 'selected' : ''); ?>>+<?php echo e($phone_code->phonecode); ?></option>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    </select>
                                </div>
                                <div class="col-md-9 p-0">
                                    <input type="number" name="contact" value="<?php echo e($vendor->contact); ?>" required class="form-control  <?php $__errorArgs = ['contact'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">
                                    <?php $__errorArgs = ['contact'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                    <span class="custom_error" role="alert">
                                        <strong><?php echo e($message); ?></strong>
                                    </span>
                                    <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-2">
                <div class="card-header">
                    <h6 class="c-grey-900"><?php echo e(__('Select Tags (For Seller it will be categorys)')); ?></h6>
                </div>
                <div class="card-body">
                    <div class="mT-30">
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="First name"><?php echo e(__('Tags')); ?><span class="text-danger">&nbsp;*</span></label>
                                <select class="select2 form-control" name="category_id[]" multiple="true">
                                    <?php $__currentLoopData = $categorys; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $category): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <option value="<?php echo e($category->id); ?>" <?php echo e(in_array($category->id,explode(',',$vendor->category_id)) ? 'selected' : ''); ?>><?php echo e($category->name); ?></option>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </select>
                                <?php $__errorArgs = ['category_id'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                <span class="custom_error" role="alert">
                                    <strong><?php echo e($message); ?></strong>
                                </span>
                                <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-2">
                <div class="card-header">
                    <h6 class="c-grey-900"><?php echo e(__('Location')); ?></h6>
                </div>
                <div class="card-body">
                    <div class="mT-30">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="row">
                                    <div class="pac-card col-md-12 mb-3" id="pac-card">
                                        <label for="pac-input"><?php echo e(__('Location based on latitude/lontitude')); ?><span class="text-danger">&nbsp;*</span></label>
                                        <div id="pac-container">
                                            <input id="pac-input" name="map_address" value="<?php echo e($vendor->map_address); ?>" type="text" class="form-control" placeholder="Enter A Location" />
                                            <input type="hidden" name="lat" value="<?php echo e($vendor->lat); ?>" id="lat">
                                            <input type="hidden" name="lang" value="<?php echo e($vendor->lang); ?>" id="lang">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <label for="min_order_amount"><?php echo e(__('Vendor full address')); ?><span class="text-danger">&nbsp;*</span></label>
                                        <input type="text" class="form-control" name="address" value="<?php echo e($vendor->address); ?>" placeholder="<?php echo e(__('Vendor Full Address')); ?>" id="location">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div id="map"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card mt-2">
                <div class="card-header">
                    <h6 class=""><?php echo e(__('Other Information')); ?></h6>
                </div>
                <div class="card-body">
                    <div class="mT-30">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="min_order_amount"><?php echo e(__('Minimum order amount')); ?><span class="text-danger">&nbsp;*</span></label>
                                <input type="number" min=1 name="min_order_amount" placeholder="<?php echo e(__('Minimum Order Amount')); ?>"
                                    value="<?php echo e($vendor->min_order_amount); ?>" required class="form-control <?php $__errorArgs = ['min_order_amount'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                                    <?php $__errorArgs = ['min_order_amount'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                    <span class="custom_error" role="alert">
                                        <strong><?php echo e($message); ?></strong>
                                    </span>
                                    <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                            </div>
                          <div class="col-md-6 mb-3">
                        <label for="sp"><?php echo e(__('Small Package')); ?><span class="text-danger">&nbsp;*</span></label>
                        <input type="number" max=100 min=1 name="sp" placeholder="<?php echo e(__('Small Package')); ?>" value="<?php echo e($vendor->sp); ?>" required class="form-control  <?php $__errorArgs = ['sp'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                        <?php $__errorArgs = ['min_order_amount'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                        <span class="custom_error" role="alert">
                            <strong><?php echo e($message); ?></strong>
                        </span>
                        <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="sp"><?php echo e(__('Medium Package')); ?><span class="text-danger">&nbsp;*</span></label>
                        <input type="number" max=100 min=1 name="mp" placeholder="<?php echo e(__('Medium Package')); ?>" value="<?php echo e($vendor->mp); ?>" required class="form-control  <?php $__errorArgs = ['mp'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                        <?php $__errorArgs = ['min_order_amount'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                        <span class="custom_error" role="alert">
                            <strong><?php echo e($message); ?></strong>
                        </span>
                        <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="sp"><?php echo e(__('Large Package')); ?><span class="text-danger">&nbsp;*</span></label>
                        <input type="number" max=100 min=1 name="lp" placeholder="<?php echo e(__('Large Package')); ?>" value="<?php echo e($vendor->lp); ?>" required class="form-control  <?php $__errorArgs = ['lp'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                        <?php $__errorArgs = ['min_order_amount'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                        <span class="custom_error" role="alert">
                            <strong><?php echo e($message); ?></strong>
                        </span>
                        <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                    </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="avg_delivery_time"><?php echo e(__('Avg. delivery time(in min)')); ?><span class="text-danger">&nbsp;*</span></label>
                                <input type="number" min=1 name="avg_delivery_time" value="<?php echo e($vendor->avg_delivery_time); ?>" placeholder="<?php echo e(__('Avg Delivery Time(in min)')); ?>" required class="form-control <?php $__errorArgs = ['avg_delivery_time'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                                <?php $__errorArgs = ['avg_delivery_time'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                <span class="custom_error" role="alert">
                                    <strong><?php echo e($message); ?></strong>
                                </span>
                                <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="license_number"><?php echo e(__('Business License number')); ?><span class="text-danger">&nbsp;*</span></label>
                                <input type="text" name="license_number" value="<?php echo e($vendor->license_number); ?>"  required placeholder="<?php echo e(__('Business License Number')); ?>" class="form-control <?php $__errorArgs = ['license_number'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">

                                <?php $__errorArgs = ['license_number'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                <span class="custom_error" role="alert">
                                    <strong><?php echo e($message); ?></strong>
                                </span>
                                <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="admin_comission_type"><?php echo e(__('Admin commission type')); ?><span class="text-danger">&nbsp;*</span></label>
                                <select name="admin_comission_type" class="form-control">
                                    <option value="amount" <?php echo e($vendor->admin_comission_type == 'amount' ? 'selected':''); ?>><?php echo e(__('Amount')); ?></option>
                                    <option value="percentage" <?php echo e($vendor->admin_comission_type == 'percentage' ? 'selected':''); ?>><?php echo e(__('Percenatge')); ?></option>
                                </select>

                                <?php $__errorArgs = ['admin_commission_type'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                <span class="custom_error" role="alert">
                                    <strong><?php echo e($message); ?></strong>
                                </span>
                                <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="admin_commision_value"><?php echo e(__('Admin comission value')); ?><span class="text-danger">&nbsp;*</span></label>
                                <input type="number" min=1 name="admin_comission_value" value="<?php echo e($vendor->admin_comission_value); ?>" placeholder="<?php echo e(__('Admin Comission Value')); ?>" required class="form-control">

                                <?php $__errorArgs = ['admin_commision_value'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                <span class="custom_error" role="alert">
                                    <strong><?php echo e($message); ?></strong>
                                </span>
                                <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="vendor_type"><?php echo e(__('Vendor type')); ?><span class="text-danger">&nbsp;*</span></label>
                                <select name="vendor_type" class="form-control">
                                    <option value="all" <?php echo e($vendor->vendor_type == 'all' ? 'selected':''); ?>><?php echo e(__('All')); ?></option>
                                    <option value="veg" <?php echo e($vendor->vendor_type == 'veg' ? 'selected':''); ?>><?php echo e(__('pure veg')); ?></option>
                                    <option value="non_veg" <?php echo e($vendor->vendor_type == 'non_veg' ? 'selected':''); ?>><?php echo e(__('none veg')); ?></option>
                                    <option value="non_applicable" <?php echo e($vendor->vendor_type == 'non_applicable' ? 'selected':''); ?>><?php echo e(__('non applicable')); ?></option>
                                </select>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="admin_commision_value"><?php echo e(__('Time slots')); ?><span class="text-danger">&nbsp;*</span></label>
                                <select name="time_slot" class="form-control">
                                    <option value="15"  <?php echo e($vendor->time_slot == '15' ? 'selected':''); ?>><?php echo e(__('15 mins')); ?></option>
                                    <option value="30"  <?php echo e($vendor->time_slot == '30' ? 'selected':''); ?>><?php echo e(__('30 mins')); ?></option>
                                    <option value="45"  <?php echo e($vendor->time_slot == '45' ? 'selected':''); ?>><?php echo e(__('45 mins')); ?></option>
                                    <option value="60"  <?php echo e($vendor->time_slot == '60' ? 'selected':''); ?>><?php echo e(__('1 hour')); ?></option>
                                    <option value="120" <?php echo e($vendor->time_slot == '120' ? 'selected':''); ?>><?php echo e(__('2 hour')); ?></option>
                                    <option value="180" <?php echo e($vendor->time_slot == '180' ? 'selected':''); ?>><?php echo e(__('3 hour')); ?></option>
                                    <option value="240" <?php echo e($vendor->time_slot == '240' ? 'selected':''); ?>><?php echo e(__('4 hour')); ?></option>
                                    <option value="300" <?php echo e($vendor->time_slot == '300' ? 'selected':''); ?>><?php echo e(__('5 hour')); ?></option>
                                </select>
                            </div>
                        </div>

                        <div class="row">



                            <div class="col-md-6 mb-3">
                                <label for="tax"><?php echo e(__('vendor language')); ?></label>
                                <select name="vendor language" class="form-control">
                                    <?php $__currentLoopData = $languages; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $language): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <option value="<?php echo e($language->name); ?>" <?php echo e($language->name == $vendor->vendor_language ? 'selected' : ''); ?>><?php echo e($language->name); ?></option>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <input type="checkbox" id="chkbox" name="vendor_own_driver" <?php echo e($vendor->vendor_own_driver == 1 ? 'checked' : ''); ?>>
                                <label for="chkbox"><?php echo e(__('Vendor Has Own Driver??')); ?></label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <label for="<?php echo e(__('status')); ?>"><?php echo e(__('Status')); ?></label><br>
                                <label class="switch">
                                    <input type="checkbox" name="status" <?php echo e($vendor->status == 1 ? 'checked' : ''); ?>>
                                    <div class="slider"></div>
                                </label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <label for="Explorer"><?php echo e(__('Explorer ??')); ?></label><br>
                                <label class="switch">
                                    <input type="checkbox" name="isExplorer" <?php echo e($vendor->isExplorer == 1 ? 'checked' : ''); ?>>
                                    <div class="slider"></div>
                                </label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <label for="<?php echo e(__('isTop')); ?>"><?php echo e(__('Top Vendor ??')); ?></label><br>
                                <label class="switch">
                                    <input type="checkbox" name="isTop" <?php echo e($vendor->isTop == 1 ? 'checked' : ''); ?>>
                                    <div class="slider"></div>
                                </label>
                            </div>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary" type="submit"><?php echo e(__('Update Vendor')); ?></button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'vendor'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /var/www/html/dev.transporter-sudan.com/resources/views/admin/vendor/edit_vendor.blade.php ENDPATH**/ ?>