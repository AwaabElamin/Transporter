import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Constants {
  static final String androidKey = 'ENTER_YOUR_GOOGLE_ANDROID_KEY';
  static final String iosKey = 'ENTER_YOUR_GOOGLE_iOS_KEY';

  static int colorBlack = 0xFF090E21;
  static int colorGray = 0xFF999999;
  static int colorLike = 0xFFff6060;
  static int colorTheme = 0xFF06C168;
  static int colorThemeOp = 0xFF9BE6C2;
  static int colorBackgroud = 0xFFFAFAFA;
  static int colorBlue = 0xFF1492e6;
  static int colorScreenBackgroud = 0xFFf2f2f2;
  static int colorHint = 0xFF999999;

  static int lightBlack = 0xFF213741;
  static int itembgcolor = 0xFF213741;
  static int bgcolor = 0xFF132229;
  static int greaytext = 0xFF999999;
  static int whitetext = 0xFFffffff;
  static int greentext = 0xFF06C168;
  static int dashline = 0xFFcccccc;
  static int redtext = 0xFFff6060;
  static final String driverfirstname = "driverfirstname";
  static final String driverlastname = "driverlastname";
  static final String driverid = "driverid";
  static final String headertoken = "headertoken";
  static final String driveremail = "driveremail";
  static final String driverphone = "driverphone";
  static final String driverotp = "driverotp";
  static final String driverphonecode = "driverphonecode";
  static final String driverimage = "driverimage";
  static final String imagePath = "imagePath";
  static final String isLoggedIn = "isLoggedIn";
  static final String isonline = "isonline";
  static final String isverified = "isverified";
  static final String drivervehicletype = "drivervehicletype";
  static final String drivervehiclenumber = "drivervehiclenumber";
  static final String driverlicencenumber = "driverlicencenumber";
  static final String drivernationalidentity = "drivernationalidentity";
  static final String driverlicencedoc = "driverlicencedoc";
  static final String driverdeliveryzoneid = "driverdeliveryzoneid";
  static final String drivernotification = "drivernotification";
  static final String driverzone = "driverzone";
  static final String driverdevicetoken = "driverdevicetoken";

  /*Setting data*/

  static final String driversetvehicaltype = "driversetvehicaltype";
  static final String isDriverAcceptMultipleorder =
      "isDriverAcceptMultipleorder";
  static final String driverAcceptMultipleOrdercount =
      "driverAcceptMultipleOrdercount";
  static final String driverAutoRefrese = "driverAutoRefrese";
  static final String cancelReason = "cancelReason";
  static final String oneSignalAppId = "oneSignalAppId";
  static final String languagecode = "languagecode";

  /*Lat Long*/

  static final String previosOrderStatus = "previosOrderStatus";
  static final String previosOrderOrderid = "previosOrderOrderid";
  static final String previosOrderId = "previosOrderId";
  static final String previosOrderVendorName = "previosOrderVendorName";
  static final String previosOrderVendorAddress = "previosOrderVendorAddress";
  static final String previosOrderDistance = "previosOrderDistance";
  static final String previosOrderVendorLat = "previosOrderVendorLat";
  static final String previosOrderVendorLang = "previosOrderVendorLang";
  static final String previosOrderVendorImage = "previosOrderVendorImage";
  static final String previosOrderUserLat = "previosOrderUserLat";
  static final String previosOrderUserLang = "previosOrderUserLang";
  static final String previosOrderUserAddress = "previosOrderUserAddress";
  static final String previosOrderUserName = "previosOrderUserName";

  /*Chekc driver is golobaldriver or not*/
  static final String isGlobalDriver = 'isGlobalDriver';
  static final String isZonerDriver = 'isZonerDriver';
  static final String notZonerDriverSlogan =
      'لا يمكنك تغيير النطاق يدوياً حتى يتم التأكد من أنك تحتاج إلى تغيير النطاق';
  static final String notGlobalDriverSlogan =
      'هذا السائق لا يمكنه تغير النطاق بشكل تلقائي';
  // static final String baseUrl =
  //     'baseUrl';

  /*Lat Long*/

  static double currentlat = 0;
  static double currentlong = 0;
  static String currentaddress = "0";

  static String appFont = 'Proxima';
  static String appFontBold = 'ProximaBold';

  static Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      Constants.toastMessage("No Internet Connection");
      return false;
    }
  }

  static var kAppLableWidget = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
      color: Colors.white,
      fontFamily: Constants.appFontBold);

  static var kTextFieldInputDecoration = InputDecoration(
      hintStyle: TextStyle(color: Color(Constants.colorHint)),
      border: InputBorder.none,
      errorStyle:
          TextStyle(fontFamily: Constants.appFontBold, color: Colors.red));

  static var kTextFieldInputDecoration1 = InputDecoration(
      hintStyle: TextStyle(color: Color(Constants.colorHint)),
      border: InputBorder.none,
      suffixIcon: Image.asset("images/search.png", width: 20, height: 20),
      errorStyle:
          TextStyle(fontFamily: Constants.appFontBold, color: Colors.red));

  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static String? kvalidateFullName(String? value) {
    if (value!.length == 0) {
      return 'Data is Required';
    } else
      return null;
  }

  static String? kvalidateFirstName(String? value) {
    if (value!.length == 0) {
      return 'First Name is Required';
    } else
      return null;
  }

  static String? kvalidatelastName(String? value) {
    if (value!.length == 0) {
      return 'Last Name is Required';
    } else
      return null;
  }

  static String? kvalidateCotactNum(String? value) {
    if (value!.length == 0) {
      return 'Contact Number is Required';
    } else
      return null;
  }

  static String? kvalidatePassword(String? value) {
    Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    RegExp regex = new RegExp(pattern as String);

    if (value!.length == 0) {
      return "Password is Required";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else if (!regex.hasMatch(value))
      return 'Password required';
    else
      return null;
  }

  static String? kvalidateConfPassword(
      String? value,
      TextEditingController textPassword,
      TextEditingController textConfPassword) {
    Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    RegExp regex = new RegExp(pattern as String);
    if (value!.length == 0) {
      return "Password is Required";
    } else if (textPassword.text != textConfPassword.text)
      return 'Password and Confirm Password does not match.';
    else if (!regex.hasMatch(value))
      return 'Password required';
    else
      return null;
  }

  static String? kvalidateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    if (value!.length == 0) {
      return "Email is Required";
    } else if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  static void createSnackBar(
      String message, BuildContext scaffoldContext, Color color) {
    final snackBar = new SnackBar(
        content: new Text(
          message,
          style: TextStyle(
              color: Color(whitetext), fontFamily: appFont, fontSize: 16),
        ),
        backgroundColor: color);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    //Scaffold.of(scaffoldContext).showSnackBar(snackBar);
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
  }

  static Future<String> cuttentlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places.isNotEmpty) {
      final Placemark place = places.first;
      print(place.locality);
      print(place.thoroughfare);
      final currentAddress = place.thoroughfare! + "," + place.locality!;

      Constants.currentlong = position.longitude;
      Constants.currentlat = position.latitude;
      Constants.currentaddress = currentAddress;

      return currentAddress;
    }
    return "No address available";
  }

  static Future<LatLng?> currentlatlong() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places.isNotEmpty) {
      Constants.currentlong = position.longitude;
      Constants.currentlat = position.latitude;
      return LatLng(position.latitude, position.longitude);
    }
    return null;
  }
}
