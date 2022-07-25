<?php $__env->startSection('title','Edit Delivery Person'); ?>

<?php $__env->startSection('content'); ?>

<section class="section">
    <div class="section-header">
        <h1><?php echo e(__('Edit delivery person')); ?></h1>
        <div class="section-header-breadcrumb">
            <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item"><a href="<?php echo e(url('admin/delivery_person')); ?>"><?php echo e(__('Delivery Person')); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Edit a Delivery person')); ?></div>
            <?php endif; ?>
            <?php if(Auth::user()->load('roles')->roles->contains('title', 'vendor')): ?>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('vendor/vendor_home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
                <div class="breadcrumb-item active"><a href="<?php echo e(url('vendor/deliveryPerson')); ?>"><?php echo e($delivery_person->first_name .' - '. $delivery_person->last_name); ?></a></div>
                <div class="breadcrumb-item"><?php echo e(__('Edit a Delivery person')); ?></div>
            <?php endif; ?>
        </div>
    </div>

    <div class="section-body">
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
        <h2 class="section-title"><?php echo e(__('delivery person management')); ?></h2>
        <p class="section-lead"><?php echo e(__('Edit delivery person')); ?></p>
        <form class="container-fuild" action="<?php echo e(url('admin/delivery_person/'.$delivery_person->id)); ?>" method="post" enctype="multipart/form-data">
            <?php echo csrf_field(); ?>
            <?php echo method_field('PUT'); ?>
            <div class="card">
                <div class="card-header">
                    <h6 class="c-grey-900"><?php echo e(__('Delivery Person personal information')); ?></h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-12 mb-5">
                            <label for="Promo code name"><?php echo e(__('Delivery Person image')); ?></label>
                            <div class="logoContainer">
                                <img id="image" src="<?php echo e($delivery_person->image); ?>" width="180" height="150">
                            </div>
                            <div class="fileContainer sprite">
                                <span><?php echo e(__('Image')); ?></span>
                                <input type="file" name="image" value="Choose File" id="previewImage" data-id="edit" accept=".png, .jpg, .jpeg, .svg">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-5">
                            <label for="First name"><?php echo e(__('First Name')); ?><span class="text-danger">&nbsp;*</span></label>
                            <input type="text" name="first_name" class="form-control <?php $__errorArgs = ['first_name'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" placeholder="<?php echo e(__('First Name')); ?>" value="<?php echo e($delivery_person->first_name); ?>" required="">

                            <?php $__errorArgs = ['first_name'];
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
                            <label for="<?php echo e(__('last name')); ?>"><?php echo e(__('Last Name')); ?><span class="text-danger">&nbsp;*</span></label>
                            <input type="text" name="last_name" class="form-control <?php $__errorArgs = ['last_name'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" placeholder="<?php echo e(__('Last name')); ?>" value="<?php echo e($delivery_person->last_name); ?>" required="">
                            <?php $__errorArgs = ['last_name'];
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
                        <div class="col-md-6 mb-5">
                            <label for="<?php echo e(__('Email')); ?>"><?php echo e(__('Email Address')); ?><span class="text-danger">&nbsp;*</span></label>
                            <input type="text" name="email_id" value="<?php echo e($delivery_person->email_id); ?>" class="form-control <?php $__errorArgs = ['email_id'];
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
                                            <option value="+<?php echo e($phone_code->phonecode); ?>" <?php echo e($delivery_person->phone_code == $phone_code->phonecode ? 'selected' : ''); ?>>+<?php echo e($phone_code->phonecode); ?></option>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    </select>
                                </div>
                                <div class="col-md-9 p-0">
                                    <input type="number" value="<?php echo e($delivery_person->contact); ?>" name="contact" required class="form-control  <?php $__errorArgs = ['contact'];
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

                    <div class="row">
                        <div class="col-md-6 mb-5">
                            <label for="<?php echo e(__('delivery_zone')); ?>"><?php echo e(__('Delivery Zone')); ?><span class="text-danger">&nbsp;*</span></label>

                            <select class="form-control  select2 <?php $__errorArgs = ['delivery_zone_id'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>  <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" name="delivery_zone_id">
                                <?php $__currentLoopData = $delivery_zones; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $item): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <option value="<?php echo e($item->id); ?>" <?php echo e($item->id == $delivery_person->delivery_zone_id ? 'selected' : ''); ?>><?php echo e($item->name); ?></option>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                            </select>

                            <?php $__errorArgs = ['delivery_zone_id'];
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
                            <label for="<?php echo e(__('full_address')); ?>"><?php echo e(__('Full Address')); ?><span class="text-danger">&nbsp;*</span></label>

                            <textarea name="full_address" class="form-control"><?php echo e($delivery_person->full_address); ?></textarea>
                            <?php $__errorArgs = ['full_address'];
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
                        <div class="col-md-6">
                            <label for="<?php echo e(__('max_user')); ?>"><?php echo e(__('Status')); ?></label><br>
                            <label class="switch">
                                <input type="checkbox" name="status" <?php echo e($delivery_person->status == '1' ? 'checked' : ''); ?>>
                                <div class="slider"></div>
                            </label>
                        </div>

                        <div class="col-md-6">
                            <label for="<?php echo e(__('max_user')); ?>"><?php echo e(__('Is online')); ?></label><br>
                            <label class="switch">
                                <input type="checkbox" name="is_online" <?php echo e($delivery_person->is_online == '1' ? 'checked' : ''); ?>>
                                <div class="slider"></div>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-2">
                <div class="card-header">
                    <h6 class="c-grey-900"><?php echo e(__('Vehical Information')); ?></h6>
                </div>
                <div class="card-body">
                    <div class="mT-30">
                        <div class="row">
                            <div class="col-md-6 mb-5">
                                <label for="First name"><?php echo e(__('Vahicle Type')); ?><span class="text-danger">&nbsp;*</span></label>
                                <select name="vehicle_type" class="form-control select2 <?php $__errorArgs = ['vehicle_type'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>  <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>">
                                    <option value="car" <?php echo e($delivery_person->vehicle_type == 'car' ? 'selected' : ''); ?>><?php echo e(__('Car')); ?></option>
                                    <option value="bike" <?php echo e($delivery_person->vehicle_type == 'bike' ? 'selected' : ''); ?>><?php echo e(__('bike')); ?></option>
                                </select>

                                <?php $__errorArgs = ['vehicle_type'];
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
                                <label for="<?php echo e(__('Vehicle number')); ?>"><?php echo e(__('Vehicle number')); ?><span class="text-danger">&nbsp;*</span></label>
                                <input type="text" name="vehicle_number" class="form-control <?php $__errorArgs = ['vehicle_number'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" placeholder="<?php echo e(__('vehicle Number')); ?>" value="<?php echo e($delivery_person->vehicle_number); ?>" required="">

                                <?php $__errorArgs = ['vehicle_number'];
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
                            <div class="col-md-6 mb-5">
                                <label for="<?php echo e(__('License number')); ?>"><?php echo e(__('License number')); ?><span class="text-danger">&nbsp;*</span></label>
                                <input type="text" name="licence_number" value="<?php echo e($delivery_person->licence_number); ?>"
                                    class="form-control <?php $__errorArgs = ['licence_number'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" placeholder="<?php echo e(__('licence number')); ?>">

                                <?php $__errorArgs = ['licence_number'];
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
                                <label for="<?php echo e(__('Percent')); ?>"><?php echo e(__('Percent')); ?><span class="text-danger">&nbsp;*</span></label>
                                <input type="number" min="0" max="100" name="percent" value="<?php echo e($delivery_person->percent); ?>"
                                    class="form-control <?php $__errorArgs = ['percent'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is_invalide <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" placeholder="<?php echo e(__('percent')); ?>">

                                <?php $__errorArgs = ['percent'];
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
                            <div class="col-md-6 mb-5">
                                <label for="Image"><?php echo e(__('national identity Document')); ?></label>
                                <div class="logoContainer">
                                    <img id="national_identity" src="<?php echo e(url('images/upload/'.$delivery_person->national_identity)); ?>" width="180" height="150">
                                </div>
                                <div class="fileContainer">
                                    <span><?php echo e(__('Image')); ?></span>
                                    <input type="file" name="national_identity" value="Choose File"  id="previewnational_identity" accept=".png, .jpg, .jpeg, .svg">
                                </div>
                            </div>
                            <div class="col-md-6 mb-5">
                                <label for="Image"><?php echo e(__('License Document')); ?></label>
                                <div class="logoContainer">
                                    <img id="licence_doc" src="<?php echo e(url('images/upload/'.$delivery_person->licence_doc)); ?>" width="180" height="150">
                                </div>
                                <div class="fileContainer">
                                    <span><?php echo e(__('Image')); ?></span>
                                    <input  type="file" name="licence_doc" value="Choose File" id="previewlicence_doc" accept=".png, .jpg, .jpeg, .svg">
                                </div>
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary" type="submit"><?php echo e(__('Update Delivery person')); ?></button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'delivery_person'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /var/www/html/dev.transporter-sudan.com/resources/views/admin/delivery person/edit_delivery_person.blade.php ENDPATH**/ ?>