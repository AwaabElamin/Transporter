<?php $__env->startSection('title','Create Order'); ?>

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
        });
    </script>
    <?php endif; ?>
    <div class="section-header">
        <h1><?php echo e(__('Create new order')); ?></h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="<?php echo e(url('admin/home')); ?>"><?php echo e(__('Dashboard')); ?></a></div>
            <div class="breadcrumb-item"><a href="<?php echo e(url('admin/vendor')); ?>"><?php echo e(__('vendor')); ?></a></div>
             <div class="breadcrumb-item"><a href="<?php echo e(url('admin/vendor/'.$id)); ?>"><?php echo e($vendor->name); ?></a></div>
            <div class="breadcrumb-item"><?php echo e(__('create a order')); ?></div>
        </div>
    </div>
    <input type="hidden" name="submenu_id" value="">
    <input type="hidden" name="hidden_amount" value="0">
    <input type="hidden" name="hidden_all_tax" value="0">
    <input type="hidden" name="hidden_promocode_price" value="0">
    <input type="hidden" name="hidden_promocode_id" value="0">
    <div class="section-body">
        <h2 class="section-title"><?php echo e(__('Create order')); ?></h2>
        <p class="section-lead"><?php echo e(__('Create Order')); ?></p>
        <div class="row">
            <div class="col-12 col-sm-12 col-lg-12">
                <div class="card menuCard">
                    <div class="row">
                        <div class="col-md-12 heroSlider-fixed">
                            <div class="overlay">
                            </div>
                            <div class="Orderslider responsive">
                                <?php
                                    $submenus = array();
                                ?>
                                <?php $__currentLoopData = $menus; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $menu): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <?php if($loop->iteration == 1): ?>
                                        <?php
                                            $submenus = App\Models\Submenu::where('menu_id',$menu->id)->get();
                                            $tax = App\Models\GeneralSetting::first()->isItemTax;
                                            foreach ($submenus as $submenu)
                                            {
                                                if ($tax == 0)
                                                {
                                                    $price_tax = App\Models\GeneralSetting::first()->item_tax;
                                                    $disc = $submenu->price * $price_tax;
                                                    $discount = $disc / 100;
                                                    $submenu->price = strval($submenu->price + $discount);
                                                }
                                                else
                                                {
                                                    $submenu->price = strval($submenu->price);
                                                }
                                            }
                                        ?>
                                    <?php endif; ?>
                                    <div class="<?php echo e($loop->iteration == 1 ? 'menuActive' : ''); ?> Menu<?php echo e($menu->id); ?>" >
                                        <h6 onclick="change_submenu(<?php echo e($menu->id); ?>)"><?php echo e($menu->name); ?></h6>
                                    </div>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                            </div>
                            <div class="slider-prev">
                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            </div>
                            <div class="slider-next">
                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-content" id="myTabContent2">
                    <div class="tab-pane fade active show" id="menu110" role="tabpanel" aria-labelledby="home-tab3">
                        <br>
                        <div class="row">
                            <div class="col-sm-12 col-md-8 col-lg-8">
                                <div class="row orderMainRow">
                                    <?php if(count($submenus) > 0): ?>
                                        <?php $__currentLoopData = $submenus; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $submenu): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                            <div class="col-sm-12 col-md-12 col-lg-8 col-xl-6 orderMainCol">
                                                <div class="orderCard">
                                                    <div class="orderCardBody">
                                                        <div class="row">
                                                            <div class="col-sm-12 col-md-6 col-lg-6 col-xl-4 orderCol">
                                                                <img src="<?php echo e($submenu->image); ?>" width="100%" height="113" class="orderImage" alt="">
                                                        </div>
                                                            <div class="col-sm-12 col-md-6 col-lg-6 col-xl-8 orderColRight">
                                                                <div class="orderContent">
                                                                    <?php if($submenu->type == 'veg'): ?>
                                                                        <img src="<?php echo e(url('images/veg.png')); ?>" class="orderIcon" alt="">
                                                                    <?php else: ?>
                                                                        <img src="<?php echo e(url('images/used items.png')); ?>" class="orderIcon" alt="">
                                                                    <?php endif; ?>
                                                                    <h5><?php echo e($submenu->name); ?></h5>
                                                                </div>
                                                                <span class="text-muted orderDesc" id="orderContent<?php echo e($submenu->id); ?>"><?php echo e($submenu->description); ?></span>
                                                                <br>
                                                                <a onclick="DispCustimization(<?php echo e($submenu->id); ?>)" class="cursor-pointer hide text-primary custimization<?php echo e($submenu->id); ?>"><?php echo e(__('Custimization')); ?></a>
                                                                <?php if(Session::get('cart') != null): ?>
                                                                    <?php $__currentLoopData = Session::get('cart'); $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $cart): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                                        <?php if($cart['id'] == $submenu->id): ?>
                                                                            <a onclick="DispCustimization(<?php echo e($submenu->id); ?>)" class="cursor-pointer text-primary"><?php echo e(__('Custimization')); ?></a>
                                                                        <?php endif; ?>
                                                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                                <?php endif; ?>
                                                                <div class="orderPriceQty" id="orderQty<?php echo e($submenu->id); ?>">
                                                                    <div class="orderAmount">
                                                                        <?php echo e($currency); ?><?php echo e($submenu->price); ?>

                                                                    </div>
                                                                    <?php if(Session::get('cart') != null): ?>
                                                                        <?php $__currentLoopData = Session::get('cart'); $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $cart): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                                            <?php if($cart['id'] == $submenu->id): ?>
                                                                                <span class="orderQty"><?php echo e($cart['qty']); ?></span>
                                                                            <?php endif; ?>
                                                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                                    <?php endif; ?>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <div class="col-sm-12 col-md-4 col-lg-4">
                                <div class="row">
                                    <div class="col-sm-12 col-md-12 col-lg-12">
                                        <div class="alert alert-primary alert-dismissible fade show hide show_alert" role="alert">
                                            <strong class="display"></strong>
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="card SubmenuCard display_menu">
                                            <div class="table-responsive p-3 qtyTable">
                                                <table class="table">
                                                    <tbody>
                                                        <?php $__currentLoopData = $sub_menus; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $sub_menu): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                            <input type="hidden" id="original_price<?php echo e($sub_menu->id); ?>" value="<?php echo e($sub_menu->price); ?>">
                                                            <tr>
                                                                <th>
                                                                    <span><?php echo e($sub_menu->name); ?></span>
                                                                    <br>
                                                                    <span class="text-muted"><?php echo e($currency); ?><?php echo e($sub_menu->price); ?></span>
                                                                </th>
                                                                <?php if(Session::get('cart') == null): ?>
                                                                    <td class="priceTd"><?php echo e($currency); ?>

                                                                        <span class="itemPrice<?php echo e($sub_menu->id); ?>">00</span>
                                                                    </td>
                                                                    <td class="d-flex pt-3">
                                                                        <p class="orderMinusButton" id="minus<?php echo e($sub_menu->id); ?>"><i class="fas fa-minus" onclick="cart(<?php echo e($sub_menu->id); ?>,'minus')"></i></p>
                                                                        <p class="orderQtyDisplay qty<?php echo e($sub_menu->id); ?>">0</p>
                                                                        <p class="orderPlusButton"><i class="fas fa-plus" onclick="cart(<?php echo e($sub_menu->id); ?>,'plus')"></i></p>
                                                                    </td>
                                                                <?php else: ?>
                                                                    <?php if(in_array($sub_menu->id, array_column(Session::get('cart'), 'id'))): ?>
                                                                        <?php $__currentLoopData = Session::get('cart'); $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $cart): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                                            <?php if($cart['id'] == $sub_menu->id): ?>
                                                                                <td class="priceTd"><?php echo e($currency); ?>

                                                                                    <span class="itemPrice<?php echo e($sub_menu->id); ?>"><?php echo e($cart['price']); ?></span>
                                                                                </td>
                                                                                <td class="d-flex pt-3">
                                                                                    <p class="orderMinusButton"><i class="fas fa-minus" onclick="cart(<?php echo e($sub_menu->id); ?>,'minus')"></i></p>
                                                                                    <p class="orderQtyDisplay qty<?php echo e($sub_menu->id); ?>"><?php echo e($cart['qty']); ?></p>
                                                                                    <p class="orderPlusButton"><i class="fas fa-plus" onclick="cart(<?php echo e($sub_menu->id); ?>,'plus')"></i></p>
                                                                                </td>
                                                                            <?php endif; ?>
                                                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                                    <?php else: ?>
                                                                        <td class="priceTd"><?php echo e($currency); ?>

                                                                            <span class="itemPrice<?php echo e($sub_menu->id); ?>">00</span>
                                                                        </td>
                                                                        <td class="d-flex pt-3">
                                                                            <p class="orderMinusButton"><i class="fas fa-minus" onclick="cart(<?php echo e($sub_menu->id); ?>,'minus')"></i></p>
                                                                            <p class="orderQtyDisplay qty<?php echo e($sub_menu->id); ?>">0</p>
                                                                            <p class="orderPlusButton"><i class="fas fa-plus" onclick="cart(<?php echo e($sub_menu->id); ?>,'plus')"></i></p>
                                                                        </td>
                                                                    <?php endif; ?>
                                                                <?php endif; ?>
                                                            </tr>
                                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="cardFooter d-flex">
                                                <div class="totalItemDiv">
                                                    <p class="totalItem"><?php echo e(__('Total Items')); ?>: <span class="displayTotalItem"><?php echo e($total_item); ?></span>
                                                    <br><?php echo e(__('Amount')); ?>: <?php echo e($currency); ?><span class="totalPrice"><?php echo e($grand_total); ?></span>
                                                    </p>
                                                </div>
                                                <div class="PlaceOrder">
                                                    <input type="button" class="placeOrderButton" onclick="Custimization()" value="<?php echo e(__('Place Order')); ?>">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card SubmenuCard hide repeat_order">
                                            <div class="table-responsive p-3 qtyTable">
                                                <div class="row custimization">
                                                    <div class="col-md-12 pb-3 text-center">
                                                        <button class="add_order" onclick="repeat_order()"><?php echo e(__('Repeat Order')); ?></button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="cardFooter d-flex">
                                                <div class="totalItemDiv">
                                                    <p class="totalItem"><?php echo e(__('Total Items')); ?>: <span class="displayTotalItem"><?php echo e($total_item); ?></span>
                                                        <br><?php echo e(__('Amount')); ?>:<?php echo e($currency); ?><span class="totalPrice"><?php echo e($grand_total); ?></p>
                                                </div>
                                                <div class="PlaceOrder">
                                                    <input type="button" class="placeOrderButton" onclick="showUser()" value="<?php echo e(__('Place Order')); ?>">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card SubmenuCard hide session_menu">
                                            <div class="table-responsive p-3 qtyTable">
                                                <table class="table">
                                                    <tbody>
                                                        <?php $__currentLoopData = $sub_menus; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $sub_menu): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                            <input type="hidden" id="original_price<?php echo e($sub_menu->id); ?>" value="<?php echo e($sub_menu->price); ?>">
                                                            <tr>
                                                                <th>
                                                                    <span><?php echo e($sub_menu->name); ?></span>
                                                                    <br>
                                                                    <span class="text-muted"><?php echo e($currency); ?><?php echo e($sub_menu->price); ?></span>
                                                                </th>
                                                                <?php if(Session::get('cart') == null): ?>
                                                                    <td class="priceTd"><?php echo e($currency); ?>

                                                                        <span class="itemPrice<?php echo e($sub_menu->id); ?>">00</span>
                                                                    </td>
                                                                    <td class="d-flex pt-3">
                                                                        <p class="orderMinusButton" id="minus<?php echo e($sub_menu->id); ?>"><i class="fas fa-minus" onclick="cart(<?php echo e($sub_menu->id); ?>,'minus')"></i></p>
                                                                        <p class="orderQtyDisplay qty<?php echo e($sub_menu->id); ?>">0</p>
                                                                        <p class="orderPlusButton"><i class="fas fa-plus" onclick="cart(<?php echo e($sub_menu->id); ?>,'plus')"></i></p>
                                                                    </td>
                                                                <?php else: ?>
                                                                    <?php if(in_array($sub_menu->id, array_column(Session::get('cart'), 'id'))): ?>
                                                                    <?php $__currentLoopData = Session::get('cart'); $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $cart): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                                            <?php if($cart['id'] == $sub_menu->id): ?>
                                                                                <td class="priceTd"><?php echo e($currency); ?>

                                                                                    <span class="itemPrice<?php echo e($sub_menu->id); ?>"><?php echo e($cart['price']); ?></span>
                                                                                </td>
                                                                                <td class="d-flex pt-3">
                                                                                    <p class="orderMinusButton"><i class="fas fa-minus" onclick="cart(<?php echo e($sub_menu->id); ?>,'minus')"></i></p>
                                                                                    <p class="orderQtyDisplay qty<?php echo e($sub_menu->id); ?>"><?php echo e($cart['qty']); ?></p>
                                                                                    <p class="orderPlusButton"><i class="fas fa-plus" onclick="cart(<?php echo e($sub_menu->id); ?>,'plus')"></i></p>
                                                                                </td>
                                                                            <?php endif; ?>
                                                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                                    <?php else: ?>
                                                                        <td class="priceTd"><?php echo e($currency); ?>

                                                                            <span class="itemPrice<?php echo e($sub_menu->id); ?>">00</span>
                                                                        </td>
                                                                        <td class="d-flex pt-3">
                                                                            <p class="orderMinusButton"><i class="fas fa-minus" onclick="cart(<?php echo e($sub_menu->id); ?>,'minus')"></i></p>
                                                                            <p class="orderQtyDisplay qty<?php echo e($sub_menu->id); ?>">0</p>
                                                                            <p class="orderPlusButton"><i class="fas fa-plus" onclick="cart(<?php echo e($sub_menu->id); ?>,'plus')"></i></p>
                                                                        </td>
                                                                    <?php endif; ?>
                                                                <?php endif; ?>
                                                            </tr>
                                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="cardFooter d-flex">
                                                <div class="totalItemDiv">
                                                    <p class="totalItem"><?php echo e(__('Total Items')); ?>: <span class="displayTotalItem"><?php echo e($total_item); ?></span>
                                                    <br><?php echo e(__('Amount')); ?>: <?php echo e($currency); ?><span class="totalPrice"><?php echo e($grand_total); ?></span>
                                                    </p>
                                                </div>
                                                <div class="PlaceOrder">
                                                    <input type="button" class="placeOrderButton" onclick="showUser()" value="<?php echo e(__('Place Order')); ?>">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card SubmenuCard hide show_user">
                                            <div class="card-header">
                                                <input type="text" class="searchTextBox" placeholder="<?php echo e(__('search user')); ?>" id="search" onkeyup="data_search()">
                                                <a class="AddUserText" onclick="user()"><?php echo e(__('+ Add New User')); ?></a>
                                            </div>
                                            <div class="table-responsive qtyTable show_userCard">
                                                <ul class="list-unstyled displayUser user-details list-unstyled-border list-unstyled-noborder" id="sort_location">
                                                    <?php $__currentLoopData = $users; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $user): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                        <li class="media p-3 single_record">
                                                            <img alt="image" class="mr-3 rounded-circle" width="50" src="<?php echo e($user->image); ?>">
                                                            <div class="media-body">
                                                                <div class="media-title"><?php echo e($user->name); ?></div>
                                                                <div class="text-job text-muted">
                                                                    <?php echo e($user->email_id); ?><br>
                                                                    <?php echo e($user->phone); ?>

                                                                </div>
                                                            </div>
                                                            <div class="media-item">
                                                                <div class="media-value">
                                                                    <input type="radio" value="<?php echo e($user->id); ?>" id="chkbox<?php echo e($loop->iteration); ?>" name="user">
                                                                </div>
                                                            </div>
                                                        </li>
                                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                </ul>
                                            </div>
                                            <div class="cardFooter d-flex">
                                                <div class="totalItemDiv">
                                                    <p class="totalItem"><?php echo e(__('Total Items')); ?>:
                                                        <span class="displayTotalItem"><?php echo e($total_item); ?></span>
                                                        <br>
                                                        <?php echo e(__('Amount :')); ?><?php echo e($currency); ?>

                                                        <span class="totalPrice">
                                                            <?php echo e($grand_total); ?>

                                                        </span>
                                                    </p>
                                                </div>
                                                <div class="PlaceOrder">
                                                    <input type="button" class="placeOrderButton" onclick="displayBill()" value="<?php echo e(__('Place Order')); ?>">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card SubmenuCard hide add_user">
                                            <div class="card-header"><i class="fas fa-chevron-left mr-3 cursor-pointer" onclick="showUser()"></i>
                                                <h4><?php echo e(__('Add New User')); ?></h4>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive qtyTable">
                                                    <form action="<?php echo e(url('branch_manager/add_user')); ?> ">
                                                        <?php echo csrf_field(); ?>
                                                        <div class="row">
                                                            <div class="col-md-12 mb-3">
                                                                <label for="username">User Name</label>
                                                                <input type="text" name="name" placeholder="User Name" id="user_name" required="required" class="form-control" style="text-transform: none;">
                                                                <div class="custom_error">
                                                                    <span class="name"></span>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 mb-3">
                                                                <label for="contact">Email Address</label>
                                                                <input type="email" name="email_id" placeholder="Email Address" id="email" required="required" class="form-control" style="text-transform: none;">
                                                                <div class="custom_error">
                                                                    <span class="email_id"></span>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 mb-3">
                                                                <label for="contact">Phone</label>
                                                                <input type="number" name="phone" placeholder="Phone" id="phone" required="required" class="form-control" style="text-transform: none;">
                                                                <div class="custom_error">
                                                                    <span class="phone"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                            <div class="cardFooter">
                                                <input type="button" value="Add User" class="UserBtn" onclick="UserBtn()">
                                            </div>
                                        </div>

                                        <div class="card SubmenuCard hide total_bill">
                                            <div class="table-responsive p-3 qtyTable">
                                                <table class="table">
                                                    <tbody>
                                                        <tr class="Border" id="taxCharge">
                                                            <td class="leftTd"><?php echo e(__('Total amount')); ?></td>
                                                            <td class="rightTd"><?php echo e($currency); ?>

                                                                <span class="dispBillTotalAmount">00</span>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr class="Border">
                                                            <td class="leftTd"><?php echo e(__('Final total')); ?></td>
                                                            <td class="rightTd">
                                                                <?php echo e($currency); ?>

                                                                <span class="dispBillFinalTotal">00</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" class="NoPaddingMargin">
                                                                <div class="coupenTextbox"><?php echo e(__('you have a coupen to use')); ?>

                                                                <a onclick="applyCoupen()"><?php echo e(__('Apply It')); ?></a></div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="cardFooter d-flex">
                                                <div class="totalItemDiv">
                                                    <p class="totalItem"><?php echo e(('Total Items')); ?>:
                                                        <span class="displayTotalItem"><?php echo e($total_item); ?></span>
                                                        <br>
                                                        <?php echo e(('Amount :')); ?><?php echo e($currency); ?>

                                                        <span class="totalPrice">
                                                            <?php echo e($grand_total); ?>

                                                        </span>
                                                    </p>
                                                </div>
                                                <div class="PlaceOrder">
                                                    <input type="button" class="placeOrderButton" onclick="confirm_order()" value="<?php echo e(__('Place Order')); ?>">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card SubmenuCard hide display_coupen">
                                            <div class="table-responsive p-3 qtyTable">
                                                <table class="table DisplayCoupen">
                                                    <?php $__currentLoopData = $promoCodes; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $promoCode): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                                        <tr class="Border p-4">
                                                            <td class="leftTd">
                                                                <p class="couponCode"><?php echo e($promoCode->promo_code); ?></p>
                                                                <p class="couponDiscri"><?php echo e($promoCode->description); ?></p>
                                                                <p class="couponExpire"><?php echo e(__('valid up to ')); ?><?php echo e(explode(' - ',$promoCode->start_end_date)[1]); ?></p>
                                                            </td>
                                                            <td class="rightTd"><a class="applyBtn" onclick="displayBillWithCoupen(<?php echo e($promoCode->id); ?>)"><?php echo e(__('APPLY')); ?></a></td>
                                                        </tr>
                                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="card SubmenuCard hide display_bill_with_coupen">
                                            <div class="table-responsive p-3 qtyTable">
                                                <table class="table">
                                                    <tbody>
                                                        <tr class="Border" id="taxChargeWithCoupen">
                                                            <td class="leftTd"><?php echo e(__('Total amount')); ?></td>
                                                            <td class="rightTd"><?php echo e($currency); ?>

                                                                <span class="CoupenTotalAmount">00</span>
                                                            </td>
                                                        
                                                        <tr class="Border">
                                                            <td class="leftTd"><?php echo e(__('Final total')); ?></td>
                                                            <td class="rightTd">
                                                                <?php echo e($currency); ?>

                                                                <span class="CoupenFinalTotal">00</span>
                                                            </td>
                                                        </tr>
                                                        <tr class="Border">
                                                            <td class="leftTd"><?php echo e(__('Applied Coupen')); ?><br>
                                                                <span class="coupenTotalDisplay">KHKDJH(30%)</span>
                                                                <span class="remove_coupen" onclick="displayBill()"><?php echo e(__('Remove Coupen')); ?></span></td>
                                                            <td class="rightTd text-danger">-<?php echo e($currency); ?>

                                                                <span class="CoupenDiscount">00</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="leftTd"><?php echo e(__('Grand Total')); ?></td>
                                                            <td class="rightTd"><?php echo e($currency); ?>

                                                                <span class="CoupenGrandTotal">00</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" class="NoPaddingMargin"></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="cardFooter d-flex">
                                                <div class="totalItemDiv">
                                                    <p class="totalItem"><?php echo e(__('Total Items')); ?>: <span class="displayTotalItem"><?php echo e($total_item); ?></span>
                                                    <br><?php echo e(__('Amount')); ?>: <?php echo e($currency); ?><span class="totalPrice"><?php echo e($grand_total); ?></span>
                                                    </p>
                                                </div>
                                                <div class="PlaceOrder">
                                                    <input type="button" class="placeOrderButton" onclick="confirm_order()" value="<?php echo e(__('Place Order')); ?>">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card SubmenuCard hide display_custimization">
                                            <div class="table-responsive p-3 qtyTable displayCustimization">

                                            </div>
                                            <div class="cardFooter d-flex">
                                                <div class="totalItemDiv">
                                                    <p class="totalItem"><?php echo e(__('Total Items')); ?>: <span class="displayTotalItem"><?php echo e($total_item); ?></span>
                                                    <br><?php echo e(__('Amount')); ?>: <?php echo e($currency); ?><span class="totalPrice"><?php echo e($grand_total); ?></span>
                                                    </p>
                                                </div>
                                                <div class="PlaceOrder">
                                                    <input type="button" class="placeOrderButton" onclick="showUser()" value="<?php echo e(__('Place Order')); ?>">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>

<div class="modal" id="staticBackdrop" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <form class="form_user_address" method="post">
                <?php echo csrf_field(); ?>
                <div class="modal-header">
                    <h5 class="modal-title text-primary" id="staticBackdropLabel"><?php echo e(__('Address')); ?></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <label for="user"><?php echo e(__('User Address')); ?></label>
                            <textarea name="address" class="form-control address" required></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <label for="address"><?php echo e(__('Address')); ?></label>
                            <div id="address_map" style="position: fixed;"></div>
                            <input type="hidden" name="lat" value="15.500654" id="lat">
                            <input type="hidden" name="lang" value="32.559898" id="lang">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
                    <button type="button" onclick="addAddress()" class="btn btn-primary"><?php echo e(__('Save')); ?></button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade right" id="view_custimization" data-keyboard="false" tabindex="-1"
    aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <form action="<?php echo e(url('admin/order/update_custimization')); ?>" method="post">
        <?php echo csrf_field(); ?>
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-primary" id="staticBackdropLabel"><?php echo e(__('Custimization')); ?></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body custimization_name">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
                    <button type="button" onclick="update_cust()" class="btn btn-primary"><?php echo e(__('Save')); ?></button>
                </div>
            </div>
        </div>
    </form>
</div>

<div class="modal" id="view_total" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-primary item_name" id="staticBackdropLabel"><?php echo e(__('Item List')); ?></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tr>
                        <td><?php echo e(__('item quantity')); ?></td>
                        <td class="item_quantity"></td>
                    </tr>

                    <tr>
                        <td><?php echo e(__('item price')); ?></td>
                        <td class="item_price"></td>
                    </tr>

                    <tr>
                        <td><?php echo e(__('item custimization')); ?></td>
                        <td class="item_custimization"></td>
                    </tr>
                    <tr>
                        <td class="font-weight-bold"><?php echo e(__('total bill')); ?></td>
                        <td class="font-weight-bold total_bill"></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="user" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="alert alert-dark alert-dismissible fade show hide show_alert" role="alert">
                <strong class="display"></strong>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form class="form_user" method="post">
                <?php echo csrf_field(); ?>
                <div class="modal-header">
                    <h5 class="modal-title text-primary" id="staticBackdropLabel"><?php echo e(__('User Add')); ?></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="user"><?php echo e(__('User')); ?></label>
                            <input type="text" name="name" id="name" class="form-control" style="text-transform: none" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="address"><?php echo e(__('Email')); ?></label>
                            <input type="email" id="email_id" class="form-control" style="text-transform: none" name="email_id" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="address"><?php echo e(__('Password')); ?></label>
                            <input type="password" id="password" class="form-control" name="password" style="text-transform: none" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="address"><?php echo e(__('phone')); ?></label>
                            <input type="number" id="phone" class="form-control" style="text-transform: none" name="phone" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"><?php echo e(__('Close')); ?></button>
                    <button type="button" onclick="addUser()" class="btn btn-primary"><?php echo e(__('Save')); ?></button>
                </div>
            </form>
        </div>
    </div>
</div>

<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.app',['activePage' => 'vendor'], \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/mobark/dev.transporter-sudan.com/resources/views/admin/vendor/neworder.blade.php ENDPATH**/ ?>