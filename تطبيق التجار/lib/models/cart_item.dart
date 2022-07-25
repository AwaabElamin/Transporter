import 'dart:convert';

import 'package:alnaqel_seller/models/common_response.dart';
import 'package:alnaqel_seller/models/user.dart';
import 'package:alnaqel_seller/models/address.dart' as Address;
import 'package:alnaqel_seller/retrofit/api_client.dart';
import 'package:alnaqel_seller/retrofit/api_header.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:alnaqel_seller/retrofit/server_error.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum PaymentType { cash, credit }
enum PackageType { small, medium,large }

class OrderingCart with ChangeNotifier, DiagnosticableTreeMixin {
  BaseModel<Users> _users = BaseModel<Users>();

  int special = 0;
  Future<BaseModel<Users>> fetchUsers() async {
    var users = await getUsers();
    _users = users;
    _tempData = users.data?.data ?? [];
    notifyListeners();
    return _users;
  }

  BaseModel<Users> showUsers() {
    return _users;
  }

  List<Data> _tempData = [];
  String _searchQuery = '';
  void usersList() {
    if (_users.data?.data == null) {
      return;
    }
    if (_searchQuery.isEmpty) {
      _tempData = _users.data!.data!;
      print('its empty');
    } else {
      print('we geting data');
      _tempData = _users.data!.data!
          .where((element) =>
              element.name!
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              element.phone!.contains(_searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchUser(String search) {
    _searchQuery = search;
    usersList();
  }

  List<Data> get tempData => _tempData;

  void setUser(Data? user) {
    _user = user;
    notifyListeners();
  }

  int _payed = 0;
  void setPayed(int payed) {
    _payed = payed;
    notifyListeners();
  }
  int getPayed() {
    return _payed;
  }
  void setPaymentType(PaymentType type) {
    _paymentType = type;
    notifyListeners();
  }

  PaymentType getPaymentType() {
    return _paymentType;
  }
  String getPaymentTypeString() {
    switch (_paymentType) {
      case PaymentType.cash:
        return "COD";
      case PaymentType.credit:
        return "Credit";
      default:
        return "N/A";
    }
      
  }


  Future<BaseModel<CommonResponse>> createOrder() async {
    CommonResponse response;
    try {
      final DateFormat formatterDate = DateFormat('y-M-d');

      final DateFormat formatterTime = DateFormat('h:m a');
      final String formattedTime = formatterTime.format(_date);
      final String formattedDate = formatterDate.format(_date);
      response = await ApiClient(ApiHeader().dioData()).createOrder(
          _user!.id!,
          formattedDate,
          formattedTime,
          getUserCartItemsTotalPrice(),
          getUserCartItemsJson(),
          'HOME',
          _address!.id!,
          '0',
          _payed,
          getPaymentTypeString(),
          special);
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<CommonResponse>> sendToStorage() async {
    CommonResponse response;
    try {
      final DateFormat formatterDate = DateFormat('y-M-d');

      final DateFormat formatterTime = DateFormat('h:m a');
      final String formattedTime = formatterTime.format(_date);
      final String formattedDate = formatterDate.format(_date);
      response = await ApiClient(ApiHeader().dioData()).createOrder(
          -1,
          formattedDate,
          formattedTime,
          getUserCartItemsTotalPrice(),
          getUserCartItemsJson(),
          'STORAGE',
          null,
          '0',
          
          _payed,
          getPaymentTypeString(),
          special);
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Data? getUser() {
    return _user;
  }

  Data? _user;

  PaymentType _paymentType = PaymentType.cash;

  DateTime _date = DateTime.now();

  void setAddress(Address.Data? address) {
    _address = address;
    notifyListeners();
  }

  Address.Data? getAddress() {
    return _address;
  }

  Address.Data? _address;
  final List<CartItem> toUserCartItems = [];
  addToUserCart(CartItem cartItem) {
    toUserCartItems.add(cartItem);
    notifyListeners();
  }
  changePackage(int id ,PackageType type) {
    toUserCartItems.forEach((element) {
      if (element.id == id) {
        element.packageType = type;
      }
    });
    // toUserCartItems.add(cartItem);
    notifyListeners();
  }

  removeFromUserCart(CartItem cartItem) {
    toUserCartItems.remove(cartItem);
    notifyListeners();
  }

  clearUserCart() {
    toUserCartItems.clear();
    notifyListeners();
  }

  List<CartItem> getUserCartItems() {
    return toUserCartItems;
  }

  int getUserCartItemsCount() {
    return toUserCartItems.length;
  }

  List<Map<String, dynamic>> getUserCartItemsJson() {
    List<Map<String, dynamic>> items = [];
    toUserCartItems.forEach((item) {
      items.add(item.toMap());
    });
    return items;
  }

  double getUserCartItemsTotalPrice() {
    double totalPrice = 0;
    toUserCartItems.forEach((cartItem) {
      totalPrice += cartItem.price * cartItem.qty;
    });
    return totalPrice;
  }

  int getUserCartItemsTotalQty() {
    int totalQty = 0;
    toUserCartItems.forEach((cartItem) {
      totalQty += cartItem.qty;
    });
    return totalQty;
  }
}

class CartItem {
  int id;
  double price;
  int qty;
  PackageType packageType;
  CartItem({
    required this.id,
    required this.price,
    required this.qty,
    required this.packageType,
  });

  CartItem copyWith({
    int? id,
    double? price,
    PackageType? packageType,
    int? qty,
  }) {
    return CartItem(
      id: id ?? this.id,
      packageType: packageType??this.packageType,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'qty': qty,
      'package_type': packageTypeToString(packageType),
    };
  }

  String packageTypeToString(PackageType type){
    switch (type) {
      case PackageType.small:
        return "sp";
      case PackageType.medium:
        return "mp";
      case PackageType.large:
        return "lp";
      default:
        return "N/A";
    }
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0,
      qty: map['qty']?.toInt() ?? 0,
      packageType: map['packageType']?.toString() == "sp"
          ? PackageType.small
          : map['packageType']?.toString() == "mp"
              ? PackageType.medium
              : map['packageType']?.toString() == "lp"
                  ? PackageType.large
                  : PackageType.small,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.id == id ;
  }

  @override
  int get hashCode => id.hashCode;
}
