import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/models/cart_item.dart';
import 'package:alnaqel_seller/models/menu.dart';
import 'package:alnaqel_seller/models/product_response.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:alnaqel_seller/utilities/device_utils.dart';
import 'package:alnaqel_seller/widgets/send_order/pages/select_user.dart';
import 'package:alnaqel_seller/widgets/send_order/to_storage.dart';
import 'package:alnaqel_seller/widgets/send_order/to_user.dart';
import 'package:alnaqel_seller/widgets/send_order/widgets/add_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SelectProductsPage extends StatefulWidget {
  static final String path = "/";
  final GlobalKey<NavigatorState> navigationKey;
  final bool isToStorage;
  const SelectProductsPage(
      {Key? key, required this.isToStorage, required this.navigationKey})
      : super(key: key);

  @override
  State<SelectProductsPage> createState() => _SelectProductsPageState();
}

class _SelectProductsPageState extends State<SelectProductsPage> {
  Future<BaseModel<Menu>>? menuFuture;
  @override
  void initState() {
    super.initState();
    menuFuture = getMenu();
  }

  Future<void> _refreshProduct() async {
    setState(() {
      menuFuture = getMenu();
    });
  }

  Widget _tabBar() {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
                          labelColor: Palette.green,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Palette.green,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                          tabs: 
                              [Tab(text: 'منتجاتي',), Tab(text: 'المخزن',)],
            ),
            Expanded(child: TabBarView(children: [
              myItems(),
              _myStorage()
            ]))
          ],
        ));
  }

  Widget _myStorage(){
   return FutureBuilder<BaseModel<Menu>?>(
            future: menuFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return DeviceUtils.showProgress(true);
              } else {
                Widget emptyView = Center(
                  child: Container(
                      child:
                          Text(getTranslated(context, 'no_data_desc') ?? '')),
                );
                Menu? data = snapshot.data?.data;

                bool isNulled = data?.data == null;
                if (isNulled) {
                  return emptyView;
                } else {
                  return DefaultTabController(
                    length: data?.data?.length ?? 0,
                    child: Column(
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              DeviceUtils.toastMessage(
                                  'هذه الميزة قيد التطوير حالياً');
                            },
                            icon: Icon(Icons.add_alarm_rounded),
                            label: Text('اضافة منتج مؤقت')),
                        TabBar(
                          isScrollable: true,
                          labelColor: Palette.green,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Palette.green,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                          tabs: data?.data?.map((e) {
                                return Tab(
                                  text: e?.name ?? '',
                                );
                              }).toList() ??
                              [],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: data?.data?.map((e) {
                                  return _productList(e!.id);
                                }).toList() ??
                                [],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            });
  }

  Widget myItems(){
    return FutureBuilder<BaseModel<Menu>?>(
            future: menuFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return DeviceUtils.showProgress(true);
              } else {
                Widget emptyView = Center(
                  child: Container(
                      child:
                          Text(getTranslated(context, 'no_data_desc') ?? '')),
                );
                Menu? data = snapshot.data?.data;

                bool isNulled = data?.data == null;
                if (isNulled) {
                  return emptyView;
                } else {
                  return DefaultTabController(
                    length: data?.data?.length ?? 0,
                    child: Column(
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              DeviceUtils.toastMessage(
                                  'هذه الميزة قيد التطوير حالياً');
                            },
                            icon: Icon(Icons.add_alarm_rounded),
                            label: Text('اضافة منتج مؤقت')),
                        TabBar(
                          isScrollable: true,
                          labelColor: Palette.green,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Palette.green,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                          tabs: data?.data?.map((e) {
                                return Tab(
                                  text: e?.name ?? '',
                                );
                              }).toList() ??
                              [],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: data?.data?.map((e) {
                                  return _productList(e!.id);
                                }).toList() ??
                                [],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                getTranslated(context, SelectProductsPage.path) ?? '',
                style: TextStyle(fontFamily: proxima_nova_bold),
              ),
              leading: IconButton(
                  onPressed: () {
                    widget.isToStorage ? exitStorageSheet() : exitUserSheet();
                  },
                  icon: Icon(Icons.close)),
              trailing: Provider.of<OrderingCart>(context, listen: true)
                          .getUserCartItemsCount() >
                      0
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
                      onPressed: () async {
                        if (widget.isToStorage) {
                          var res = await Provider.of<OrderingCart>(context,
                                  listen: false)
                              .sendToStorage();
                          try {
                            DeviceUtils.toastMessage(res.data!.data!);
                            exitStorageSheet();
                          } catch (e) {
                            DeviceUtils.toastMessage(e.toString());
                          }
                        } else {
                          Navigator.of(context).pushNamed(SelectUserPage.path);
                        }
                      },
                    )
                  : null,
            )
          ];
        },
        body: myItems()
      ),
    );
  }

  Widget _productList(int? id) {
    return RefreshIndicator(
      color: Palette.green,
      onRefresh: _refreshProduct,
      child: Container(
        child: FutureBuilder<BaseModel<ProductResponse>>(
          future: getProduct(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                var data = snapshot.data!.data!;
                return data.productData!.length > 0
                    ? ListView.builder(
                        itemCount: data.productData!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 20.w,
                                      margin: EdgeInsets.only(right: 10),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                        child: Image(
                                          image: NetworkImage(
                                              data.productData![index].image!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            data.productData![index].type == 'new'
                                                ? SvgPicture.asset(
                                                    'assets/images/veg.svg')
                                                : SvgPicture.asset(
                                                    'assets/images/nonveg.svg'),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.48,
                                              child: Text(
                                                data.productData![index].name!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Palette.loginhead,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        proxima_nova_bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data.productData![index].description!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Palette.switchs,
                                              fontSize: 12,
                                              fontFamily: proxima_nova_reg),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '\$ ${data.productData![index].price}',
                                          style: TextStyle(
                                              color: Palette.loginhead,
                                              fontSize: 16,
                                              fontFamily: proxima_nova_reg),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: CustomStepper(
                                        id: data.productData![index].id!,
                                        price: double.parse(
                                            data.productData![index].price!),
                                      ),
                                    )
                                  ],
                                ),
                             PackageRadios(id: data.productData![index].id!,
                                )
                              ],
                            ),
                          );
                        })
                    : Center(
                        child: Container(
                            child: Text(
                                getTranslated(context, 'no_data_desc') ?? '')),
                      );
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return DeviceUtils.showProgress(true);
          },
        ),
      ),
    );
  }
}
