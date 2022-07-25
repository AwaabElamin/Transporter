import 'dart:convert';

import 'package:alnaqel_driver/apiservice/ApiHeader.dart';
import 'package:alnaqel_driver/apiservice/Apiservice.dart';
import 'package:alnaqel_driver/localization/language/languages.dart';
import 'package:alnaqel_driver/model/orderlistdata.dart';
import 'package:alnaqel_driver/screen/getorderkitchenscreen.dart';
import 'package:alnaqel_driver/util/constants.dart';
import 'package:alnaqel_driver/util/preferenceutils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  late BuildContext context;

  HomeProvider(this.context) {
    this.context = context;
    PreferenceUtils.init();

    name = PreferenceUtils.getString(Constants.driverfirstname) +
        " " +
        PreferenceUtils.getString(Constants.driverlastname);
    location = PreferenceUtils.getString(Constants.driverzone);

    Constants.currentlatlong()
        .whenComplete(() => Constants.currentlatlong().then((origin) {
              current_lat = origin!.latitude;
              current_long = origin.longitude;
            }));

    // if (mounted) {
    if (PreferenceUtils.getstatus(Constants.isonline) == true) {
      // setState(() {
      isOnline = true;
      nojob = true;
      hideduty = false;
      showduty = false;

      // Constants.checkNetwork().whenComplete(() => pr.show());
      Constants.checkNetwork().whenComplete(() => callApiForGetOrderList());

      checkforpermission();
      // });
    } else {
      isOnline = false;
      nojob = false;
      hideduty = true;
      showduty = false;
    }
  }

  static HomeProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<HomeProvider>(context, listen: listen);

  bool showSpinner = false;

  List<OrderData> orderdatalist = <OrderData>[];
  List<OrderData> storagedatalist = <OrderData>[];

  List can_reason = [];

  final text_cancelReason_controller = TextEditingController();
  double current_lat = 0;
  double current_long = 0;
  String? cancelReason = "1";
  bool isOnline = false;

  String? name;
  String? location;
  int? status;

  // ProgressDialog pr;
  bool showduty = false;
  bool hideduty = false;
  bool nojob = true;
  bool lastorder = false;
  List<OrderItems> orderitemlist = <OrderItems>[];

  void setCancelReason(String? value) {
    cancelReason = value;
    notifyListeners();
  }

  void setShowSpinner(bool value) {
    showSpinner = value;
    notifyListeners();
  }

  void callApiForUpdateStatus(bool isOnline) {
    setShowSpinner(true);

    print(isOnline);

    if (isOnline == true) {
      status = 1;
      print(status);
    } else if (isOnline == false) {
      status = 0;
      print(status);
    }
    RestClient(ApiHeader().dioData())
        .driverupdatestatus(status.toString())
        .then((response) {
      final body = json.decode(response!);
      bool? sucess = body['success'];
      if (sucess = true) {
        print("duty:$isOnline");

        if (isOnline == true) {
          showSpinner = false;

          nojob = true;
          hideduty = false;
          showduty = false;

          PreferenceUtils.setstatus(Constants.isonline, true);

          checkforpermission();

          // Constants.checkNetwork().whenComplete(() => pr.show());
          Constants.checkNetwork().whenComplete(() => callApiForGetOrderList());
        } else if (isOnline == false) {
          nojob = false;
          hideduty = true;
          showduty = false;
          PreferenceUtils.setstatus(Constants.isonline, false);

          showSpinner = false;
        }

        showSpinner = false;

        var msg = body['data'];
        Constants.createSnackBar(msg, context, Color(Constants.greentext));
      } else if (sucess == false) {
        showSpinner = false;

        var msg = body['data'];
        // print(msg);
        Constants.createSnackBar(msg, context, Color(Constants.redtext));
      }
      notifyListeners();
    }).catchError((Object obj) {
      final snackBar = SnackBar(
        content: Text(Languages.of(context)!.servererrorlable),
        backgroundColor: Color(Constants.redtext),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      showSpinner = false;

      print("error:$obj");
      print(obj.runtimeType);
      notifyListeners();
      //AppConstant.toastMessage("Internal Server Error");
    });
  }

  void checkforpermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      print("denied");
    } else if (permission == LocationPermission.whileInUse) {
      print("whileInUse56362");
      Constants.currentlatlong()
          .whenComplete(() => Constants.currentlatlong().then((value) {}));
      Constants.cuttentlocation()
          .whenComplete(() => Constants.cuttentlocation().then((value) {}));
      // Constants.checkNetwork().whenComplete(() => callApiForGetOrderList());

    } else if (permission == LocationPermission.always) {
      print("always5");
      Constants.currentlatlong()
          .whenComplete(() => Constants.currentlatlong().then((value) {}));
      Constants.cuttentlocation()
          .whenComplete(() => Constants.cuttentlocation().then((value) {}));
      // Constants.checkNetwork().whenComplete(() => callApiForGetOrderList());

    }
  }

  Future<void> callApiForGetOrderList() async {
    showSpinner = true;
    print('oh my');
    notifyListeners();
    RestClient(ApiHeader().dioData()).driveorderlist().then((response) {
      print("OrderList:${response.toJson()}");
      if (response.success = true) {
        if (response.data!.length != 0) {
          orderdatalist.clear();
          orderdatalist.addAll(response.data!);
          storagedatalist.clear();
          storagedatalist.addAll(response.storage!);
          print("orderdatalistLength:${orderdatalist.length}");
          nojob = false;
          showduty = true;

          showSpinner = false;

          // return true;
        } else {
          print("orderdatalistLength000:${orderdatalist.length}");

          showSpinner = false;

          nojob = true;
          showduty = false;

          // return false;

          //show no new order
        }
      } else {
        showSpinner = false;

        nojob = true;
        showduty = false;

        // return false;
      }
      notifyListeners();
    }).catchError((Object obj) {
      final snackBar = SnackBar(
        content: Text(Languages.of(context)!.servererrorlable),
        backgroundColor: Color(Constants.redtext),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("error:$obj");
      print(obj.runtimeType);
      nojob = true;
      showduty = false;

      showSpinner = false;

      notifyListeners();

      // return false;
      //AppConstant.toastMessage("Internal Server Error");
    });
  }

  void callApiForCacelorder(String id, String? cancelReason) {
    print(id);

    showSpinner = true;
    notifyListeners();

    RestClient(ApiHeader().dioData())
        .cancelorder(id, "CANCEL", cancelReason)
        .then((response) {
      print("order_response:$response");

      final body = json.decode(response!);
      bool? sucess = body['success'];
      if (sucess = true) {
        showSpinner = false;
        var msg = Languages.of(context)!.ordercancellable;
        Constants.createSnackBar(msg, context, Color(Constants.greentext));

        // lastorder = false;
        Constants.checkNetwork().whenComplete(() => callApiForGetOrderList());
      } else if (sucess == false) {
        showSpinner = false;

        var msg = Languages.of(context)!.tryagainlable;
        // print(msg);
        Constants.createSnackBar(msg, context, Color(Constants.redtext));
      }
    }).catchError((Object obj) {
      final snackBar = SnackBar(
        content: Text(Languages.of(context)!.servererrorlable),
        backgroundColor: Color(Constants.redtext),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      showSpinner = false;

      print("error:$obj");
      print(obj.runtimeType);
      //AppConstant.toastMessage("Internal Server Error");
    });
  }

  void callApiForAcceptorder(
      String id,
      String orderId,
      String? vendorName,
      String? vendorAddress,
      String distance,
      String? vendorLat,
      String? vendorLang,
      String? userLat,
      String? userLang,
      String? userAddress,
      String? vendorImage,
      String? userName) {
    print(id);
    showSpinner = true;
    notifyListeners();
    RestClient(ApiHeader().dioData())
        .orderstatuschange1(id, "ACCEPT")
        .then((response) {
      print("order_response:$response");

      final body = json.decode(response!);
      bool? sucess = body['success'];
      // bool sucess =response.success;
      if (sucess = true) {
        showSpinner = false;

        var msg = "Order Accepted";
        Constants.createSnackBar(msg, context, Color(Constants.greentext));

        PreferenceUtils.setString(Constants.previosOrderStatus, "ACCEPT");
        PreferenceUtils.setString(Constants.previosOrderId, id);
        PreferenceUtils.setString(Constants.previosOrderOrderid, orderId);
        PreferenceUtils.setString(
            Constants.previosOrderVendorName, vendorName!);
        PreferenceUtils.setString(
            Constants.previosOrderVendorAddress, vendorAddress!);
        PreferenceUtils.setString(Constants.previosOrderDistance, distance);
        PreferenceUtils.setString(Constants.previosOrderVendorLat, vendorLat!);
        PreferenceUtils.setString(
            Constants.previosOrderVendorLang, vendorLang!);
        PreferenceUtils.setString(Constants.previosOrderUserLat, userLat!);
        PreferenceUtils.setString(Constants.previosOrderUserLang, userLang!);
        PreferenceUtils.setString(
            Constants.previosOrderUserAddress, userAddress!);
        PreferenceUtils.setString(
            Constants.previosOrderVendorImage, vendorImage!);
        PreferenceUtils.setString(Constants.previosOrderUserName, userName!);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GetOrderKitchen()));
      } else if (sucess == false) {
        showSpinner = false;

        var msg = Languages.of(context)!.tryagainlable;
        // print(msg);
        Constants.createSnackBar(msg, context, Color(Constants.redtext));
      }
      notifyListeners();
    }).catchError((Object obj) {
      final snackBar = SnackBar(
        content: Text(Languages.of(context)!.servererrorlable),
        backgroundColor: Color(Constants.redtext),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      showSpinner = false;
      notifyListeners();

      print("error:$obj");
      print(obj.runtimeType);
      //AppConstant.toastMessage("Internal Server Error");
    });
  }

  void OpenCancelBottomSheet(String id, BuildContext context) {
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
                          itemCount: can_reason.length,
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
                                      can_reason[position],
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
                                      value: can_reason[position],
                                      groupValue: cancelReason,
                                      onChanged: (value) {
                                        setState(() {
                                          cancelReason = value;

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
                              controller: text_cancelReason_controller,
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
                          print("RadioValue:$cancelReason");

                          if (cancelReason == "0") {
                            Constants.toastMessage(
                                Languages.of(context)!.selectcancelreasonlable);

                            // Constants.createSnackBar("Select Cancel Reason", context, Color(Constants.redtext));
                          } else if (cancelReason ==
                              Languages.of(context)!.otherreasonlable) {
                            if (text_cancelReason_controller.text.length == 0) {
                              Constants.toastMessage(
                                  Languages.of(context)!.addreasonlable);
                              // Constants.createSnackBar("Add Reason", context, Color(Constants.redtext));
                            } else {
                              cancelReason = text_cancelReason_controller.text;
                            }
                          } else {
                            Constants.checkNetwork().whenComplete(
                                () => callApiForCacelorder(id, cancelReason));
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
