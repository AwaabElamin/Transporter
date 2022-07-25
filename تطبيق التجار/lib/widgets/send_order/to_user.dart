import 'package:alnaqel_seller/models/cart_item.dart';
import 'package:alnaqel_seller/widgets/send_order/pages/select_payment.dart';
import 'package:alnaqel_seller/widgets/send_order/pages/select_products.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'nav_obs.dart';
import 'pages/select_address.dart';
import 'pages/select_user.dart';

VoidCallback exitUserSheet = () {};

class SendToUser extends StatefulWidget {
  final BuildContext navContext;
  const SendToUser({Key? key, required this.navContext}) : super(key: key);

  @override
  State<SendToUser> createState() => _SendToUserState();
}

class _SendToUserState extends State<SendToUser> {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    exitUserSheet = () {
      Navigator.of(widget.navContext).pop();
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderingCart>(
      create: (_) => OrderingCart(),
      builder: (context, child) => child!,
      child: NestedNavigator(
        navigationKey: navigationKey,
        initialRoute: SelectProductsPage.path,
        routes: {
          // default rout as '/' is necessary!
          SelectProductsPage.path: (context) => SelectProductsPage(
                navigationKey: navigationKey,
                isToStorage: false,
              ),
          SelectUserPage.path: (context) => SelectUserPage(),
          SelectAddressPage.path: (_) => SelectAddressPage(),
          SelectPayment.path: (_) => SelectPayment(),
        },
      ),
    );
  }
}

class NestedNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigationKey;
  final String initialRoute;
  final Map<String, WidgetBuilder> routes;

  NestedNavigator({
    required this.navigationKey,
    required this.initialRoute,
    required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Navigator(
        observers: [NavigatorHistory()],
        key: navigationKey,
        initialRoute: initialRoute,
        onGenerateRoute: (RouteSettings routeSettings) {
          WidgetBuilder builder = routes[routeSettings.name]!;
          return CupertinoPageRoute(
            builder: (context) => builder(context),
            settings: routeSettings,
          );
        },
      ),
      onWillPop: () {
        if (navigationKey.currentState!.canPop()) {
          navigationKey.currentState!.pop();
          return Future<bool>.value(false);
        }
        return Future<bool>.value(true);
      },
    );
  }
}
