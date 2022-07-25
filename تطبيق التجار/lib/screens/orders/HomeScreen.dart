import 'dart:collection';

import 'package:alnaqel_seller/widgets/send_order/to_storage.dart';
import 'package:alnaqel_seller/widgets/send_order/to_user.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/models/common_response.dart';
import 'package:alnaqel_seller/models/orders_response.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:alnaqel_seller/screens/orders/OrderDetailScreen.dart';
import 'package:alnaqel_seller/utilities/device_utils.dart';
import 'package:alnaqel_seller/utilities/prefConstatnt.dart';
import 'package:alnaqel_seller/utilities/preference.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<BaseModel<OrdersResponse>>? getOrderFuture;
List<Data> orderList = [];
List<Data> _searchResult = [];
TextEditingController searchController = new TextEditingController();

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? controllerTab;
  int selectedIndex = 0;
  var isDialOpen = ValueNotifier<bool>(false);
  List<Tab> myTabs = [];

  List<Data> orderList = [];
  List<Data> orderListPast = [];

  List<Data> storageList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      getOrderFuture = getOrders();
    });
  }

  @override
  void didChangeDependencies() {
    myTabs = <Tab>[
      Tab(
        child: Text(getTranslated(context, new_orders)!),
      ),
      Tab(
        child: Text(getTranslated(context, past_orders)!),
      ),
      Tab(
        child: Text(getTranslated(context, storage)!),
      ),
    ];
    controllerTab = TabController(length: myTabs.length, vsync: this);
    controllerTab!.addListener(() {
      setState(() {
        selectedIndex = controllerTab!.index;
      });
    });
    getOrderFuture = getOrders();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          overlayColor: Colors.black,
          openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          childrenButtonSize: Size(100, 100),
          spaceBetweenChildren: 4,
          label: Text(getTranslated(context, 'add_new_order')!),
          children: [
            SpeedDialChild(
                backgroundColor: Colors.green,
                labelBackgroundColor: Colors.green,
                foregroundColor: Colors.white,
                labelStyle: TextStyle(color: Colors.white, fontSize: 22),
                label: getTranslated(context, 'to_storage')!,
                onTap: () => showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) => BottomSheet(
                          onClosing: () {},
                          builder: (ctx) {
                            return SendToStorage(
                              navContext: ctx,
                            );
                          }),
                    ),
                child: Icon(
                  Icons.store_mall_directory_outlined,
                  size: 50,
                )),
            SpeedDialChild(
              label: getTranslated(context, 'to_user')!,
              labelStyle: TextStyle(color: Colors.black, fontSize: 22),
              child: Icon(Icons.person_outline, size: 50),
              onTap: () => showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (ctx) {
                  return BottomSheet(
                      onClosing: () {},
                      builder: (context) => SendToUser(
                            navContext: ctx,
                          ));
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            getTranslated(context, orders)!,
            //'Orders ${getTranslated(context, no_internet)}',
            style:
                TextStyle(fontFamily: "ProximaBold", color: Palette.loginhead),
          ),
          bottom: TabBar(
            isScrollable: true,
            controller: controllerTab,
            unselectedLabelColor: Colors.black,
            indicatorColor: Palette.green,
            labelColor: Colors.black,
            indicatorWeight: 5,
            unselectedLabelStyle:
                TextStyle(fontSize: 18, fontFamily: proxima_nova_reg),
            labelStyle: TextStyle(fontSize: 18, fontFamily: proxima_nova_bold),
            tabs: myTabs,
          ),
        ),
        body: Container(
          width: width,
          height: height,
          margin: EdgeInsets.all(10),
          child: FutureBuilder<BaseModel<OrdersResponse>>(
            future: getOrderFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.data == null) {
                    return Center(
                        child: Container(
                            child:
                                Text(snapshot.data!.error.getErrorMessage())));
                  } else {
                    orderList.clear();
                    orderListPast.clear();
                    storageList.clear();
                    storageList.addAll(snapshot.data!.data!.storage!);
                    for (int i = 0;
                        i < snapshot.data!.data!.data!.length;
                        i++) {
                      if (snapshot.data!.data!.data![i].orderStatus ==
                              'COMPLETE' ||
                          snapshot.data!.data!.data![i].orderStatus ==
                              'CANCEL' ||
                          snapshot.data!.data!.data![i].orderStatus ==
                              'REJECT') {
                        orderListPast.add(snapshot.data!.data!.data![i]);
                      } else {
                        orderList.add(snapshot.data!.data!.data![i]);
                      }
                    }
                    // return newOrderList(context, snapshot.data.data.data);
                    return _tabBar(context);
                  }
                } else {
                  return DeviceUtils.showProgress(true);
                }
              } else {
                return DeviceUtils.showProgress(true);
              }
            },
          ),
        ),
        // ),
      ),
    );
  }

  _tabBar(BuildContext context) =>
      TabBarView(controller: controllerTab, children: [
        RefreshIndicator(
            color: Palette.green,
            onRefresh: _refreshProducts,
            child: orderList.isEmpty
                ? Center(
                    child: Container(
                    child: Text(getTranslated(context, 'no_data_desc') ?? ''),
                  ))
                : newOrderList(context)),
        Wrap(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.70),
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 70.w,
                          child: TextField(
                            controller: searchController,
                            onChanged: onSearchTextChanged,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: getTranslated(context, 'search_hint'),
                                hintStyle: TextStyle(
                                    color: Palette.switchs,
                                    fontSize: 13,
                                    fontFamily: proxima_nova_reg)),
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  /* Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(50),
                            spreadRadius: 1,
                            blurRadius: 1,
                          )
                        ]),
                    child: SvgPicture.asset('assets/images/filter.svg'),
                  ),*/
                ],
              ),
            ),
            RefreshIndicator(
              onRefresh: _refreshProducts,
              color: Palette.green,
              child: Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: newOrderListPast(context)),
            ),
          ],
        ),
        RefreshIndicator(
            color: Palette.green,
            onRefresh: _refreshProducts,
            child: storageList.isEmpty
                ? Center(
                    child: Container(
                    child: Text(getTranslated(context, 'no_data_desc') ?? ''),
                  ))
                : storageListWidget(context)),
      ]);

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    orderListPast.forEach((order) {
      if (order.userName!.contains(text) || order.orderId!.contains(text))
        _searchResult.add(order);
    });
    setState(() {});
  }

  storageListWidget(BuildContext context) => ListView.builder(
      itemCount: storageList.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 200),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        String? dropdownValue = storageList[index].orderStatus;
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => OrderDetailScreen(storageList[index]),
            //     ));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white24, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "OID:",
                              style: TextStyle(
                                  color: Palette.switchs,
                                  fontFamily: proxima_nova_reg,
                                  fontSize: 12),
                            ),
                            Text(
                              storageList[index].orderId!,
                              style: TextStyle(
                                  color: Palette.switchs,
                                  fontFamily: proxima_nova_reg,
                                  fontSize: 12),
                            ),
                            Text(
                              " | ",
                              style: TextStyle(
                                  color: Palette.switchs,
                                  fontFamily: proxima_nova_reg,
                                  fontSize: 12),
                            ),
                            Text(
                              '${storageList[index].date}, ${storageList[index].time}',
                              style: TextStyle(
                                  color: Palette.switchs,
                                  fontFamily: proxima_nova_reg,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    )),
                DottedLine(
                  direction: Axis.horizontal,
                  lineThickness: 1.0,
                  dashColor: Palette.switchs,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                  child: ListView.builder(
                    itemCount: storageList[index].orderItems!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index1) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  storageList[index]
                                      .orderItems![index1]
                                      .itemName!,
                                  style: TextStyle(
                                      color: Palette.loginhead,
                                      fontFamily: "ProximaNova",
                                      fontSize: 14),
                                ),
                                Text(
                                  ' x ${storageList[index].orderItems![index1].qty}',
                                  style: TextStyle(
                                      color: Palette.green,
                                      fontFamily: "ProximaBold",
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Visibility(
                              child: Text(
                                '(${storageList[index].orderItems![index1].itemName})',
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: "ProximaNova",
                                    fontSize: 12),
                              ),
                              visible: false,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineThickness: 1.0,
                  dashColor: Palette.switchs,
                ),
                Container(
                  width: 100.w,
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 30, left: 30),
                            child: Text(
                              statusToString(dropdownValue!),
                              style: TextStyle(
                                  color: Palette.green,
                                  fontFamily: proxima_nova_bold,
                                  fontSize: 14),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
  newOrderList(BuildContext context) => ListView.builder(
        itemCount: orderList.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10, bottom: 200),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          String? dropdownValue = orderList[index].orderStatus;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(orderList[index]),
                  ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white24, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "OID:",
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 12),
                              ),
                              Text(
                                orderList[index].orderId!,
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 12),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 12),
                              ),
                              Text(
                                '${orderList[index].date}, ${orderList[index].time}',
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                orderList[index].userName!,
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: proxima_nova_bold,
                                    fontSize: 16),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: Palette.loginhead,
                                size: 35,
                              )
                            ],
                          ),
                        ],
                      )),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineThickness: 1.0,
                    dashColor: Palette.switchs,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    child: ListView.builder(
                      itemCount: orderList[index].orderItems!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index1) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    orderList[index]
                                        .orderItems![index1]
                                        .itemName!,
                                    style: TextStyle(
                                        color: Palette.loginhead,
                                        fontFamily: "ProximaNova",
                                        fontSize: 14),
                                  ),
                                  Text(
                                    ' x ${orderList[index].orderItems![index1].qty}',
                                    style: TextStyle(
                                        color: Palette.green,
                                        fontFamily: "ProximaBold",
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Visibility(
                                child: Text(
                                  '(${orderList[index].orderItems![index1].itemName})',
                                  style: TextStyle(
                                      color: Palette.switchs,
                                      fontFamily: "ProximaNova",
                                      fontSize: 12),
                                ),
                                visible: false,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineThickness: 1.0,
                    dashColor: Palette.switchs,
                  ),
                  Container(
                    width: 100.w,
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 30.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderList[index].paymentType!,
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${orderList[index].amount} ${SharedPreferenceHelper.getString(Preferences.currency_symbol)}',
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: proxima_nova_bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(children: [
                              Positioned(
                                child: DropdownButton(
                                    //value: dropdownValue ,
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Palette.loginhead,
                                      size: 30,
                                    ),
                                    iconSize: 30,
                                    elevation: 16,
                                    isDense: true,
                                    style: TextStyle(
                                        color: Palette.green,
                                        fontFamily: proxima_nova_bold,
                                        fontSize: 12),
                                    onChanged: (dynamic newValue) async {
                                      dropdownValue = newValue;
                                      Map<String, String?> param =
                                          new HashMap();
                                      param['id'] =
                                          orderList[index].id.toString();
                                      param['status'] = dropdownValue;
                                      print(param);
                                      var res = await changeOrderStatus(param);
                                      if (res.data!.success == true) {
                                        _refreshProducts();
                                        DeviceUtils.toastMessage(
                                            res.data!.data.toString());
                                      } else {
                                        DeviceUtils.toastMessage(
                                            res.data!.data.toString());
                                      }
                                      setState(() {});

                                      /* FutureBuilder<BaseModel<CommonResponse>>(
                                          future: changeOrderStatus(param),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState != ConnectionState.done) {
                                              return DeviceUtils.showProgress(true);
                                            } else {
                                              _refreshProducts();
                                              print('${snapshot.data!.data}');
                                              var data = snapshot.data!.data;
                                              print(data);

                                              setState(() {});
                                              if (data != null) {
                                                return DeviceUtils.toastMessage(data.data.toString());
                                              } else {
                                                return DeviceUtils.toastMessage(data!.data.toString());
                                              }
                                            }
                                          },
                                        );*/
                                      // selectedItemId = snapshot.data.data.data[snapshot.data.data.data.indexOf(newValue)].id;
                                      // print('value ${newValue.name} $selectedItemId');
                                    },
                                    items: orderList[index].orderStatus ==
                                            'PENDING'
                                        ? <String>[
                                            'APPROVE',
                                            'REJECT',
                                          ].map((item) {
                                            return new DropdownMenuItem<String>(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList()
                                        : orderList[index].orderStatus !=
                                                    'CANCEL' &&
                                                orderList[index].orderStatus !=
                                                    'REJECT' &&
                                                orderList[index].orderStatus !=
                                                    'COMPLETE'
                                            ? orderList[index].deliveryType ==
                                                        'SHOP' ||
                                                    orderList[index]
                                                            .deliveryType ==
                                                        'STORAGE'
                                                ? <String>[
                                                    'PREPARE_FOR_ORDER',
                                                    'READY_FOR_ORDER',
                                                    'COMPLETE'
                                                  ].map((item) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      child: Text(
                                                          statusToString(item)),
                                                      value: item,
                                                    );
                                                  }).toList()
                                                : <String>[
                                                    'PICKUP',
                                                    'DELIVERED',
                                                    'COMPLETE'
                                                  ].map((item) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      child: Text(
                                                          statusToString(item)),
                                                      value: item,
                                                    );
                                                  }).toList()
                                            : <String>[].map((item) {
                                                return new DropdownMenuItem<
                                                    String>(
                                                  child: Text(item),
                                                  value: item,
                                                );
                                              }).toList()),
                                right: 0,
                                left: 0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 30, left: 30),
                                child: Text(
                                  statusToString(dropdownValue!),
                                  style: TextStyle(
                                      color: Palette.green,
                                      fontFamily: proxima_nova_bold,
                                      fontSize: 12),
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  newOrderListPast(BuildContext context) => _searchResult.length != 0 &&
          searchController.text.isNotEmpty
      ? _searchResult.isEmpty
          ? Center(
              child: Container(
                  margin: EdgeInsets.only(bottom: 200),
                  child: Text(getTranslated(context, 'no_data_desc') ?? '')))
          : ListView.builder(
              itemCount: _searchResult.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                String? dropdownValue = _searchResult[index].orderStatus;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailScreen(_searchResult[index]),
                        ));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white24, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "OID:",
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      _searchResult[index].orderId!,
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      " | ",
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      '${_searchResult[index].date}, ${_searchResult[index].time}',
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _searchResult[index].userName!,
                                      style: TextStyle(
                                          color: Palette.loginhead,
                                          fontFamily: proxima_nova_bold,
                                          fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      color: Palette.loginhead,
                                      size: 35,
                                    )
                                  ],
                                ),
                              ],
                            )),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineThickness: 1.0,
                          dashColor: Palette.switchs,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, bottom: 10, top: 10),
                          child: ListView.builder(
                            itemCount: _searchResult[index].orderItems!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index1) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          _searchResult[index]
                                              .orderItems![index1]
                                              .itemName!,
                                          style: TextStyle(
                                              color: Palette.loginhead,
                                              fontFamily: "ProximaNova",
                                              fontSize: 14),
                                        ),
                                        Text(
                                          ' x ${_searchResult[index].orderItems![index1].qty}',
                                          style: TextStyle(
                                              color: Palette.green,
                                              fontFamily: "ProximaBold",
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      child: Text(
                                        '(${_searchResult[index].orderItems![index1].itemName})',
                                        style: TextStyle(
                                            color: Palette.switchs,
                                            fontFamily: "ProximaNova",
                                            fontSize: 12),
                                      ),
                                      visible: false,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineThickness: 1.0,
                          dashColor: Palette.switchs,
                        ),
                        Container(
                          width: 100.w,
                          padding: EdgeInsets.only(
                              left: 20, right: 20, bottom: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 30.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _searchResult[index].paymentType!,
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '\$${_searchResult[index].amount}',
                                      style: TextStyle(
                                          color: Palette.loginhead,
                                          fontFamily: proxima_nova_bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(children: [
                                    Container(
                                      width: 20.w,
                                      child: DropdownButton(
                                          //value: dropdownValue ,
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Palette.loginhead,
                                            size: 20,
                                          ),
                                          iconSize: 30,
                                          elevation: 16,
                                          isDense: true,
                                          style: TextStyle(
                                              color: Palette.green,
                                              fontFamily: proxima_nova_bold,
                                              fontSize: 12),
                                          onChanged: (dynamic newValue) {
                                            setState(() {
                                              dropdownValue = newValue;
                                              Map<String, String?> param =
                                                  new HashMap();
                                              param['id'] = _searchResult[index]
                                                  .id
                                                  .toString();
                                              param['status'] = dropdownValue;
                                              FutureBuilder<
                                                  BaseModel<CommonResponse>>(
                                                future:
                                                    changeOrderStatus(param),
                                                builder: (context, snapshot) {
                                                  DeviceUtils.toastMessage(
                                                      'before connection ');
                                                  if (snapshot
                                                          .connectionState !=
                                                      ConnectionState.done) {
                                                    return DeviceUtils
                                                        .showProgress(true);
                                                  } else {
                                                    print(
                                                        '${snapshot.data!.data}');
                                                    var data =
                                                        snapshot.data!.data;
                                                    print(data);
                                                    _refreshProducts();
                                                    setState(() {});
                                                    if (data != null) {
                                                      return Container(
                                                        child: DeviceUtils
                                                            .toastMessage(data
                                                                .data
                                                                .toString()),
                                                      );
                                                    } else {
                                                      return Container(
                                                          child: DeviceUtils
                                                              .toastMessage(data!
                                                                  .data
                                                                  .toString()));
                                                    }
                                                  }
                                                },
                                              );
                                              // selectedItemId = snapshot.data.data.data[snapshot.data.data.data.indexOf(newValue)].id;
                                              // print('value ${newValue.name} $selectedItemId');
                                            });
                                          },
                                          items: _searchResult[index]
                                                          .deliveryType ==
                                                      'SHOP' ||
                                                  _searchResult[index]
                                                          .deliveryType ==
                                                      'STORAGE'
                                              ? <String>[
                                                  'Pending',
                                                  'Approve',
                                                  'Reject',
                                                  'PREPARE_FOR_ORDER',
                                                  'READY_FOR_ORDER',
                                                  'COMPLETE'
                                                ].map((item) {
                                                  //print('value ${item.name} ');
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    child: Text(
                                                        statusToString(item)),
                                                    value: item,
                                                  );
                                                }).toList()
                                              : <String>[
                                                  'Pending',
                                                  'Approve',
                                                  'Reject',
                                                  'PICKUP',
                                                  'DELIVERED',
                                                  'COMPLETE'
                                                ].map((item) {
                                                  //print('value ${item.name} ');
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    child: Text(
                                                        statusToString(item)),
                                                    value: item,
                                                  );
                                                }).toList()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 5),
                                      child: Text(
                                        statusToString(dropdownValue!),
                                        style: TextStyle(
                                            color: Palette.green,
                                            fontFamily: proxima_nova_bold,
                                            fontSize: 12),
                                        textAlign: TextAlign.end,
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
      : orderListPast.length != 0
          ? ListView.builder(
              itemCount: orderListPast.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 200),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                String dropdownValue = orderListPast[index].orderStatus!;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailScreen(orderListPast[index]),
                        ));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white24, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "OID:",
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      orderListPast[index].orderId!,
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      " | ",
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      '${orderListPast[index].date}, ${orderListPast[index].time}',
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orderListPast[index].userName!,
                                      style: TextStyle(
                                          color: Palette.loginhead,
                                          fontFamily: proxima_nova_bold,
                                          fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      color: Palette.loginhead,
                                      size: 35,
                                    )
                                  ],
                                ),
                              ],
                            )),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineThickness: 1.0,
                          dashColor: Palette.switchs,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, bottom: 10, top: 10),
                          child: ListView.builder(
                            itemCount: orderListPast[index].orderItems!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index1) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          orderListPast[index]
                                              .orderItems![index1]
                                              .itemName!,
                                          style: TextStyle(
                                              color: Palette.loginhead,
                                              fontFamily: "ProximaNova",
                                              fontSize: 14),
                                        ),
                                        Text(
                                          ' x ${orderListPast[index].orderItems![index1].qty}',
                                          style: TextStyle(
                                              color: Palette.green,
                                              fontFamily: "ProximaBold",
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      child: Text(
                                        '(${orderListPast[index].orderItems![index1].itemName})',
                                        style: TextStyle(
                                            color: Palette.switchs,
                                            fontFamily: "ProximaNova",
                                            fontSize: 12),
                                      ),
                                      visible: false,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineThickness: 1.0,
                          dashColor: Palette.switchs,
                        ),
                        Container(
                          width: 100.w,
                          padding: EdgeInsets.only(
                              left: 20, right: 20, bottom: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 30.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderListPast[index].paymentType!,
                                      style: TextStyle(
                                          color: Palette.switchs,
                                          fontFamily: proxima_nova_reg,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '\$${orderListPast[index].amount}',
                                      style: TextStyle(
                                          color: Palette.loginhead,
                                          fontFamily: proxima_nova_bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Stack(children: [
                                /*Container(
                              width: 20.w,
                              child: DropdownButton(
                                  //value: dropdownValue ,
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Palette.loginhead,
                                    size: 20,
                                  ),
                                  iconSize: 30,
                                  elevation: 16,
                                  isDense: true,
                                  style: TextStyle(
                                      color: Palette.green,
                                      fontFamily: proxima_nova_bold,
                                      fontSize: 12),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                      Map<String, String> param = new HashMap();
                                      param['id'] = orderListPast[index].id.toString();
                                      param['status'] = dropdownValue;
                                      FutureBuilder<BaseModel<CommonResponse>>(
                                        future: changeOrderStatus(param),
                                        builder: (context, snapshot) {
                                          DeviceUtils.toastMessage('before connection ');
                                          if (snapshot.connectionState != ConnectionState.done) {
                                            return DeviceUtils.showProgress(true);
                                          } else {
                                            print('${snapshot.data.data}');
                                            var data = snapshot.data.data;
                                            print(data);
                                            setState(() {});
                                            if (data != null) {
                                              return Container(
                                                child:
                                                    DeviceUtils.toastMessage(data.data.toString()),
                                              );
                                            } else {
                                              return Container(
                                                  child: DeviceUtils.toastMessage(
                                                      data.data.toString()));
                                            }
                                          }
                                        },
                                      );
                                      // selectedItemId = snapshot.data.data.data[snapshot.data.data.data.indexOf(newValue)].id;
                                      // print('value ${newValue.name} $selectedItemId');
                                    });
                                  },
                                  items: orderListPast[index].deliveryType == 'SHOP'
                                      ? <String>[
                                            'Pending',
                                            'Approve',
                                            'Reject',
                                            'PREPARE_FOR_ORDER',
                                            'READY_FOR_ORDER',
                                            'COMPLETE'
                                          ].map((item) {
                                            //print('value ${item.name} ');
                                            return new DropdownMenuItem<String>(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList() ??
                                          []
                                      : <String>[
                                            'Pending',
                                            'Approve',
                                            'Reject',
                                            'PICKUP',
                                            'DELIVERED',
                                            'COMPLETE'
                                          ].map((item) {
                                            //print('value ${item.name} ');
                                            return new DropdownMenuItem<String>(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList() ??
                                          []),
                            ),*/
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 5),
                                  child: Text(
                                    statusToString(dropdownValue),
                                    style: TextStyle(
                                        color: Palette.green,
                                        fontFamily: proxima_nova_bold,
                                        fontSize: 12),
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
            
              child: Container(
                  margin: EdgeInsets.only(bottom: 200),
                  child: Text(getTranslated(context, 'no_data_desc') ?? '')));
}
