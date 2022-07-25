import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/models/cart_item.dart';
import 'package:alnaqel_seller/utilities/device_utils.dart';
import 'package:alnaqel_seller/widgets/send_order/to_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPayment extends StatefulWidget {
  static final String path = 'select_payment';
  SelectPayment({Key? key}) : super(key: key);

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text(
                  getTranslated(context, SelectPayment.path) ?? '',
                  style: TextStyle(fontFamily: proxima_nova_bold),
                ),
                trailing: TextButton.icon(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.cyan,
                  ),
                  label: Text(
                    getTranslated(context, 'next')!,
                    style: TextStyle(
                      fontFamily: proxima_nova_bold,
                      color: Colors.cyan,
                    ),
                  ),
                  onPressed: () async {
                    var isSpecial = await showCupertinoDialog<bool>(
                      context: context,
                      builder: (ctx) {
                        return CupertinoAlertDialog(
                          title: Text(
                            getTranslated(context, 'isSpecial') ??
                                'هل هذا الطلب مميز',
                            style: TextStyle(
                              fontFamily: proxima_nova_bold,
                            ),
                          ),
                          content: Text(
                              'الطلبات المميزة تتميز بسرعة توصيلها دون غيرها بشكل خاص'),
                          actions: [
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              child: Text(
                                getTranslated(context, 'no') ?? 'لا',
                                style: TextStyle(
                                  fontFamily: proxima_nova_bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                            ),
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: Text(
                                getTranslated(context, 'yes') ?? 'نعم',
                                style: TextStyle(
                                  fontFamily: proxima_nova_bold,
                                ),
                              ),
                              onPressed: () async {
                                Navigator.of(ctx).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    Provider.of<OrderingCart>(context, listen: false).special = isSpecial??false ? 1:0;
                    var res =
                        await Provider.of<OrderingCart>(context, listen: false)
                            .createOrder();
                    try {
                      DeviceUtils.toastMessage(res.data!.data!);
                      exitUserSheet();
                    } catch (e) {
                      DeviceUtils.toastMessage(e.toString());
                    }
                  },
                ),
              )
            ];
          },
          body: Column(
            children: [paymentTypeWidget(), paymentStatusWidget()],
          )),
    );
  }

  Widget paymentTypeWidget() {
    var type =
        Provider.of<OrderingCart>(context, listen: true).getPaymentType();
    return Center(
      child: Consumer<OrderingCart>(
        builder: (context, cart, child) => child!,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('طرق الدفع'),
            RadioListTile<PaymentType>(
              value: PaymentType.cash,
              groupValue: type,
              onChanged: (PaymentType? value) {
                if (value != null)
                  Provider.of<OrderingCart>(context, listen: false)
                      .setPaymentType(value);
              },
              title: Text('كاش'),
            ),
            RadioListTile<PaymentType>(
              value: PaymentType.credit,
              groupValue: type,
              onChanged: (PaymentType? value) {
                if (value != null)
                  Provider.of<OrderingCart>(context, listen: false)
                      .setPaymentType(value);
              },
              title: Text('بنكي'),
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  Widget paymentStatusWidget() {
    var type = Provider.of<OrderingCart>(context, listen: true).getPayed();
    return Center(
      child: Consumer<OrderingCart>(
        builder: (context, cart, child) => child!,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('حالة الدفع'),
            RadioListTile<int>(
              value: 0,
              groupValue: type,
              onChanged: (int? value) {
                if (value != null)
                  Provider.of<OrderingCart>(context, listen: false)
                      .setPayed(value);
              },
              title: Text('تم الدفع'),
            ),
            RadioListTile<int>(
              value: 1,
              groupValue: type,
              onChanged: (int? value) {
                if (value != null)
                  Provider.of<OrderingCart>(context, listen: false)
                      .setPayed(value);
              },
              title: Text('لم يتم الدفع'),
            ),
          ],
        ),
      ),
    );
  }
}
