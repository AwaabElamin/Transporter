import 'package:alnaqel_seller/models/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomStepper extends StatelessWidget {
  CustomStepper({
    required this.id,
    required this.price,
  });

  final int id;
  final double price;
  final double size = 30;
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<OrderingCart>(context, listen: true);
    CartItem item = cart.toUserCartItems.firstWhere(
      (element) => element.id == id,
      orElse: () => CartItem(
        id: -1,
        price: 0,
        qty: 0,
        packageType: PackageType.small,
      ),
    );
    if (item.id == -1) {
      return Center(
        child: RoundedIconButton(
            icon: CupertinoIcons.cart_badge_plus,
            onPress: () {
              item = CartItem(
                id: id,
                price: price,
                qty: 1,
                packageType: PackageType.small,
              );
              cart.addToUserCart(item);
            },
            iconSize: size),
      );
    } else
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedIconButton(
            icon: Icons.remove,
            iconSize: size,
            onPress: () {
              if (item.qty > 1) {
                item.qty--;

                cart.removeFromUserCart(item);
                cart.addToUserCart(item);
              } else {
                cart.removeFromUserCart(item);
              }
            },
          ),
          Text(
            '${item.qty}',
            style: TextStyle(
              fontSize: size * 0.8,
            ),
            textAlign: TextAlign.center,
          ),
          RoundedIconButton(
            icon: Icons.add,
            iconSize: size,
            onPress: () {
              item.qty++;
              cart.removeFromUserCart(item);
              cart.addToUserCart(item);
            },
          ),
        ],
      );
  }
}

class PackageRadios extends StatelessWidget {
  PackageRadios({
    required this.id,
  });

  final int id;
  final double size = 30;
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<OrderingCart>(context, listen: true);
    if (!cart.getUserCartItems().contains(
        CartItem(id: id, price: 0, qty: 0, packageType: PackageType.small))) {
      return Container();
    } else {
      return Column(
        children: [
          RadioListTile<PackageType>(
            value: PackageType.small,
            groupValue: cart
                .getUserCartItems()
                .firstWhere(
                  (element) => element.id == id,
                  orElse: () => CartItem(
                      id: -1, price: 0, qty: 0, packageType: PackageType.small),
                )
                .packageType,
            onChanged: (value) {
              if (value != null) cart.changePackage(id, value);
            },
            title: Text('باكج صغير'),
          ),
          RadioListTile<PackageType>(
            value: PackageType.medium,
            groupValue: cart
                .getUserCartItems()
                .firstWhere(
                  (element) => element.id == id,
                  orElse: () => CartItem(
                      id: -1,
                      price: 0,
                      qty: 0,
                      packageType: PackageType.medium),
                )
                .packageType,
            onChanged: (value) {
             
              if (value != null) cart.changePackage(id, value);
            },
            title: Text('باكج متوسط'),
          ),
          RadioListTile<PackageType>(
            value: PackageType.large,
            groupValue: cart
                .getUserCartItems()
                .firstWhere(
                  (element) => element.id == id,
                  orElse: () => CartItem(
                      id: -1, price: 0, qty: 0, packageType: PackageType.large),
                )
                .packageType,
            onChanged: (value) {
            
              if (value != null) cart.changePackage(id, value);
            },
            title: Text('باكج كبير'),
          ),
        ],
      );
    }
  }
}

class RoundedIconButton extends StatelessWidget {
  RoundedIconButton(
      {required this.icon, required this.onPress, required this.iconSize});

  final IconData icon;
  final VoidCallback onPress;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(
          width: iconSize * 1.5, height: iconSize * 1.5),
      elevation: 6.0,
      onPressed: onPress,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(iconSize * 0.2)),
      fillColor: Color(0xFF65A34A),
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize * 0.8,
      ),
    );
  }
}
