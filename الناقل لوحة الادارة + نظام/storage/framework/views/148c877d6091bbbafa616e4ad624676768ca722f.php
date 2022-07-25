<?php $__env->startSection('title','Show Vendor'); ?>

<?php $__env->startSection('content'); ?>
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

<section class="section">
    <div class="section-header">
        <h1><?php echo e($vendor->name); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="dropdown d-inline mr-2">
                <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <?php echo e(__('More')); ?>

                </button>
                <div class="dropdown-menu dropdown-menu-right" x-placement="bottom-start"
                    style="position: absolute; transform: translate3d(0px, 28px, 0px); top: 0px; left: 0px; will-change: transform;">
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_edit')): ?>
                    <a class="dropdown-item"
                        href="<?php echo e(url('admin/vendor/'.$vendor->id.'/edit')); ?>"><?php echo e(__('Edit Vendor')); ?></a>
                    <?php endif; ?>
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_discount_access')): ?>
                    <a class="dropdown-item"
                        href="<?php echo e(url('admin/vendor_discount/'.$vendor->id)); ?>"><?php echo e(__('Discount')); ?></a>
                    <?php endif; ?>
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_financeDetails')): ?>
                    <a class="dropdown-item"
                        href="<?php echo e(url('admin/finance_details/'.$vendor->id)); ?>"><?php echo e(__('finance details')); ?></a>
                    <?php endif; ?>
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_deliveryTimeslots')): ?>
                    <a class="dropdown-item"
                        href="<?php echo e(url('admin/edit_delivery_time/'.$vendor->id)); ?>"><?php echo e(__('Edit delivery time')); ?></a>
                    <?php endif; ?>
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_pickupTimeslots')): ?>
                    <a class="dropdown-item"
                        href="<?php echo e(url('admin/edit_pick_up_time/'.$vendor->id)); ?>"><?php echo e(__('pick up time')); ?></a>
                    <?php endif; ?>
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_sellingTimeslots')): ?>
                    <a class="dropdown-item" href="<?php echo e(url('admin/edit_selling_timeslot/'.$vendor->id)); ?>"><?php echo e(__('selling timeslots')); ?></a>
                    <?php endif; ?>
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_reviews')): ?>
                    <a class="dropdown-item" href="<?php echo e(url('admin/rattings/'.$vendor->id)); ?>"><?php echo e(__('review and rattings')); ?></a>
                    <?php endif; ?>
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_bankDetails')): ?>
                    <a class="dropdown-item"
                        href="<?php echo e(url('admin/vendor_bank_details/'.$vendor->id)); ?>"><?php echo e(__('add bank details')); ?></a>
                    <?php endif; ?>
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_vendor_password')): ?>
                    <a class="dropdown-item"
                        href="<?php echo e(url('admin/vendor_change_password/'.$vendor->id)); ?>"><?php echo e(__('change password')); ?></a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Vendor Management System')); ?></h2>

        <p class="section-lead"><?php echo e(__('Information about vendor')); ?></p>
        <div class="row mt-sm-4">
            <div class="col-12 col-md-12 col-lg-12">
                <div class="card profile-widget">
                    <div class="profile-widget-header">
                        <img alt="image" src="<?php echo e($vendor->image); ?>" class="rounded-circle profile-widget-picture" width="200px" height="100px">
                        <div class="profile-widget-items">
                            <div class="profile-widget-item">
                                <div class="profile-widget-item-label"><?php echo e(__('total order')); ?></div>
                                <div class="profile-widget-item-value"><?php echo e(App\Models\Order::where('vendor_id',$vendor->id)->count()); ?></div>
                            </div>
                            <div class="profile-widget-item">
                                <div class="profile-widget-item-label"><?php echo e(__('Pending orders')); ?></div>
                                <div class="profile-widget-item-value"><?php echo e(App\Models\Order::where([['vendor_id',$vendor->id],['order_status','PENDING']])->count()); ?></div>
                            </div>
                            <div class="profile-widget-item">
                                <div class="profile-widget-item-label"><?php echo e(__('Total review')); ?></div>
                                <div class="profile-widget-item-value"><?php echo e($vendor->review); ?></div>
                            </div>
                        </div>
                    </div>
                    <div class="profile-widget-description">
                        <div class="profile-widget-name"> <?php echo e($vendor->email_id); ?> <div
                                class="text-muted d-inline font-weight-normal">
                            </div>
                        </div>
                        <?php echo e($vendor->map_address); ?>

                    </div>
                </div>
            </div>
        </div>
        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_menu_access')): ?>
            <div class="card">
                <div class="card-header">
                    <div class="w-100 text-right">
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_menu_add')): ?>
                        <button type="button" class="btn btn-primary rounded" data-toggle="modal"
                            data-target="#insert_modal"><?php echo e(__('Add menu')); ?>

                        </button>
                        <?php endif; ?>
                    </div>
                </div>
                <div class="card-body">
                    <table id="datatable" class="table table-striped table-bordered text-center" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>
                                    <input name="select_all" value="1" id="master" type="checkbox" />
                                    <label for="master"></label>
                                </th>
                                <th>#</th>
                                <th><?php echo e(__('Menu Image')); ?></th>
                                <th><?php echo e(__('Menu name')); ?></th>
                                <th><?php echo e(__('Enable')); ?></th>
                                <th><?php echo e(__('Action')); ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $__currentLoopData = $vendor->menu; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $menu): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                            <tr>
                                <td>
                                    <input name="id[]" value="<?php echo e($menu->id); ?>" id="<?php echo e($menu->id); ?>" data-id="<?php echo e($menu->id); ?>" class="sub_chk" type="checkbox" />
                                    <label for="<?php echo e($menu->id); ?>"></label>
                                </td>
                                <td><?php echo e($loop->iteration); ?></td>
                                <td><img src="<?php echo e($menu->image); ?>" class="rounded" width="50" height="50"
                                        alt=""></td>
                                <td><?php echo e($menu->name); ?></td>
                                <td>
                                    <label class="switch">
                                        <input type="checkbox" name="status" onclick="change_status('admin/menu',<?php echo e($menu->id); ?>)"
                                            <?php echo e(($menu->status == 1) ? 'checked' : ''); ?>>
                                        <div class="slider"></div>
                                    </label>
                                </td>
                                <td class="d-flex justify-content-center">
                                    <button type="button" onclick="update_menu(<?php echo e($menu->id); ?>)" class="btn btn-primary mr-2"
                                        data-toggle="modal" data-target="#edit_modal"><i class="fas fa-pencil-alt"></i>
                                    </button>

                                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_submenu_access')): ?>
                                    <a href="<?php echo e(url('admin/menu/'.$menu->id)); ?>" class="btn btn-primary btn-action mr-2"
                                        data-toggle="tooltip" title="" data-original-title="<?php echo e(__('show menu')); ?>"><i class="fas fa-eye"></i>
                                    </a>
                                    <?php endif; ?>
                                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('admin_menu_delete')): ?>
                                        <a href="javascript:void(0);" class="table-action btn btn-danger btn-action" onclick="deleteData('admin/menu',<?php echo e($menu->id); ?>,'Menu')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    <?php endif; ?>
                                </td>
                            </tr>
                            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                        </tbody>
                    </table>
                </div>
                <div class="card-footer">
                    <input type="button" value="Delete selected" onclick="deleteAll('menu_multi_delete','Menu')" class="btn btn-primary">
                </div>
            </div>
        <?php endif; ?>
    </div>
</section>

<div class="modal right fade" id="insert_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form class="container-fuild" action="<?php echo e(url('admin/menu')); ?>" method="post" enctype="multipart/form-data">
                <?php echo csrf_field(); ?>
                <input type="hidden" name="old_value" value="add_menu">
                <input type="hidden" name="vendor_id" value="<?php echo e($vendor->id); ?>">
                <div class="modal-header">
                    <h3 class="text-primary"><?php echo e(__('Add menu')); ?></h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" name="image" accept=".png, .jpg, .jpeg, .svg" id="customFileLang" lang="en">
                            <label class="custom-file-label" for="customFileLang"><?php echo e(__('Select file')); ?></label>
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

                    <div class="form-group">
                        <label class="form-control-label"><?php echo e(__('menu name')); ?><span class="text-danger">&nbsp;*</span></label>
                        <input class="form-control <?php $__errorArgs = ['name'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" name="name" type="text"
                            placeholder="<?php echo e(__('Menu Name')); ?>" required value="<?php echo e(old('name')); ?>" >

                        <?php $__errorArgs = ['name'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                        <span class="invalid-feedback" role="alert">
                            <strong><?php echo e($message); ?></strong>
                        </span>
                        <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                    </div>

                    <div class="form-group">
                        <label for="<?php echo e(__('status')); ?>"><?php echo e(__('Status')); ?></label><br>
                        <label class="switch">
                            <input type="checkbox" name="status">
                            <div class="slider"></div>
                        </label>
                    </div>
                    <hr class="my-3">

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
                        <input type="submit" value="<?php echo e(__('Save')); ?>" class="btn btn-primary">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal right fade" id="edit_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form class="container-fuild" id="update_menu_form" method="post" enctype="multipart/form-data">
                <?php echo csrf_field(); ?>
                <?php echo method_field('PUT'); ?>
                <input type="hidden" name="old_value" value="update_menu">
                <input type="hidden" name="vendor_id" value="<?php echo e($vendor->id); ?>">
                <div class="modal-header">
                    <h3><?php echo e(__('Update menu')); ?></h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <img src="" id="update_image" width="200" height="200" class="rounded-lg p-2" />
                    </div>
                    <div class="form-group mt-3">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" name="image" accept=".png, .jpg, .jpeg, .svg"
                                id="customFileLang1" lang="en">
                            <label class="custom-file-label" for="customFileLang1"><?php echo e(__('Select file')); ?></label>
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

                    <div class="form-group">
                        <label class="form-control-label"><?php echo e(__('menu name')); ?><span class="text-danger">&nbsp;*</span></label>
                        <input class="form-control <?php $__errorArgs = ['name'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" name="name" type="text"
                            placeholder="<?php echo e(__('menu name')); ?>" id="update_menu" required value="<?php echo e(old('name')); ?>">

                        <?php $__errorArgs = ['name'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                        <span class="invalid-feedback" role="alert">
                            <strong><?php echo e($message); ?></strong>
                        </span>
                        <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
                        <input type="submit" value="<?php echo e(__('Update')); ?>" class="btn btn-primary">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'vendor'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/vendor/show_vendor.blade.php ENDPATH**/ ?>