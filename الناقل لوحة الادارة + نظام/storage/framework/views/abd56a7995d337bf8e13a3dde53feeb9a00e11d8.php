<?php $__env->startSection('title','Create A Vendor'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e(__('Create new vendor')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item"><a href="<?php echo e(url('admin/vendor')); ?>"><?php echo e(__('Vendor')); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('create a vendor')); ?></div>
        </div>
    </div>

    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Vendor Management System')); ?></h2>
        <p class="section-lead"><?php echo e(__('create vendor')); ?></p>
        <form class="container-fuild" action="<?php echo e(url('admin/vendor')); ?>" method="post" enctype="multipart/form-data">
            <?php echo csrf_field(); ?>
            <div class="card">
                <div class="card-header">
                    <h6 class="c-grey-900"><?php echo e(__('Vendor')); ?></h6>
                </div>
                <div class="card-body">
                    <?php echo csrf_field(); ?>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="Promo code name"><?php echo e(__('Vendor image')); ?></label>
                            <div class="logoContainer">
                                <img id="image" src="<?php echo e(url('images/upload/impageplaceholder.png')); ?>" width="180"
                                    height="150">
                            </div>
                            <div class="fileContainer sprite">
                                <span><?php echo e(__('Image')); ?></span>
                                <input type="file" name="image" value="Choose File" id="previewImage" data-id="add" accept=".png, .jpg, .jpeg, .svg">
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
                                <img id="licence_doc" src="<?php echo e(url('images/upload/impageplaceholder.png')); ?>" width="180"
                                    height="150">
                            </div>
                            <div class="fileContainer">
                                <span><?php echo e(__('Image')); ?></span>
                                <input type="file" name="vendor_logo" value="Choose File" id="previewlicence_doc" data-id="add" accept=".png, .jpg, .jpeg, .svg">
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="Vendor name"><?php echo e(__('Vendor Name')); ?><span
                                    class="text-danger">&nbsp;*</span></label>
                            <input type="text" name="name" class="form-control <?php $__errorArgs = ['name'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>"
                                placeholder="<?php echo e(__('Vendor Name')); ?>" value="<?php echo e(old('name')); ?>" required="">

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
                            <input type="email" name="email_id" value="<?php echo e(old('email_id')); ?>" class="form-control <?php $__errorArgs = ['email_id'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" placeholder="<?php echo e(__('Email Address')); ?>">

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
                                            <option value="+<?php echo e($phone_code->phonecode); ?>">+<?php echo e($phone_code->phonecode); ?></option>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    </select>
                                </div>
                                <div class="col-md-9 p-0">
                                    <input type="number" value="<?php echo e(old('contact')); ?>" name="contact" value="<?php echo e(old('contact')); ?>" required class="form-control  <?php $__errorArgs = ['contact'];
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
            <h6 class="c-grey-900"><?php echo e(__('Select Tags (For Seller it will be categorys)')); ?><span class="text-danger">&nbsp;*</span></h6>
        </div>
        <div class="card-body">
            <div class="mT-30">
                <div class="row">
                    <div class="col-md-12 mb-3">
                        <label for="First name"><?php echo e(__('Tags')); ?></label>
                        <select class="select2 form-control" name="category_id[]" multiple="true">
                            <?php $__currentLoopData = $categorys; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $category): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <option value="<?php echo e($category->id); ?>" <?php echo e((collect(old('category_id'))->contains($category->id)) ? 'selected':''); ?>><?php echo e($category->name); ?></option>
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
                                    <input id="pac-input" type="text" name="map_address" value="<?php echo e(old('map_address')); ?>" class="form-control" placeholder="Enter A Location" />
                                    <input type="hidden" name="lat" value="<?php echo e(15.500654); ?>" id="lat">
                                    <input type="hidden" name="lang" value="<?php echo e(32.559898); ?>" id="lang">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label for="min_order_amount"><?php echo e(__('Vendor Full Address')); ?><span class="text-danger">&nbsp;*</span></label>
                                <input type="text" class="form-control" name="address" value="<?php echo e(old('address')); ?>" placeholder="<?php echo e(__('Vendor Full Address')); ?>" id="location">
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
                        <input type="number" min=1 name="min_order_amount" placeholder="<?php echo e(__('Minimum Order Amount')); ?>" value="<?php echo e(old('min_order_amount')); ?>" required class="form-control <?php $__errorArgs = ['min_order_amount'];
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
                        <input type="number" max=100 min=1 name="sp" placeholder="<?php echo e(__('Small Package')); ?>" value="<?php echo e(old('sp')); ?>" required class="form-control  <?php $__errorArgs = ['sp'];
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
                        <input type="number" max=100 min=1 name="mp" placeholder="<?php echo e(__('Medium Package')); ?>" value="<?php echo e(old('mp')); ?>" required class="form-control  <?php $__errorArgs = ['mp'];
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
                        <input type="number" max=100 min=1 name="lp" placeholder="<?php echo e(__('Large Package')); ?>" value="<?php echo e(old('lp')); ?>" required class="form-control  <?php $__errorArgs = ['lp'];
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
                        <input value="2880" type="number" min=1 name="avg_delivery_time" value="<?php echo e(old('avg_delivery_time')); ?>" placeholder="<?php echo e(__('Avg Delivery Time(in min)')); ?>" required class="form-control <?php $__errorArgs = ['avg_delivery_time'];
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
                        <input type="text" name="license_number" value="<?php echo e(old('license_number')); ?>" required placeholder="<?php echo e(__('Business License Number')); ?>" class="form-control <?php $__errorArgs = ['license_number'];
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
                            <option value="amount" <?php echo e((collect(old('admin_comission_type'))->contains('amount')) ? 'selected':''); ?>><?php echo e(__('Amount')); ?></option>
                            <option value="percentage" <?php echo e((collect(old('admin_comission_type'))->contains('percentage')) ? 'selected':''); ?>><?php echo e(__('Percenatge')); ?></option>
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
                        <input type="text" name="admin_comission_value" value="<?php echo e(old('admin_comission_value')); ?>" placeholder="<?php echo e(__('Admin Comission Value')); ?>" required class="form-control">

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
                            <option value="all" <?php echo e((collect(old('vendor_type'))->contains('all')) ? 'selected':''); ?>>
                                <?php echo e(__('All')); ?></option>
                            <option value="new" <?php echo e((collect(old('vendor_type'))->contains('new')) ? 'selected':''); ?>>
                                <?php echo e(__('New item\'s only')); ?></option>
                            <option value="used"
                                <?php echo e((collect(old('vendor_type'))->contains('used')) ? 'selected':''); ?>>
                                <?php echo e(__('Used item\'s only')); ?></option>

                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="admin_commision_value"><?php echo e(__('Time slots')); ?><span
                                class="text-danger">&nbsp;*</span></label>
                        <select name="time_slot" class="form-control">
                            <option value="15" <?php echo e((collect(old('time_slot'))->contains('15')) ? 'selected':''); ?>>
                                <?php echo e(__('15 mins')); ?></option>
                            <option value="30" <?php echo e((collect(old('time_slot'))->contains('30')) ? 'selected':''); ?>>
                                <?php echo e(__('30 mins')); ?></option>
                            <option value="45" <?php echo e((collect(old('time_slot'))->contains('45')) ? 'selected':''); ?>>
                                <?php echo e(__('45 mins')); ?></option>
                            <option value="60" <?php echo e((collect(old('time_slot'))->contains('60')) ? 'selected':''); ?>>
                                <?php echo e(__('1 hour')); ?></option>
                            <option value="120" <?php echo e((collect(old('time_slot'))->contains('120')) ? 'selected':''); ?>>
                                <?php echo e(__('2 hour')); ?></option>
                            <option value="180" <?php echo e((collect(old('time_slot'))->contains('180')) ? 'selected':''); ?>>
                                <?php echo e(__('3 hour')); ?></option>
                            <option value="240" <?php echo e((collect(old('time_slot'))->contains('240')) ? 'selected':''); ?>>
                                <?php echo e(__('4 hour')); ?></option>
                            <option value="300" <?php echo e((collect(old('time_slot'))->contains('300')) ? 'selected':''); ?>>
                                <?php echo e(__('5 hour')); ?></option>
                        </select>
                    </div>
                </div>

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label for="tax"><?php echo e(__('vendor language')); ?></label>
                        <select name="vendor language" class="form-control">
                            <?php $__currentLoopData = $languages; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $language): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <option value="<?php echo e($language->name); ?>"><?php echo e($language->name); ?></option>
                            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12 mb-3">
                        <input type="checkbox" id="chkbox" name="vendor_own_driver">
                        <label for="chkbox"><?php echo e(__('Vendor Has Own Driver??')); ?></label>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <label for="<?php echo e(__('status')); ?>"><?php echo e(__('Status')); ?></label><br>
                        <label class="switch">
                            <input type="checkbox" name="status">
                            <div class="slider"></div>
                        </label>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <label for="Explorer"><?php echo e(__('Explorer ??')); ?></label><br>
                        <label class="switch">
                            <input type="checkbox" name="isExplorer">
                            <div class="slider"></div>
                        </label>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <label for="<?php echo e(__('isTop')); ?>"><?php echo e(__('Top Vendor ??')); ?></label><br>
                        <label class="switch">
                            <input type="checkbox" name="isTop">
                            <div class="slider"></div>
                        </label>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary"><?php echo e(__('Add Vendor')); ?></button>
                </div>
            </div>
        </div>
    </div>
    </form>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'vendor'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/vendor/create_vendor.blade.php ENDPATH**/ ?>