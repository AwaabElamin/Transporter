<table id="datatable" class="table table-striped table-bordered" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>
                <input name="select_all" value="1" id="master" type="checkbox" />
                <label for="master"></label>
            </th>
            <th>#</th>
            <th><?php echo e(__('Menu Image')); ?></th>
            <th><?php echo e(__('Menu name')); ?></th>
            <th><?php echo e(__('new items/ used items')); ?></th>
            <th><?php echo e(__('Enable')); ?></th>
            <th><?php echo e(__('Action')); ?></th>
        </tr>
    </thead>
    <tbody>
    <?php $__currentLoopData = $menu->submenu; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $submenu): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
            <tr>
                <td>
                    <input name="id[]" value="<?php echo e($submenu->id); ?>" id="<?php echo e($submenu->id); ?>" data-id="<?php echo e($submenu->id); ?>" class="sub_chk" type="checkbox" />
                    <label for="<?php echo e($submenu->id); ?>"></label>
                </td>
                <td><?php echo e($loop->iteration); ?></td>
                <td>
                    <img src="<?php echo e($submenu->image); ?>" class="rounded" width="50" height="50" alt="">
                </td>
                <td><?php echo e($submenu->name); ?></td>
                <td>
                    <?php if($submenu->type == 'veg'): ?>
                        <img src="<?php echo e(url('images/veg.png')); ?>" alt="">
                    <?php elseif($submenu->type == 'non_veg'): ?>
                        <img src="<?php echo e(url('images/used items.png')); ?>" alt="">
                    <?php else: ?>
                        <img src="<?php echo e(url('images/used items.png')); ?>" alt="">&nbsp;<img src="<?php echo e(url('images/veg.png')); ?>" alt="">
                    <?php endif; ?>
                </td>
                <td>
                    <label class="switch">
                        <input type="checkbox" name="status" onclick="change_status('admin/submenu',<?php echo e($submenu->id); ?>)" <?php echo e(($submenu->status == 1) ? 'checked' : ''); ?>>
                        <div class="slider"></div>
                    </label>
                </td>
                <td class="d-flex justify-content-center">
                    <?php if(Auth::user()->load('roles')->roles->contains('title', 'vendor')): ?>
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('vendor_custimization_access')): ?>
                            <a href="<?php echo e(url('vendor/custimization_type/'.$submenu->id)); ?>" class="btn btn-primary mr-1"><?php echo e(__('Add cutomization')); ?></a>
                        <?php endif; ?>
                    <?php endif; ?>
                    <?php if(Str::contains(strtolower(Auth::user()->load('roles')->roles[0]->title) ,'admin')): ?>
                        <a href="<?php echo e(url('admin/customization_type/'.$submenu->id)); ?>" class="btn btn-primary mr-1"><?php echo e(__('Add cutomization')); ?></a>
                    <?php endif; ?>
                    <button type="button" onclick="update_submenu(<?php echo e($submenu->id); ?>)" class="btn btn-primary mr-1" data-toggle="modal" data-target="#edit_modal"><i class="fas fa-pencil-alt"></i>
                    </button>
                    <a href="javascript:void(0);" class="table-action ml-2 btn btn-danger btn-action" onclick="deleteData('admin/submenu',<?php echo e($submenu->id); ?>,'Submenu')">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
        </tbody>
</table>
<?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/vendor/submenu/display_submenu.blade.php ENDPATH**/ ?>