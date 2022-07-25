import 'dart:convert';
import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/models/insights_response.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:alnaqel_seller/utilities/device_utils.dart';
import 'package:alnaqel_seller/utilities/prefConstatnt.dart';
import 'package:alnaqel_seller/utilities/preference.dart';
import 'package:sizer/sizer.dart';

/*String _chosenValue = 'Yearly';
String _showValue = 'Yearly';
String _chosenValue2 = 'Yearly';
String _showValue2 = 'Yearly';*/
List<Double> leftData = [];
List<String> bottomData = [];
String currencySymbol = '';

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class InsightScreen extends StatefulWidget {
  @override
  _InsightScreenState createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  Future? insightFuture;

  @override
  void initState() {
    super.initState();
    insightFuture = getInsights();
    currencySymbol =
        SharedPreferenceHelper.getString(Preferences.currency_symbol);
  }

  Future<void> _refreshInsight() async {
    setState(() {
      insightFuture = getInsights();
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: .3,
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/background.png',
                  ))),
          child: RefreshIndicator(
            onRefresh: _refreshInsight,
            color: Palette.green,
            child: FutureBuilder<BaseModel<InsightsResponse>>(
              future: insightFuture!
                  .then((value) => value as BaseModel<InsightsResponse>),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return DeviceUtils.showProgress(true);
                  } else {
                    var data = snapshot.data!.data;
                    if (data != null) {
                      Map<String, dynamic> jsonEarningData =
                          jsonDecode(data.data!.earningChart!);
                      Map<String, dynamic> jsonOrderData =
                          jsonDecode(data.data!.orderChart!);
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: kToolbarHeight + 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 3),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    height: 30.w,
                                    width: 27.w,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getTranslated(context, today)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getTranslated(context, orders)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Text(
                                            data.data!.todayOrder.toString(),
                                            style: TextStyle(
                                                fontFamily: "ProximaBold",
                                                color: Palette.inorder,
                                                fontSize: 20),
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
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    height: 30.w,
                                    width: 27.w,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getTranslated(context, total)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getTranslated(context, orders)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Text(
                                            data.data!.totalOrder.toString(),
                                            style: TextStyle(
                                                fontFamily: "ProximaBold",
                                                color: Palette.removeacct,
                                                fontSize: 20),
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
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    height: 30.w,
                                    width: 27.w,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getTranslated(context, today)!,
                                            style: TextStyle(
                                                fontFamily: proxima_nova_reg,
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getTranslated(context, earnings)!,
                                            style: TextStyle(
                                                fontFamily: proxima_nova_reg,
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${data.data!.todayEarnings.toString()} $currencySymbol',
                                            style: TextStyle(
                                                fontFamily: proxima_nova_bold,
                                                color: Palette.intlearning,
                                                fontSize: 20),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 3),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    height: 30.w,
                                    width: 27.w,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getTranslated(context, total)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getTranslated(context, earnings)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Text(
                                            '${data.data!.totalEarnings.toString()} $currencySymbol',
                                            style: TextStyle(
                                                fontFamily: "ProximaBold",
                                                color: Palette.intodayear,
                                                fontSize: 20),
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
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    height: 30.w,
                                    width: 27.w,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getTranslated(context, total)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getTranslated(context, product)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Text(
                                            data.data!.totalMenu.toString(),
                                            style: TextStyle(
                                                fontFamily: "ProximaBold",
                                                color: Palette.ttlprdct,
                                                fontSize: 20),
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
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    height: 30.w,
                                    width: 27.w,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getTranslated(context, total)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            getTranslated(
                                                context, product_item)!,
                                            style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                color: Palette.loginhead,
                                                fontSize: 13.5),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Text(
                                            data.data!.totalSubmenu.toString(),
                                            style: TextStyle(
                                                fontFamily: "ProximaBold",
                                                color: Palette.ttlitem,
                                                fontSize: 20),
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
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              getTranslated(context, earnings)!,
                                              style: TextStyle(
                                                  color: Palette.loginhead,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          /*Text('2021',
                                              style: TextStyle(
                                                color: Palette.switchs,
                                                fontSize: 12,
                                              )),*/
                                        ],
                                      ),
                                      /*DropdownButton<String>(
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
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: 0, right: 0, top: 10),
                                      height: 35.h,
                                      width: 100.w,
                                      
                                      child: LineChart(
                                        showEarningData(jsonEarningData),
                                        swapAnimationDuration:
                                            const Duration(milliseconds: 250),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(getTranslated(context, orders)!,
                                              style: TextStyle(
                                                  color: Palette.loginhead,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          /*Text('2021',
                                              style: TextStyle(
                                                color: Palette.switchs,
                                                fontSize: 12,
                                              )),*/
                                        ],
                                      ),
                                      /*DropdownButton<String>(
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
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: 0, right: 0, top: 10),
                                      height: 35.h,
                                      width: 100.w,
                                      child: LineChart(
                                        showOrderData(jsonOrderData),
                                        swapAnimationDuration:
                                            const Duration(milliseconds: 250),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                          child: Container(
                              child: Text(
                                  snapshot.data!.error.getErrorMessage())));
                    }
                  }
                } else {
                  return DeviceUtils.showProgress(true);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
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
              return '1000 $currencySymbol';
            case 3:
              return '2000 $currencySymbol';
            case 5:
              return '3000 $currencySymbol';
            case 7:
              return '4000 $currencySymbol';
            case 9:
              return '5000 $currencySymbol';
            case 11:
              return '6000 $currencySymbol';
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

LineChartData showOrderData(Map<String, dynamic> jsonData) {
  List<dynamic> eData = jsonData['data'];
  List<dynamic>? lData = jsonData['label'];
  return LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      ),
      touchCallback: (_, __) {},
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
              return '10';
            case 3:
              return '20';
            case 5:
              return '30';
            case 7:
              return '40';
            case 9:
              return '50';
            case 11:
              return '60';
          }
          return '';
        },
        reservedSize: 20,
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
          FlSpot(0, eData.first.toDouble() / 100),
          FlSpot(1, eData[1].toDouble() / 100),
          FlSpot(2, eData[2].toDouble() / 100),
          FlSpot(3, eData[3].toDouble() / 100),
          FlSpot(4, eData[4].toDouble() / 100),
          FlSpot(5, eData[5].toDouble() / 100),
          FlSpot(6, eData[6].toDouble() / 100),
          FlSpot(7, eData[7].toDouble() / 100),
          FlSpot(8, eData[8].toDouble() / 100),
          FlSpot(9, eData[9].toDouble() / 100),
          FlSpot(10, eData[10].toDouble() / 100),
          FlSpot(11, eData[11].toDouble() / 100),
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
