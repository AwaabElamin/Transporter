import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alnaqel_driver/apiservice/ApiHeader.dart';
import 'package:alnaqel_driver/apiservice/Apiservice.dart';
import 'package:alnaqel_driver/localization/language/languages.dart';
import 'package:alnaqel_driver/screen/myprofilescreen.dart';
import 'package:alnaqel_driver/screen/notificationlist.dart';
import 'package:alnaqel_driver/screen/orderlistscreen.dart';
import 'package:alnaqel_driver/util/constants.dart';
import 'package:alnaqel_driver/util/preferenceutils.dart';

class HomeScreen extends StatefulWidget {
  int initalindex;

  HomeScreen(this.initalindex);

  @override
  _HomeScreen createState() => new _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String name = "User";

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    setState(() {
      Constants.checkNetwork().whenComplete(() => callApiForsetting());
    });
  }

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/background_image.png'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          // resizeToAvoidBottomPadding: true,
          key: _drawerscaffoldkey,
          bottomNavigationBar: BottomBar(widget.initalindex),
        ),
      )),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(Languages.of(context)!.areyousurelable),
        content: new Text(Languages.of(context)!.wanttoexitlable),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text(Languages.of(context)!.nolable),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text(Languages.of(context)!.yeslable),
          ),
        ],
      ),
    ).then((value) => value as bool);
  }

  void callApiForsetting() {
    RestClient(ApiHeader().dioData()).driversetting().then((response) {
      if (response.success == true) {
        
        print("Setting true");

        if (response.data!.zoner == "true") {
          setState(() {
            PreferenceUtils.putBool(Constants.isZonerDriver, true);
          });
        }

        if (response.data!.globalDriver == "true") {
          setState(() {
            PreferenceUtils.putBool(Constants.isGlobalDriver, true);
          });
        }

        PreferenceUtils.setString(
            Constants.driversetvehicaltype, response.data!.driverVehicalType!);
        PreferenceUtils.setString(Constants.isDriverAcceptMultipleorder,
            response.data!.isDriverAcceptMultipleorder.toString());

        response.data!.driverAcceptMultipleOrdercount != null
            ? PreferenceUtils.setString(
                Constants.driverAcceptMultipleOrdercount,
                response.data!.driverAcceptMultipleOrdercount.toString())
            : PreferenceUtils.setString(
                Constants.driverAcceptMultipleOrdercount, '');

        response.data!.driverAutoRefrese != null
            ? PreferenceUtils.setString(Constants.driverAutoRefrese,
                response.data!.driverAutoRefrese.toString())
            : PreferenceUtils.setString(Constants.driverAutoRefrese, '');

        response.data!.driverAppId != null
            ? PreferenceUtils.setString(
                Constants.oneSignalAppId, response.data!.driverAppId.toString())
            : PreferenceUtils.setString(Constants.oneSignalAppId, '');

        response.data!.cancelReason != null
            ? PreferenceUtils.setString(
                Constants.cancelReason, response.data!.cancelReason.toString())
            : PreferenceUtils.setString(Constants.cancelReason, '');

        print(PreferenceUtils.getString(Constants.isDriverAcceptMultipleorder));
        print(PreferenceUtils.getString(Constants.driversetvehicaltype));
        print("Vehicletype:${response.data!.driverVehicalType}");
      } else {}
    }).catchError((Object obj) {
      // pr.hide();
      print("error:$obj.");
      print(obj.runtimeType);

      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response!;
          print(res);

          var responsecode = res.statusCode;
          // print(responsecode);

          if (responsecode == 401) {
            print(responsecode);
            print(res.statusMessage);
          } else if (responsecode == 422) {
            print("code:$responsecode");
          }

          break;
        default:
      }
    });
  }
}

class BottomBar extends StatefulWidget {
  int _currentIndex;

  BottomBar(this._currentIndex);

  @override
  State<StatefulWidget> createState() {
    return BottomBar1();
  }
}

class BottomBar1 extends State<BottomBar> {
  final List<Widget> _children = [
    OrderList(),
    NotificationList(),
    MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
 
    return new DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: new Scaffold(
        body: _children[widget._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(
              color: Colors.green, fontSize: 12, fontFamily: Constants.appFont),
          unselectedLabelStyle: TextStyle(
              color: Colors.white, fontSize: 12, fontFamily: Constants.appFont),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(Constants.itembgcolor),
          currentIndex: widget._currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset("images/order.svg"),
                activeIcon: SvgPicture.asset("images/order_green.svg"),
                label: Languages.of(context)!.orderslable),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("images/notification.svg"),
                activeIcon: SvgPicture.asset("images/notification_green.svg"),
                label: Languages.of(context)!.notificationlable),
            BottomNavigationBarItem(
                icon: Image.asset("images/profile.png"),
                activeIcon: Image.asset("images/profile_green.png"),
                label: Languages.of(context)!.profilelable)
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      widget._currentIndex = index;
    });
  }
}
