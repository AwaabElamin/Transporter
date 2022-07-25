import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/screens/insight/InsightScreen.dart';
import 'package:alnaqel_seller/screens/orders/HomeScreen.dart';
import 'package:alnaqel_seller/screens/product/ProductScreen.dart';
import 'package:alnaqel_seller/screens/profile/ProfileScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    navigateTo(_currentIndex);
    List<Widget> _fragments = [
      HomeScreen(),
      InsightScreen(),
      ProductScreen(),
      ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: () async => customPop(context),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _fragments[_currentIndex],
          bottomNavigationBar: BottomAppBar(
            color: Palette.loginhead,
            child: SizedBox(
              height: 60,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          _currentIndex = 0;
                          navigateTo(_currentIndex);
                        },
                        child: _currentIndex == 0
                            ? bottomIcon(Palette.green, "bag.svg",
                                getTranslated(context, orders)!)
                            : bottomIcon(Colors.white, "bag.svg",
                                getTranslated(context, orders)!)),
                    InkWell(
                        onTap: () {
                          _currentIndex = 1;
                          navigateTo(_currentIndex);
                        },
                        child: _currentIndex == 1
                            ? bottomIcon(Palette.green, "chart.svg",
                                getTranslated(context, insight)!)
                            : bottomIcon(Colors.white, "chart.svg",
                                getTranslated(context, insight)!)),
                    InkWell(
                        onTap: () {
                          _currentIndex = 2;
                          navigateTo(_currentIndex);
                        },
                        child: _currentIndex == 2
                            ? bottomIcon(Palette.green, "leaf.svg",
                                getTranslated(context, product)!)
                            : bottomIcon(Colors.white, "leaf.svg",
                                getTranslated(context, product)!)),
                    InkWell(
                        onTap: () {
                          _currentIndex = 3;
                          navigateTo(_currentIndex);
                        },
                        child: _currentIndex == 3
                            ? bottomIcon(Palette.green, "profile.svg",
                                getTranslated(context, profile)!)
                            : bottomIcon(Colors.white, "profile.svg",
                                getTranslated(context, profile)!)),
                  ]),
            ),
          )),
    );
  }

  Column bottomIcon(Color color, String icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/$icon',
          color: color,
          height: 25,
          width: 25,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(color: color, fontSize: 12),
        )
      ],
    );
  }

  void navigateTo(int index) {
    //_backStack.add(index);
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> customPop(BuildContext context) {
    if (_currentIndex == 0) {
      return Future.value(true);
    } else {
      navigateTo(0);
      return Future.value(false);
    }
  }
}
