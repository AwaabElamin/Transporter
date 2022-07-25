import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/models/cart_item.dart';
import 'package:alnaqel_seller/models/user.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:alnaqel_seller/utilities/device_utils.dart';
import 'package:alnaqel_seller/widgets/send_order/pages/select_address.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../nav_obs.dart';

class SelectUserPage extends StatefulWidget {
  static final String path = "select_users";
  const SelectUserPage({Key? key}) : super(key: key);

  @override
  State<SelectUserPage> createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage> {
  Future<BaseModel<Users>>? UsersFuture;

  @override
  void initState() {
    super.initState();
    UsersFuture = context.read<OrderingCart>().fetchUsers();
  }

  List<Data> users = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                getTranslated(context, SelectUserPage.path) ?? 'hi',
                style: TextStyle(fontFamily: proxima_nova_bold),
              ),
              automaticallyImplyTitle: true,
              previousPageTitle: getTranslated(
                  context, previousRoutesInfoList.last.settings.name ?? ''),
              trailing: Provider.of<OrderingCart>(context, listen: true)
                          .getUser() !=
                      null
                  ? TextButton.icon(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.cyan,
                      ),
                      label: Text(
                        getTranslated(context, 'next')!,
                        style: TextStyle(
                          fontFamily: proxima_nova_bold,
                          color: Colors.cyan,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SelectAddressPage.path);
                      },
                    )
                  : null,
            )
          ];
        },
        body: FutureBuilder<BaseModel<Users>?>(
            future: UsersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return DeviceUtils.showProgress(true);
              } else {
                Widget addBar = Row(
                  children: [
                    //create search box and new user button
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: CupertinoTextField(
                          placeholder:
                              getTranslated(context, 'search_client') ?? '',
                          onChanged: (value) {
                            context.read<OrderingCart>().searchUser(value);
                          },
                        ),
                      ),
                    ),
                    CupertinoButton(
                      child: Text(
                        getTranslated(context, 'add_client') ?? '',
                        style: TextStyle(
                          fontFamily: proxima_nova_bold,
                          color: Colors.cyan,
                        ),
                      ),
                      onPressed: () async {
                        String? name;
                        int? phone;
                        var isadded = await showCupertinoDialog<bool>(
                          context: context,
                          builder: (ctx) {
                            return CupertinoAlertDialog(
                              title: Text(
                                getTranslated(context, 'add_client') ?? '',
                                style: TextStyle(
                                  fontFamily: proxima_nova_bold,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CupertinoTextField(
                                    placeholder: getTranslated(
                                            context, 'enter_client_name') ??
                                        '',
                                    onChanged: (value) {
                                      name = value;
                                    },
                                  ),
                                  CupertinoTextField(
                                    placeholder: getTranslated(
                                            context, 'enter_client_phone') ??
                                        '',
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10,
                                    onChanged: (value) {
                                      phone = int.parse(value);
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                CupertinoButton(
                                  child: Text(
                                    getTranslated(context, 'cancle') ?? '',
                                    style: TextStyle(
                                      fontFamily: proxima_nova_bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    print('calling user cn button ');
                                    Navigator.of(ctx).pop(false);
                                  },
                                ),
                                CupertinoButton(
                                  child: Text(
                                    getTranslated(context, 'create') ?? '',
                                    style: TextStyle(
                                      fontFamily: proxima_nova_bold,
                                    ),
                                  ),
                                  onPressed: () async {
                                    print('calling user button ');
                                    if (name != null && phone != null) {
                                      if (phone! < 9 || name!.length < 6) {
                                        DeviceUtils.toastMessage(
                                            'البيانات غير صحيحة الرجاء كتابة رقم الهاتف بشكل صحيح واسم العميل بشكل صحيح');
                                      } else {
                                        print('calling user api');
                                        var user = await createUser(
                                            name: name!, phone: phone!);
                                        print(
                                            'called user is:${user.data?.data?.name}');
                                        Provider.of<OrderingCart>(context,
                                                listen: false)
                                            .setUser(user.data?.data);
                                        Navigator.of(ctx).pop(true);
                                      }
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        isadded = isadded ?? false;
                        if (isadded) {
                          Navigator.of(context)
                              .pushNamed(SelectAddressPage.path);
                        }
                      },
                    ),
                  ],
                );
                Widget emptyView = Center(
                  child: Container(
                      child:
                          Text(getTranslated(context, 'no_data_desc') ?? '')),
                );
                Users? data = snapshot.data?.data;
                users = data?.data ?? [];
                bool isNulled = data?.data == null;
                if (isNulled) {
                  return Column(
                    children: [
                      addBar,
                      emptyView,
                      IconButton(
                        onPressed: context.read<OrderingCart>().fetchUsers,
                        icon: Icon(Icons.refresh),
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      addBar,
                      Consumer<OrderingCart>(
                        builder: (context, cart, child) => child!,
                        child: Expanded(
                          child: RefreshIndicator(
                            color: Palette.green,
                            onRefresh: context.read<OrderingCart>().fetchUsers,
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  var user = context
                                      .read<OrderingCart>()
                                      .tempData[index];
                                  return ListTile(
                                    title: Text(user.name ?? ''),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              user.image ?? ''),
                                    ),
                                    subtitle: Text(user.phone ?? ''),
                                    onTap: () {
                                      context
                                          .read<OrderingCart>()
                                          .setUser(user);
                                      // Provider.of<OrderingCart>(context,
                                      //         listen: false)
                                      //     .setUser(user);
                                      // setState(() {});
                                    },
                                    trailing: context
                                                .watch<OrderingCart>()
                                                .getUser()
                                                ?.id ==
                                            user.id
                                        ? Icon(
                                            Icons.radio_button_checked,
                                            color: Palette.green,
                                          )
                                        : Icon(
                                            Icons.radio_button_unchecked,
                                            color: Colors.grey,
                                          ),
                                  );
                                },
                                itemCount: context
                                    .watch<OrderingCart>()
                                    .tempData
                                    .length),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            }),
      ),
    );
  }
}
