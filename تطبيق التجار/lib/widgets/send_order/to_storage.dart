import 'package:alnaqel_seller/models/cart_item.dart';
import 'package:alnaqel_seller/widgets/send_order/to_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/select_products.dart';

VoidCallback exitStorageSheet = () {};

class SendToStorage extends StatefulWidget {
  final BuildContext navContext;
  const SendToStorage({Key? key, required this.navContext}) : super(key: key);

  @override
  State<SendToStorage> createState() => _SendToStorageState();
}

class _SendToStorageState extends State<SendToStorage> {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    exitStorageSheet = () {
      Navigator.of(widget.navContext).pop();
    };
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
                isToStorage: true,
              ),
        },
      ),
    );
  }
}
