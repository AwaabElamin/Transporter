import 'dart:async';

import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:flutter/material.dart';
import 'package:alnaqel_seller/config/Palette.dart';

class CashBalance extends StatefulWidget {
  @override
  _CashBalanceState createState() => _CashBalanceState();
}

class _CashBalanceState extends State<CashBalance> {
  final TextEditingController _textController = TextEditingController();
  late ScrollController _scrollController;

  static const Duration _duration = Duration(seconds: 1);
  Timer _timer = Timer(_duration, () {});
  String _lastSearchTerm = '';

  void _search() {
    if (this._timer.isActive) this._timer.cancel();
    this._timer = Timer(_duration, () {
      // Only fetch new data if input has changed from last request.
      if (this._lastSearchTerm != this._textController.text) {
        setState(() {
          this._scrollController.jumpTo(0);
          this._lastSearchTerm = this._textController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'))),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            "Total Balance",
                            style: TextStyle(
                                color: Palette.switchs,
                                fontFamily: "ProximaNova",
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005,
                          ),
                          Text(
                            "\u00241059.99",
                            style: TextStyle(
                                color: Palette.green,
                                fontFamily: "ProximaNova",
                                fontSize: 26),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: TextField(
                              style: TextStyle(
                                  height: 1, color: Colors.black, fontSize: 18),
                              controller: this._textController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),

                                fillColor: Palette.divider,
                                filled: true,
                                hintText: getTranslated(context, 'search_hint'),
                                hintStyle: TextStyle(
                                    color: Palette.bonjour,
                                    fontSize: 14,
                                    fontFamily: "ProximaNova"),
                                suffixIcon:
                                    Icon(Icons.search, color: Palette.bonjour),
                                // suffixIcon: IconButton(
                                //   onPressed: () => this._clearSearch(),
                                //   icon: Icon(Icons.clear, color: Palette.bonjour),
                                // ),
                              ),
                              onChanged: (_) => this._search(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
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
                            "#546VSD32DSF65Q",
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "+\u002437",
                        style: TextStyle(
                            color: Palette.green,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Aalfred Sanaderson",
                    style: TextStyle(
                        color: Palette.switchs,
                        fontFamily: "ProximaBold",
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Saturday",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "December 12,2020",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 15,
                  endIndent: 25,
                  color: Palette.profliedivider,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
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
                            "#546VSD32DSF65Q",
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "+\u0024205",
                        style: TextStyle(
                            color: Palette.green,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Mike Sellconins",
                    style: TextStyle(
                        color: Palette.switchs,
                        fontFamily: "ProximaBold",
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Saturday",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "December 12,2020",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 15,
                  endIndent: 25,
                  color: Palette.profliedivider,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
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
                            "#546VSD32DSF65Q",
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "+\u0024300",
                        style: TextStyle(
                            color: Palette.green,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Mike Stenley",
                    style: TextStyle(
                        color: Palette.switchs,
                        fontFamily: "ProximaBold",
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Saturday",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "December 12,2020",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 15,
                  endIndent: 25,
                  color: Palette.profliedivider,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
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
                            "#546VSD32DSF65Q",
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "+\u0024428",
                        style: TextStyle(
                            color: Palette.green,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Sylevaster Smith",
                    style: TextStyle(
                        color: Palette.switchs,
                        fontFamily: "ProximaBold",
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Saturday",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "December 12,2020",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 15,
                  endIndent: 25,
                  color: Palette.profliedivider,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "BKID: ",
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaBold",
                                fontSize: 16),
                          ),
                          Text(
                            "00123764761279",
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "-\u0024599",
                        style: TextStyle(
                            color: Palette.removeacct,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Saturday",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "December 12,2020",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 15,
                  endIndent: 25,
                  color: Palette.profliedivider,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
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
                            "#546VSD32DSF65Q",
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "+\u0024109",
                        style: TextStyle(
                            color: Palette.green,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Kevin Petrik",
                    style: TextStyle(
                        color: Palette.switchs,
                        fontFamily: "ProximaBold",
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Saturday",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "December 12,2020",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 15,
                  endIndent: 25,
                  color: Palette.profliedivider,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "BKID: ",
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaBold",
                                fontSize: 16),
                          ),
                          Text(
                            "00123764761279",
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaBold",
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "-\u0024599",
                        style: TextStyle(
                            color: Palette.removeacct,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Saturday",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                      Text(
                        "December 12,2020",
                        style: TextStyle(
                            color: Palette.switchs,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
