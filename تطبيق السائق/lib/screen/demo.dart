import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:alnaqel_driver/util/constants.dart';
import 'package:alnaqel_driver/util/preferenceutils.dart';

class Demo extends StatefulWidget {
  @override
  _Demo createState() => _Demo();
}

class _Demo extends State<Demo> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  double heigntValue = 300;
  bool full = true;
  bool full1 = false;
  bool viAddress = true;
  int _radioValue = -1;
  String result = "0";

  String driverAddress = "Not Found";

  String? id;
  String? orderId;
  String? vendorname;
  String? vendorAddress;
  String? distance;

  Timer? timer;

  int second = 10;
  double? currentLat;
  double? currentLang;

  void handleRadioValueChange(int value) {
    if (mounted) {
      setState(() {
        _radioValue = value;

        switch (_radioValue) {
          case 0:
            result = "0";
            break;
          case 1:
            result = "1";
            break;
          case 2:
            result = "2";

            // setstripe(context,result);
            break;
          case 3:
            result = "3";
            break;
          case 4:
            result = "4";
            break;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    second = int.parse(PreferenceUtils.getString(Constants.driverAutoRefrese));
    print("Seconds:${PreferenceUtils.getString(Constants.driverAutoRefrese)}");
    print("currentlat:${Constants.currentlat}");
    print("currentlong:${Constants.currentlong}");
    if (Constants.currentlat != 0.0 && Constants.currentlong != 0.0) {
      setState(() {
        Constants.checkNetwork().whenComplete(() => timer = Timer.periodic(
            Duration(seconds: second),
            (Timer t) => postDriverLocation(
                Constants.currentlat, Constants.currentlong)));
      });
    } else {
      setState(() {
        checkforpermission();
        print("checkpermission123");
      });

      // Constants.currentlatlong().whenComplete(() => Constants.currentlatlong().then((value){print("origin123:$value");}));

    }

    PreferenceUtils.init();

    if (mounted) {
      setState(() {
        orderId = PreferenceUtils.getString(Constants.previosOrderOrderid);
        vendorname =
            PreferenceUtils.getString(Constants.previosOrderVendorName);
        vendorAddress =
            PreferenceUtils.getString(Constants.previosOrderVendorAddress);
        distance = PreferenceUtils.getString(Constants.previosOrderDistance);
      });
    }

    setState(() {
      Constants.cuttentlocation()
          .whenComplete(() => Constants.cuttentlocation().then((value) {
                driverAddress = value;
                print("driverAddress:$driverAddress");
              }));
    });
  }

  void checkforpermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("denied");
      Constants.createSnackBar(
          "Allow location", context, Color(Constants.redtext));
    } else if (permission == LocationPermission.whileInUse) {
      print("whileInUse56362");

      Constants.currentlatlong()
          .whenComplete(() => Constants.currentlatlong().then((value) {
                currentLat = value!.latitude;
                currentLang = value.longitude;
              }));
      Constants.checkNetwork()
          .whenComplete(() => postDriverLocation(currentLat, currentLang));
    } else if (permission == LocationPermission.always) {
      print("always3");

      Constants.currentlatlong()
          .whenComplete(() => Constants.currentlatlong().then((value) {
                print("origin123:$value");
              }));
      Constants.currentlatlong()
          .whenComplete(() => Constants.currentlatlong().then((value) {
                currentLat = value!.latitude;
                currentLang = value.longitude;
              }));
      Constants.checkNetwork()
          .whenComplete(() => postDriverLocation(currentLat, currentLang));
    }
  }

  void postDriverLocation(double? currentlat, double? currentlang) {
    print("UpdateLat:$currentlat");
    print("UpdateLang:$currentlang");
  }

  @override
  Widget build(BuildContext context) {
    /* ScreenUtil.init(context,
        designSize: Size(screenwidth, screenheight), allowFontScaling: true);
*/
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
              // resizeToAvoidBottomPadding: false,
              resizeToAvoidBottomInset: false,
              key: _scaffoldKey,
              body: new Container(
                alignment: Alignment.center,
                height: 200,
                width: 200,
                color: Colors.white,
                child: Center(
                  child: Text("update"),
                ),
              )),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return true;
  }
}
