import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/models/earning_history_response.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:alnaqel_seller/utilities/device_utils.dart';
import 'package:alnaqel_seller/utilities/prefConstatnt.dart';
import 'package:alnaqel_seller/utilities/preference.dart';
import 'package:sizer/sizer.dart';

/*String _chosenValue = 'Yearly';
String _showValue = 'Yearly';*/

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

bool showAvg = false;

class EarningHistoryScreen extends StatefulWidget {
  @override
  _EarningHistoryScreenState createState() => _EarningHistoryScreenState();
}

class _EarningHistoryScreenState extends State<EarningHistoryScreen> {
  Future? earningHistoryFuture;

  @override
  void initState() {
    earningHistoryFuture = getEarningHistory();
    super.initState();
  }

  Future<void> _refreshEarningHistory() async {
    setState(() {
      earningHistoryFuture = getEarningHistory();
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
          getTranslated(context, earning_history)!,
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
        child: RefreshIndicator(
          onRefresh: _refreshEarningHistory,
          child: FutureBuilder<BaseModel<EarningHistoryResponse>>(
            future: earningHistoryFuture!
                .then((value) => value as BaseModel<EarningHistoryResponse>),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return DeviceUtils.showProgress(true);
              } else {
                var data = snapshot.data!.data;
                if (data != null) {
                  Map<String, dynamic> jsonEarningData =
                      jsonDecode(data.data!.orderChart!);
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated(context, total_balance)!,
                                    style: TextStyle(
                                        color: Palette.switchs,
                                        fontFamily: "ProximaNova",
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${data.data!.totalBalance} sdg",
                                    style: TextStyle(
                                        color: Palette.green,
                                        fontFamily: "ProximaNova",
                                        fontSize: 26),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${data.data!.todayEarning.toString()}${SharedPreferenceHelper.getString(Preferences.currency_symbol)}",
                                        style: TextStyle(
                                            color: Palette.loginhead,
                                            fontFamily: "ProximaThin",
                                            fontSize: 25),
                                      ),
                                      Text(
                                        '${getTranslated(context, '$today')} ${getTranslated(context, '$earnings')}',
                                        style: TextStyle(
                                            color: Palette.loginhead,
                                            fontFamily: "ProximaThin",
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${data.data!.weeklyEarning.toString()}${SharedPreferenceHelper.getString(Preferences.currency_symbol)}",
                                        style: TextStyle(
                                            color: Palette.loginhead,
                                            fontFamily: "ProximaThin",
                                            fontSize: 25),
                                      ),
                                      Text(
                                        '${getTranslated(context, '$weekly')} ${getTranslated(context, '$earnings')}',
                                        style: TextStyle(
                                            color: Palette.loginhead,
                                            fontFamily: "ProximaThin",
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${data.data!.todayEarning.toString()}${SharedPreferenceHelper.getString(Preferences.currency_symbol)}",
                                        style: TextStyle(
                                            color: Palette.loginhead,
                                            fontFamily: "ProximaThin",
                                            fontSize: 25),
                                      ),
                                      Text(
                                        '${getTranslated(context, '$monthly')} ${getTranslated(context, '$earnings')}',
                                        style: TextStyle(
                                            color: Palette.loginhead,
                                            fontFamily: "ProximaThin",
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${data.data!.yearlyEarning.toString()}${SharedPreferenceHelper.getString(Preferences.currency_symbol)}",
                                        style: TextStyle(
                                            color: Palette.loginhead,
                                            fontFamily: "ProximaThin",
                                            fontSize: 25),
                                      ),
                                      Text(
                                        '${getTranslated(context, '$yearly')} ${getTranslated(context, '$earnings')}',
                                        style: TextStyle(
                                            color: Palette.loginhead,
                                            fontFamily: "ProximaThin",
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    /*BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                ),*/
                                  ],
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                getTranslated(
                                                    context, earnings)!,
                                                style: TextStyle(
                                                    color: Palette.loginhead,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        /* DropdownButton<String>(
                              value: _chosenValue,
                              style: TextStyle(
                                color: Palette.loginhead, fontSize: 16),
                              items: <String>[
                                'Yearly',
                                'Monthly',
                                'Weekly',
                                'Daily',
                              ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              onChanged: (value) {
                                setState(() {
                                _chosenValue = value;
                                _showValue = value;
                                });
                              },
                            ),*/
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: 0, right: 0, top: 10),
                                      height: 35.h,
                                      width: 100.w,
                                      child: LineChart(
                                        showEarningData(jsonEarningData),
                                        swapAnimationDuration:
                                            const Duration(milliseconds: 250),
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  LineChartData showEarningData(Map<String, dynamic> jsonData) {
    List<dynamic> eData = jsonData['data'];
    List<dynamic>? lData = jsonData['label'];
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (p0, p1) {},
        handleBuiltInTouches: true,
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.white, width: 0)),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
              color: Palette.loginhead, strokeWidth: 0.5, dashArray: [10]);
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
              color: Palette.loginhead, strokeWidth: 0.5, dashArray: [10]);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 10,
          margin: 10,
          getTextStyles: (value, _) => TextStyle(
            color: Palette.loginhead,
            fontWeight: FontWeight.normal,
            fontSize: 5,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return "${lData!.first}";
              case 1:
                return "${lData![1]}";
              case 2:
                return "${lData![2]}";
              case 3:
                return "${lData![3]}";
              case 4:
                return "${lData![4]}";
              case 5:
                return "${lData![5]}";
              case 6:
                return "${lData![6]}";
              case 7:
                return "${lData![7]}";
              case 8:
                return "${lData![8]}";
              case 9:
                return "${lData![9]}";
              case 10:
                return "${lData![10]}";
              case 11:
                return "${lData![11]}";
            }
            return '';
          },
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Palette.loginhead,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '\u00241000';
              case 3:
                return '\u00242000';
              case 5:
                return '\u00243000';
              case 7:
                return '\u00244000';
              case 9:
                return '\u00245000';
              case 11:
                return '\u00246000';
            }
            return '';
          },
          reservedSize: 30,
          margin: 10,
        ),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, eData.first.toDouble() / 1000),
            FlSpot(1, eData[1].toDouble() / 1000),
            FlSpot(2, eData[2].toDouble() / 1000),
            FlSpot(3, eData[3].toDouble() / 1000),
            FlSpot(4, eData[4].toDouble() / 1000),
            FlSpot(5, eData[5].toDouble() / 1000),
            FlSpot(6, eData[6].toDouble() / 1000),
            FlSpot(7, eData[7].toDouble() / 1000),
            FlSpot(8, eData[8].toDouble() / 1000),
            FlSpot(9, eData[9].toDouble() / 1000),
            FlSpot(10, eData[10].toDouble() / 1000),
            FlSpot(11, eData[11].toDouble() / 1000),
          ],
          isCurved: true,
          barWidth: 1,
          colors: [Palette.loginhead, Palette.green],
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
