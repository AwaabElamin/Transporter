import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/utilities/device_utils.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/models/my_cash_balance_response.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:sizer/sizer.dart';

class CashBalanceScreen extends StatefulWidget {
  @override
  _CashBalanceScreenState createState() => _CashBalanceScreenState();
}

List<Balance>? dataList = [];
List<Balance> _searchResult = [];
TextEditingController searchController = new TextEditingController();
int totalBalance = 0;

class _CashBalanceScreenState extends State<CashBalanceScreen> {
  Future? cashBalanceFuture;

  @override
  void initState() {
    cashBalanceFuture = getCashBalance();
    super.initState();
  }

  Future<void> _refreshDataBalance() async {
    setState(() {
      cashBalanceFuture = getCashBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          getTranslated(context, my_cash_balance)!,
          style: TextStyle(
              fontFamily: "ProximaBold",
              color: Palette.loginhead,
              fontSize: 17),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace_outlined,
              color: Colors.black,
              size: 35.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      getTranslated(context, total_balance)!,
                      style: TextStyle(
                          color: Palette.switchs,
                          fontFamily: proxima_nova_reg,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$totalBalance sdg",
                      style: TextStyle(
                          color: Palette.green,
                          fontFamily: proxima_nova_reg,
                          fontSize: 26),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(50),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        controller: searchController,
                        onChanged: onSearchTextChanged,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          fillColor: Palette.divider.withAlpha(50),
                          filled: true,
                          hintText: getTranslated(context, 'search_hint'),
                          hintStyle: TextStyle(
                              color: Palette.bonjour,
                              fontSize: 14,
                              fontFamily: proxima_nova_reg),
                          suffixIcon:
                              Icon(Icons.search, color: Palette.bonjour),
                          // suffixIcon: IconButton(
                          //   onPressed: () => this._clearSearch(),
                          //   icon: Icon(Icons.clear, color: Palette.bonjour),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: FutureBuilder<BaseModel<MyCashBalanceResponse>>(
                  future: cashBalanceFuture!.then(
                      (value) => value as BaseModel<MyCashBalanceResponse>),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return DeviceUtils.showProgress(true);
                    } else {
                      var data = snapshot.data!.data;
                      dataList = snapshot.data!.data!.data!.balance;
                      snapshot.data!.data!.data!.totalBalance != null
                          ? totalBalance =
                              snapshot.data!.data!.data!.totalBalance!
                          : totalBalance = 0;
                      if (data != null) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 100.h,
                          width: 100.w,
                          child: Flexible(
                              child: RefreshIndicator(
                                  onRefresh: _refreshDataBalance,
                                  child: getDataList(context))),
                        );
                      } else {
                        return Container();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    dataList!.forEach((oderListDetail) {
      if (oderListDetail.name!.contains(text) ||
          oderListDetail.orderId!.contains(text))
        _searchResult.add(oderListDetail);
    });

    setState(() {});
  }

  getDataList(BuildContext context) {
    return _searchResult.length != 0 || searchController.text.isNotEmpty
        ? _searchResult.length != 0
            ? ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.grey,
                ),
                itemCount: _searchResult.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "OID: ",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaBold",
                                    fontSize: 16),
                              ),
                              Text(
                                _searchResult[index].orderId!,
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaBold",
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            "\u0024${_searchResult[index].amount}",
                            style: TextStyle(
                                color: Palette.green,
                                fontFamily: "ProximaNova",
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        _searchResult[index].name!,
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaBold",
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            _searchResult[index].date!,
                            style: TextStyle(
                                color: Palette.switchs,
                                fontFamily: "ProximaNova",
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            : Center(
                child: Container(
                    child: Text(getTranslated(context, 'no_data_desc') ?? '')))
        : dataList!.length != 0
            ? ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.grey,
                ),
                itemCount: dataList!.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "OID: ",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaBold",
                                    fontSize: 16),
                              ),
                              Text(
                                dataList![index].orderId!,
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaBold",
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            "\u0024${dataList![index].amount}",
                            style: TextStyle(
                                color: Palette.green,
                                fontFamily: "ProximaNova",
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        dataList![index].name!,
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaBold",
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            dataList![index].date!,
                            style: TextStyle(
                                color: Palette.switchs,
                                fontFamily: "ProximaNova",
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            : Container(
                alignment: Alignment.center,
                child: Text(getTranslated(context, 'no_data_desc') ?? ''));
  }
}
