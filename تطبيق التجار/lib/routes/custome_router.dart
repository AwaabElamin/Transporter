import 'package:flutter/material.dart';
import 'package:alnaqel_seller/routes/route_names.dart';
import 'package:alnaqel_seller/screens/MainScreen.dart';
import 'package:alnaqel_seller/screens/auth/LoginScreen.dart';
import 'package:alnaqel_seller/screens/auth/RegisterScreen.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MainScreen());
      // case photosRoute:
      //Albums? albums = routeSettings.arguments as Albums;
      // return MaterialPageRoute(builder: (_) => photosScreen(albums: albums));
    }
    return MaterialPageRoute(builder: (_) => LoginScreen());
  }
}
