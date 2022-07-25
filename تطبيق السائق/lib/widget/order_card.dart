import 'dart:convert';

import 'package:alnaqel_driver/apiservice/ApiHeader.dart';
import 'package:alnaqel_driver/apiservice/Apiservice.dart';
import 'package:alnaqel_driver/localization/language/languages.dart';
import 'package:alnaqel_driver/model/orderlistdata.dart';
import 'package:alnaqel_driver/screen/getorderkitchenscreen.dart';
import 'package:alnaqel_driver/screen/orderlistscreen.dart';
import 'package:alnaqel_driver/util/constants.dart';
import 'package:alnaqel_driver/util/preferenceutils.dart';
import 'package:alnaqel_driver/widget/places_picker/providers/home_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCard extends StatefulWidget {
  final List<OrderData> orderdatalist;
  final int index;
  const OrderCard({Key? key, required this.orderdatalist, required this.index})
      : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final _text_cancelReason_controller = TextEditingController();
  String? _cancelReason = "0";
  String? _currentAddress;

  double current_lat = 0;
  double current_long = 0;

  late String cancelReason;

  List can_reason = [];

  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position? _currentPosition;
  String _result = "0";
  List<OrderData> orderdatalist = [];
  int index = 0;
  @override
  void initState() {
    _getCurrentLocation();
    orderdatalist = widget.orderdatalist;
    cancelReason = PreferenceUtils.getString(Constants.cancelReason);
    if (cancelReason.isEmpty) return;
    var json = JsonDecoder().convert(cancelReason);
    can_reason.addAll(json);
    index = widget.index;
    Constants.currentlatlong()
        .whenComplete(() => Constants.currentlatlong().then((origin) {
              current_lat = origin!.latitude;
              current_long = origin.longitude;
            }));
    super.initState();
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        current_lat = position.latitude;
        current_long = position.longitude;

        print("current_lat852:$current_lat");
        print("current_lang852:$current_long");
      });

      //_getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenheight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;
    String paymentstatus;
    String paymentType;
    Color paymentcolor;
    print(orderdatalist[index].id ?? -1);
    if (orderdatalist[index].paymentStatus.toString() == "0") {
      paymentstatus = "Pending";
      paymentcolor = Color(Constants.redtext);
    } else {
      paymentstatus = "Completed";
      paymentcolor = Color(Constants.greentext);
    }

    if (orderdatalist[index].paymentType.toString() == "COD") {
      paymentType = Languages.of(context)!.cashondeliverylable;
    } else {
      paymentType = orderdatalist[index].paymentType.toString();
    }

    double userLat = double.parse(orderdatalist[index].userAddress!.lat!);
    double userLong = double.parse(orderdatalist[index].userAddress!.lang!);

    assert(userLat is double);
    assert(userLong is double);

    String distance = "0";
    double distanceInMeters = Geolocator.distanceBetween(
        current_lat, current_long, userLat, userLong);
    double distanceinkm = distanceInMeters / 1000;
    String str = distanceinkm.toString();
    var distance12 = str.split('.');
    distance = distance12[0];
    return Padding(
      padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => BottomSheet(
                    onClosing: () {},
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, right: 5, bottom: 0, left: 5),
                          decoration: BoxDecoration(
                              color: Color(Constants.itembgcolor),
                              border: Border.all(
                                color: Color(Constants.itembgcolor),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: widget.orderdatalist[widget.index]
                                      .orderItems!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, position) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget
                                                .orderdatalist[widget.index]
                                                .orderItems![position]
                                                .itemName!,
                                            style: TextStyle(
                                                color:
                                                    Color(Constants.greaytext),
                                                fontFamily: Constants.appFont,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "  x " +
                                                widget
                                                    .orderdatalist[widget.index]
                                                    .orderItems![position]
                                                    .qty
                                                    .toString(),
                                            style: TextStyle(
                                                color:
                                                    Color(Constants.greentext),
                                                fontFamily: Constants.appFont,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        HomeProvider.of(context, listen: false)
                                            .OpenCancelBottomSheet(
                                                widget
                                                    .orderdatalist[widget.index]
                                                    .id
                                                    .toString(),
                                                context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 0,
                                            left: 5,
                                            right: 5,
                                            bottom: 0),
                                        alignment: Alignment.topRight,
                                        child: SvgPicture.asset(
                                          "images/close.svg",
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        launch(
                                            "tel:${widget.orderdatalist[widget.index].user!.phone!}");
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 0,
                                            left: 5,
                                            right: 5,
                                            bottom: 0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.call,
                                              color:
                                                  Color(Constants.greentext)),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print(
                                            "Previous_status:${PreferenceUtils.getString(Constants.previosOrderStatus)}");

                                        if (PreferenceUtils.getString(Constants
                                                    .previosOrderStatus) ==
                                                "COMPLETE" ||
                                            PreferenceUtils.getString(Constants
                                                    .previosOrderStatus)
                                                .isEmpty ||
                                            PreferenceUtils.getString(Constants
                                                    .previosOrderStatus) ==
                                                "CANCEL") {
                                          Constants.checkNetwork().whenComplete(() => HomeProvider.of(context, listen: false).callApiForAcceptorder(
                                              widget.orderdatalist[widget.index]
                                                  .id
                                                  .toString(),
                                              widget.orderdatalist[widget.index]
                                                  .orderId
                                                  .toString(),
                                              widget.orderdatalist[widget.index]
                                                  .vendor!.name,
                                              widget.orderdatalist[widget.index]
                                                  .vendor!.mapAddress,
                                              distance,
                                              widget.orderdatalist[widget.index]
                                                  .vendor!.lat,
                                              widget.orderdatalist[widget.index]
                                                  .vendor!.lang,
                                              widget.orderdatalist[widget.index]
                                                  .userAddress!.lat,
                                              widget.orderdatalist[widget.index]
                                                  .userAddress!.lang,
                                              widget.orderdatalist[widget.index]
                                                  .userAddress!.address,
                                              widget.orderdatalist[widget.index]
                                                  .vendor!.image,
                                              widget.orderdatalist[widget.index]
                                                  .user!.name));
                                        } else {
                                          // setState(() {
                                          //   lastorder = true;

                                          //   if (lastorder == false) {
                                          //     lastorder = true;
                                          //   }
                                          // });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 0,
                                            left: 0,
                                            right: 10,
                                            bottom: 0),
                                        alignment: Alignment.topRight,
                                        child: SvgPicture.asset(
                                          "images/right.svg",
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
                    },
                  ));
        },
        child: Container(
          margin: EdgeInsets.only(top: 10, right: 5, bottom: 0, left: 5),
          decoration: BoxDecoration(
              color:  widget.orderdatalist[widget.index].special ?? false
                  ? Colors.amberAccent
                  : Color(Constants.itembgcolor),
              border: Border.all(
                color:  widget.orderdatalist[widget.index].special ?? false
                    ? Colors.amber
                    : Color(Constants.itembgcolor),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(0),
                right: ScreenUtil().setWidth(0)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context)!.oidlable +
                              "    " +
                              widget.orderdatalist[widget.index].orderId!,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: Constants.appFontBold,
                              fontSize: 16),
                        ),
                        Center(
                          child: Text(
                            widget.orderdatalist[widget.index].special ?? false
                                ? 'طلب مميز'
                                : '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(
                                12,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            Languages.of(context)!.dollersignlable +
                                widget.orderdatalist[widget.index].amount
                                    .toString(),
                            style: TextStyle(
                                color: Color(Constants.colorTheme),
                                fontFamily: Constants.appFontBold,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            margin: EdgeInsets.only(
                                top: 5, left: 0, right: 5, bottom: 30),
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              // imageUrl: imageurl,
                              imageUrl: widget
                                  .orderdatalist[widget.index].vendor!.image!,
                              fit: BoxFit.fill,
                              width: ScreenUtil().setWidth(180),
                              height: ScreenUtil().setHeight(55),
                              // screenwidth *
                              //     0.15,
                              // height:
                              // screenheight *
                              //     0.09,

                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              placeholder: (context, url) =>
                                  SpinKitFadingCircle(
                                      color: Color(Constants.greentext)),
                              errorWidget: (context, url, error) =>
                                  Image.asset("images/no_image.png"),
                            ),
                            // child: Image.asset(
                            //   "images/food.png",
                            //   fit: BoxFit.fill,
                            //   width: screenwidth *
                            //       0.15,
                            //   height: screenheight *
                            //       0.09,
                            // ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            // width: screenwidth * 0.65,
                            // height: screenheight * 0.15,
                            color: widget.orderdatalist[widget.index].special ??
                                    false
                                ? Colors.amberAccent
                                : Color(Constants.itembgcolor),
                            margin: EdgeInsets.only(
                                top: 20, left: 5, right: 5, bottom: 0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: AutoSizeText(
                                        widget.orderdatalist[widget.index]
                                            .vendor!.name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            color: Color(Constants.whitetext),
                                            fontFamily: Constants.appFontBold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            HomeProvider.of(context,
                                                    listen: false)
                                                .OpenCancelBottomSheet(
                                                    widget
                                                        .orderdatalist[
                                                            widget.index]
                                                        .id
                                                        .toString(),
                                                    context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 0,
                                                left: 5,
                                                right: 5,
                                                bottom: 0),
                                            alignment: Alignment.topRight,
                                            child: SvgPicture.asset(
                                              "images/close.svg",
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(
                                                "Previous_status:${PreferenceUtils.getString(Constants.previosOrderStatus)}");

                                            if (PreferenceUtils.getString(Constants
                                                        .previosOrderStatus) ==
                                                    "COMPLETE" ||
                                                PreferenceUtils.getString(
                                                        Constants
                                                            .previosOrderStatus)
                                                    .isEmpty ||
                                                PreferenceUtils.getString(Constants
                                                        .previosOrderStatus) ==
                                                    "CANCEL") {
                                              Constants.checkNetwork().whenComplete(() => HomeProvider.of(context, listen: false).callApiForAcceptorder(
                                                  widget.orderdatalist[widget.index].id
                                                      .toString(),
                                                  widget.orderdatalist[widget.index].orderId
                                                      .toString(),
                                                  widget
                                                      .orderdatalist[
                                                          widget.index]
                                                      .vendor!
                                                      .name,
                                                  widget
                                                      .orderdatalist[
                                                          widget.index]
                                                      .vendor!
                                                      .mapAddress,
                                                  distance,
                                                  widget
                                                      .orderdatalist[
                                                          widget.index]
                                                      .vendor!
                                                      .lat,
                                                  widget
                                                      .orderdatalist[widget.index]
                                                      .vendor!
                                                      .lang,
                                                  widget.orderdatalist[widget.index].userAddress!.lat,
                                                  widget.orderdatalist[widget.index].userAddress!.lang,
                                                  widget.orderdatalist[widget.index].userAddress!.address,
                                                  widget.orderdatalist[widget.index].vendor!.image,
                                                  widget.orderdatalist[widget.index].user!.name));
                                            } else {
                                              // setState(() {
                                              //   lastorder = true;

                                              //   if (lastorder == false) {
                                              //     lastorder = true;
                                              //   }
                                              // });
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 0,
                                                left: 0,
                                                right: 10,
                                                bottom: 0),
                                            alignment: Alignment.topRight,
                                            child: SvgPicture.asset(
                                              "images/right.svg",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(
                                      top: 5, left: 0, right: 5, bottom: 0),

                                  color: Colors.transparent,
                                  // height:screenheight * 0.03,
                                  child: AutoSizeText(
                                    widget.orderdatalist[widget.index].vendor!
                                            .mapAddress ??
                                        '',
                                    overflow: TextOverflow.visible,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Color(Constants.greaytext),
                                        fontFamily: Constants.appFont,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 8.0,
                    dashColor: Color(Constants.dashline),
                    dashRadius: 0.0,
                    dashGapLength: 5.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.orderdatalist[widget.index].user!.name!,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: Constants.appFontBold,
                              fontSize: 16),
                        ),
                        RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1,
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 0, bottom: 0, right: 5),
                                  child: SvgPicture.asset(
                                    "images/location.svg",
                                    width: 13,
                                    height: 13,
                                  ),
                                ),
                              ),

                              WidgetSpan(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0, bottom: 0, right: 5),
                                  child: Text(
                                    distance +
                                        " " +
                                        Languages.of(context)!.kmfarawaylable,
                                    style: TextStyle(
                                      color: Color(Constants.whitetext),
                                      fontSize: 12,
                                      fontFamily: Constants.appFont,
                                    ),
                                  ),
                                ),
                              ),

                              //
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 10),
                    child: Text(
                      widget.orderdatalist[widget.index].userAddress?.address ??
                          '',
                      overflow: TextOverflow.visible,
                      maxLines: 5,
                      style: TextStyle(
                          color: Color(Constants.greaytext),
                          fontFamily: Constants.appFont,
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 0, left: 5),
                    width: screenwidth,
                    child: DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1.0,
                      dashLength: 8.0,
                      dashColor: Color(Constants.dashline),
                      dashRadius: 0.0,
                      dashGapLength: 5.0,
                      dashGapColor: Colors.transparent,
                      dashGapRadius: 0.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 15,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        Languages.of(context)!.paymentlable,
                                        style: TextStyle(
                                            color: Color(Constants.whitetext),
                                            fontSize: 16,
                                            fontFamily: Constants.appFontBold),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text(
                                        "(" + paymentstatus + ")",
                                        style: TextStyle(
                                            color: paymentcolor,
                                            fontSize: 16,
                                            fontFamily: Constants.appFontBold),
                                      )),
                                ],
                              ),
                              Text(
                                paymentType,
                                style: TextStyle(
                                    color: Color(Constants.greaytext),
                                    fontSize: 14,
                                    fontFamily: Constants.appFont),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
