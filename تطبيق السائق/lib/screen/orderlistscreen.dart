import 'dart:async';
import 'dart:convert';

import 'package:alnaqel_driver/localization/language/languages.dart';
import 'package:alnaqel_driver/widget/places_picker/providers/home_provider.dart';
import 'package:alnaqel_driver/widget/places_picker/src/place_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alnaqel_driver/screen/getorderkitchenscreen.dart';
import 'package:alnaqel_driver/screen/selectlocationscreen.dart';
import 'package:alnaqel_driver/util/constants.dart';
import 'package:alnaqel_driver/util/preferenceutils.dart';
import 'package:alnaqel_driver/widget/transitions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderList createState() => _OrderList();
}

class _OrderList extends State<OrderList> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    homeProvider = HomeProvider(context);
  }

  late HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    /* ScreenUtil.init(context,
        designSize: Size(screenwidth, screenheight), allowFontScaling: true);
*/
    return ChangeNotifierProvider.value(
      value: homeProvider,
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: new SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/background_image.png'),
                fit: BoxFit.cover,
              )),
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  // resizeToAvoidBottomPadding: true,
                  key: _scaffoldKey,
                  body: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints k) {
                    return RefreshIndicator(
                      color: Color(Constants.greentext),
                      backgroundColor: Colors.transparent,
                      onRefresh:
                          context.read<HomeProvider>().callApiForGetOrderList,
                      key: _refreshIndicatorKey,
                      child: ModalProgressHUD(
                        inAsyncCall: context.watch<HomeProvider>().showSpinner,
                        opacity: 1.0,
                        color: Colors.transparent.withOpacity(0.2),
                        progressIndicator: SpinKitFadingCircle(
                            color: Color(Constants.greentext)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 0),
                              color: Colors.transparent,
                              child: Column(
                                // physics: NeverScrollableScrollPhysics(),
                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setWidth(0)),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 0, right: 0, bottom: 0, left: 0),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(0),
                                            right: ScreenUtil().setWidth(0)),
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: ScreenUtil().setHeight(55),
                                          color: Color(Constants.bgcolor),
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (PreferenceUtils
                                                              .getBool(Constants
                                                                  .isGlobalDriver) ==
                                                          true &&
                                                          PreferenceUtils.getBool(
                                                                  Constants
                                                                      .isZonerDriver) ==
                                                              true) {
                                                        Navigator.of(context)
                                                            .push(Transitions(
                                                                transitionType:
                                                                    TransitionType
                                                                        .slideLeft,
                                                                curve: Curves
                                                                    .slowMiddle,
                                                                reverseCurve: Curves
                                                                    .slowMiddle,
                                                                widget:
                                                                    SelectLocation()));
                                                      } else {
                                                        if(PreferenceUtils
                                                                .getBool(Constants
                                                                    .isZonerDriver) ==
                                                            false){
                                                              Constants.toastMessage(
                                                              Constants
                                                                  .notZonerDriverSlogan);
                                                            }else{
                                                              Constants.toastMessage(
                                                            Constants
                                                                .notGlobalDriverSlogan);
                                                            }
                                                        
                                                      }
                                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectLocation()));
                                                    },
                                                    child: ListView(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 20,
                                                                  top: 10),
                                                          child: Text(
                                                            context
                                                                        .watch<
                                                                            HomeProvider>()
                                                                        .name !=
                                                                    null
                                                                ? context
                                                                    .watch<
                                                                        HomeProvider>()
                                                                    .name!
                                                                : Languages.of(
                                                                        context)!
                                                                    .userlable,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    Constants
                                                                        .appFontBold,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    top: 0),
                                                            child: RichText(
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textScaleFactor:
                                                                  1,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                      text: context.watch<HomeProvider>().location !=
                                                                              null
                                                                          ? context
                                                                              .watch<
                                                                                  HomeProvider>()
                                                                              .location
                                                                          : Languages.of(context)!
                                                                              .setlocationlable,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            Constants.appFont,
                                                                      )),
                                                                  WidgetSpan(
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              5,
                                                                          top:
                                                                              0,
                                                                          bottom:
                                                                              3),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        "images/down_arrow.svg",
                                                                        width:
                                                                            8,
                                                                        height:
                                                                            8,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  //
                                                                ],
                                                              ),
                                                            )
                                                            // child: Text("London, United Kingdom",
                                                            //   style: TextStyle(color: Colors.white,fontFamily: Constants.appFont,fontSize: 14),),

                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          top: 0,
                                                          right: 0),
                                                      child: Transform.scale(
                                                        scale: 0.6,
                                                        child: CupertinoSwitch(
                                                            trackColor: Color(
                                                                Constants
                                                                    .colorBlack),
                                                            activeColor: Color(
                                                                Constants
                                                                    .greentext),
                                                            value: context
                                                                .watch<
                                                                    HomeProvider>()
                                                                .isOnline,
                                                            onChanged:
                                                                (newval) {
                                                              Provider.of<HomeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isOnline = !Provider.of<
                                                                          HomeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isOnline;

                                                              Constants.checkNetwork().whenComplete(() => Provider.of<
                                                                          HomeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .callApiForUpdateStatus(Provider.of<
                                                                              HomeProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isOnline));
                                                            }),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      visible: context
                                          .watch<HomeProvider>()
                                          .showduty,
                                      child: Expanded(
                                        child: PlacePicker(
                                          initialPosition: LatLng(0, 0),
                                          orders: context
                                              .watch<HomeProvider>()
                                              .orderdatalist,
                                              storage: context
                                              .watch<HomeProvider>()
                                              .storagedatalist,
                                        ),
                                      )),
                                  Visibility(
                                    visible:
                                        context.watch<HomeProvider>().hideduty,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // physics: NeverScrollableScrollPhysics(),
                                        // mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(top: 50),
                                              child: SvgPicture.asset(
                                                "images/offline.svg",
                                                width:
                                                    ScreenUtil().setHeight(200),
                                                height:
                                                    ScreenUtil().setHeight(200),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20.0,
                                                  left: 15.0,
                                                  right: 15,
                                                  bottom: 0),
                                              child: Text(
                                                Languages.of(context)!
                                                    .youareofflinelable,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        Constants.appFontBold,
                                                    fontSize: 20),
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 15.0,
                                                  right: 15,
                                                  bottom: 0),
                                              child: Text(
                                                Languages.of(context)!
                                                    .dutystatusofflinelable,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        Constants.appFont,
                                                    fontSize: 16),
                                                maxLines: 4,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 30.0,
                                                    left: 15.0,
                                                    right: 15,
                                                    bottom: 20),
                                                child: InkWell(
                                                  onTap: () {
                                                    context
                                                        .watch<HomeProvider>()
                                                        .isOnline = true;

                                                    Constants.checkNetwork()
                                                        .whenComplete(() => context
                                                            .watch<
                                                                HomeProvider>()
                                                            .callApiForUpdateStatus(
                                                                context
                                                                    .watch<
                                                                        HomeProvider>()
                                                                    .isOnline));
                                                  },
                                                  child: RichText(
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textScaleFactor: 1,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: Languages.of(
                                                                    context)!
                                                                .reconnectlable,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  Constants
                                                                      .colorTheme),
                                                              fontSize: 16,
                                                              fontFamily: Constants
                                                                  .appFontBold,
                                                            )),

                                                        //
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        context.watch<HomeProvider>().nojob,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // physics: NeverScrollableScrollPhysics(),
                                        // mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(top: 50),
                                              child: SvgPicture.asset(
                                                "images/no_job.svg",
                                                width:
                                                    ScreenUtil().setHeight(200),
                                                height:
                                                    ScreenUtil().setHeight(200),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20.0,
                                                  left: 15.0,
                                                  right: 15,
                                                  bottom: 0),
                                              child: Text(
                                                Languages.of(context)!
                                                    .nonewjoblable,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        Constants.appFontBold,
                                                    fontSize: 20),
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 15.0,
                                                  right: 15,
                                                  bottom: 0),
                                              child: Text(
                                                Languages.of(context)!
                                                    .youhavenotnewjoblable,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        Constants.appFont,
                                                    fontSize: 16),
                                                maxLines: 4,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Visibility(
                              visible: context.watch<HomeProvider>().lastorder,
                              child: Container(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: ScreenUtil().setHeight(100),
                                    color: const Color(0xFF42565f),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 20, top: 20),
                                          child: Column(
                                            children: [
                                              Text(
                                                Languages.of(context)!
                                                        .oidlable +
                                                    "  " +
                                                    PreferenceUtils.getString(
                                                        Constants
                                                            .previosOrderOrderid),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        Constants.appFontBold,
                                                    fontSize: 16),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      _OpenCancelBottomSheet(
                                                          PreferenceUtils
                                                              .getString(Constants
                                                                  .previosOrderId
                                                                  .toString()),
                                                          context);
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10, top: 10),
                                                      child: Text(
                                                        Languages.of(context)!
                                                            .canceldeliverylable,
                                                        style: TextStyle(
                                                            color: Color(
                                                                Constants
                                                                    .redtext),
                                                            fontFamily:
                                                                Constants
                                                                    .appFont,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  GetOrderKitchen()));
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 12, top: 10),
                                                      child: Text(
                                                        Languages.of(context)!
                                                            .pickupanddeliverlable,
                                                        style: TextStyle(
                                                            color: Color(
                                                                Constants
                                                                    .greentext),
                                                            fontFamily:
                                                                Constants
                                                                    .appFont,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5, top: 12),
                                                      child: SvgPicture.asset(
                                                          "images/right_arrow.svg")),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 20),
                                          child: CachedNetworkImage(
                                            // imageUrl: imageurl,

                                            imageUrl: PreferenceUtils.getString(
                                                Constants
                                                    .previosOrderVendorImage),
                                            fit: BoxFit.fill,
                                            width: ScreenUtil().setWidth(55),
                                            height: ScreenUtil().setHeight(55),

                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                SpinKitFadingCircle(
                                                    color: Color(
                                                        Constants.greentext)),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                                        "images/no_image.png"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )

                            // new Container(child: Body())
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          ),
        );
      }),
    );
  }

  Future<bool> _onWillPop() async {
    return true;
  }

  void _OpenCancelBottomSheet(String id, BuildContext context) {
    dynamic screenwidth = MediaQuery.of(context).size.width;
    dynamic screenheight = MediaQuery.of(context).size.height;

    final _formKey = GlobalKey<FormState>();
    String _review = "";

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: Color(Constants.itembgcolor),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 20, left: 20, bottom: 0, right: 10),
                        child: Text(
                          Languages.of(context)!.telluslable,
                          style: TextStyle(
                              color: Color(Constants.whitetext),
                              fontSize: 18,
                              fontFamily: Constants.appFont),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 5, left: 20, bottom: 0, right: 10),
                        child: Text(
                          Languages.of(context)!.whycancellable,
                          style: TextStyle(
                              color: Color(Constants.whitetext),
                              fontSize: 18,
                              fontFamily: Constants.appFont),
                        ),
                      ),
                      ListView.builder(
                          itemCount:
                              context.watch<HomeProvider>().can_reason.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, position) {
                            return Container(
                              width: screenwidth,
                              margin: EdgeInsets.only(
                                  top: 10, left: 20, bottom: 0, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 0, left: 0, bottom: 0, right: 0),
                                    child: Text(
                                      // can_reason[position],
                                      context
                                          .watch<HomeProvider>()
                                          .can_reason[position],
                                      overflow: TextOverflow.visible,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Color(Constants.greaytext),
                                          fontSize: 12,
                                          fontFamily: Constants.appFont),
                                    ),
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor:
                                          Color(Constants.whitetext),
                                      disabledColor: Color(Constants.whitetext),
                                    ),
                                    child: Radio<String>(
                                      activeColor: Color(Constants.greentext),
                                      value: context
                                          .watch<HomeProvider>()
                                          .can_reason[position],
                                      groupValue: context
                                          .watch<HomeProvider>()
                                          .cancelReason,
                                      onChanged: (value) {
                                        setState(() {
                                          context
                                              .watch<HomeProvider>()
                                              .cancelReason = value;

                                          // _handleRadioValueChange;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      Container(
                        margin: EdgeInsets.only(
                            top: 10, left: 10, bottom: 20, right: 20),
                        child: Card(
                          color: Color(Constants.bgcolor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5.0,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              validator: Constants.kvalidateFullName,
                              keyboardType: TextInputType.text,
                              controller: context
                                  .watch<HomeProvider>()
                                  .text_cancelReason_controller,
                              maxLines: 5,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: Constants.appFontBold),
                              decoration: Constants.kTextFieldInputDecoration
                                  .copyWith(
                                      contentPadding: EdgeInsets.only(
                                          left: 20, top: 20, right: 20),
                                      hintText: Languages.of(context)!
                                          .cancelreasonlable,
                                      hintStyle: TextStyle(
                                          color: Color(Constants.greaytext),
                                          fontFamily: Constants.appFont,
                                          fontSize: 14)),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print(
                              "RadioValue:${context.watch<HomeProvider>().cancelReason}");

                          if (context.watch<HomeProvider>().cancelReason ==
                              "0") {
                            Constants.toastMessage(
                                Languages.of(context)!.selectcancelreasonlable);

                            // Constants.createSnackBar("Select Cancel Reason", context, Color(Constants.redtext));
                          } else if (context
                                  .watch<HomeProvider>()
                                  .cancelReason ==
                              Languages.of(context)!.otherreasonlable) {
                            if (context
                                    .watch<HomeProvider>()
                                    .text_cancelReason_controller
                                    .text
                                    .length ==
                                0) {
                              Constants.toastMessage(
                                  Languages.of(context)!.addreasonlable);
                              // Constants.createSnackBar("Add Reason", context, Color(Constants.redtext));
                            } else {
                              context.watch<HomeProvider>().cancelReason =
                                  context
                                      .watch<HomeProvider>()
                                      .text_cancelReason_controller
                                      .text;
                            }
                          } else {
                            Constants.checkNetwork().whenComplete(() => context
                                .watch<HomeProvider>()
                                .callApiForCacelorder(
                                    id,
                                    context
                                        .watch<HomeProvider>()
                                        .cancelReason));
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 10, left: 10, bottom: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13.0),
                              color: Color(Constants.greentext),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.0), //(x,y)
                                  blurRadius: 0.0,
                                ),
                              ],
                            ),
                            width: screenwidth,
                            height: screenheight * 0.07,
                            child: Center(
                              child: Container(
                                color: Color(Constants.greentext),
                                child: Text(
                                  Languages.of(context)!.submitreviewlable,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: Constants.appFont),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
