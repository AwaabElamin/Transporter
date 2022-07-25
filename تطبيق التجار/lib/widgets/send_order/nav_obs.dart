import 'package:flutter/cupertino.dart';

final List<Route> previousRoutesInfoList=[];
class NavigatorHistory extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      previousRoutesInfoList.remove(previousRoute);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      previousRoutesInfoList.add(previousRoute);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (previousRoute != null) {
      previousRoutesInfoList.remove(previousRoute);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      previousRoutesInfoList.remove(oldRoute);
    }
    if (newRoute != null) {
      previousRoutesInfoList.add(newRoute);
    }
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    if (previousRoute != null) {
      previousRoutesInfoList.remove(previousRoute);
    }
  }

  // @override
  // void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
  //   print("${route.settings.name} pushed");
  // }

  // @override
  // void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
  //   print("${route.settings.name} popped");
  // }

  // @override
  // void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
  //   print("${oldRoute.settings.name} is replaced by ${newRoute.settings.name}");
  // }

  // @override
  // void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
  //   print("${route.settings.name} removed");
  // }
}
