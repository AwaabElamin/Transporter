import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:alnaqel_seller/config/Palette.dart';

class Insight extends StatefulWidget {
  @override
  _InsightState createState() => _InsightState();
}

class _InsightState extends State<Insight> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  String? _chosenValue = 'Yearly';
  String? _showValue = 'Yearly';
  String? _chosenValue2 = 'Yearly';
  String? _showValue2 = 'Yearly';

  List<Color> gradientColors2 = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg2 = false;

  @override
  Widget build(BuildContext context) {
    var showWidget = LineChart(
      showAvg ? earningyearlyData() : earningyearly(),
    );
    if (_showValue == 'Yearly') {
      showWidget = LineChart(
        showAvg ? earningyearlyData() : earningyearly(),
      );
    } else if (_showValue == 'Monthly') {
      showWidget = LineChart(
        showAvg ? earningmonthlyData() : earningmonthly(),
      );
    } else if (_showValue == 'Weekly') {
      showWidget = LineChart(
        showAvg ? earningweeklyData() : earningweekly(),
      );
    } else if (_showValue == 'Daily') {
      showWidget = LineChart(
        showAvg ? earningdailyData() : earningdaily(),
      );
    }

    var showWidget2 = LineChart(
      showAvg2 ? orderyearlyData() : orderyearly(),
    );
    if (_showValue2 == 'Yearly') {
      showWidget2 = LineChart(
        showAvg2 ? orderyearlyData() : orderyearly(),
      );
    } else if (_showValue2 == 'Monthly') {
      showWidget2 = LineChart(
        showAvg2 ? ordermonthlyData() : ordermonthly(),
      );
    } else if (_showValue2 == 'Weekly') {
      showWidget2 = LineChart(
        showAvg2 ? orderweeklyData() : orderweekly(),
      );
    } else if (_showValue2 == 'Daily') {
      showWidget2 = LineChart(
        showAvg2 ? orderdailyData() : orderdaily(),
      );
    }

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
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today's",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              Text(
                                "Order",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "50",
                                style: TextStyle(
                                    fontFamily: "ProximaBold",
                                    color: Palette.inorder,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              Text(
                                "Orders",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "3.9k",
                                style: TextStyle(
                                    fontFamily: "ProximaBold",
                                    color: Palette.removeacct,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today's",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              Text(
                                "Order",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "50k",
                                style: TextStyle(
                                    fontFamily: "ProximaBold",
                                    color: Palette.intlearning,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today's",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              Text(
                                "Earnings",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "1k",
                                style: TextStyle(
                                    fontFamily: "ProximaBold",
                                    color: Palette.intodayear,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              Text(
                                "Product",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "05",
                                style: TextStyle(
                                    fontFamily: "ProximaBold",
                                    color: Palette.ttlprdct,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 14),
                              ),
                              Text(
                                "Product Items",
                                style: TextStyle(
                                    fontFamily: "ProximaNova",
                                    color: Palette.loginhead,
                                    fontSize: 13.5),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "57",
                                style: TextStyle(
                                    fontFamily: "ProximaBold",
                                    color: Palette.ttlitem,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Earnings',
                                          style: TextStyle(
                                              color: Palette.loginhead,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text('2020',
                                          style: TextStyle(
                                            color: Palette.switchs,
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                  DropdownButton<String>(
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            child: showWidget,
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Orders',
                                          style: TextStyle(
                                              color: Palette.loginhead,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text('2020',
                                          style: TextStyle(
                                            color: Palette.switchs,
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                  DropdownButton<String>(
                                    value: _chosenValue2,
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
                                        _chosenValue2 = value;
                                        _showValue2 = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            child: showWidget2,
                          )
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  LineChartData earningyearly() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.profliedivider,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '2017';
              case 5:
                return '2018';
              case 8:
                return '2019';
              case 11:
                return '2020';
              case 14:
                return '2021';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
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
          reservedSize: 40,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1.9,
      maxX: 16,
      minY: 1,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(2, 1),
            FlSpot(3, 2),
            FlSpot(6, 3),
            FlSpot(8.8, 8.5),
            FlSpot(11.8, 7),
            FlSpot(15, 11),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData earningyearlyData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '2017';
              case 5:
                return '2018';
              case 8:
                return '2019';
              case 11:
                return '2020';
              case 14:
                return '2021';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          /* colors: [
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2),
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2),
        ],*/
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
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

  LineChartData earningmonthly() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.profliedivider,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Jan';
              case 5:
                return 'Feb';
              case 8:
                return 'Mar';
              case 11:
                return 'Apr';
              case 14:
                return 'May';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
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
          reservedSize: 40,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1.9,
      maxX: 16,
      minY: 1,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(2, 1),
            FlSpot(3, 3),
            FlSpot(6, 5),
            FlSpot(8.8, 8.5),
            FlSpot(11.8, 3),
            FlSpot(15, 5),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData earningmonthlyData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Jan';
              case 5:
                return 'Feb';
              case 8:
                return 'Mar';
              case 11:
                return 'Apr';
              case 14:
                return 'May';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          /* colors: [
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2),
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2),
        ],*/
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
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

  LineChartData earningweekly() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.profliedivider,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Mon';
              case 5:
                return 'Tue';
              case 8:
                return 'Wed';
              case 11:
                return 'Thu';
              case 14:
                return 'Fri';
              case 16:
                return 'Sat';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
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
          reservedSize: 40,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1.9,
      maxX: 18,
      minY: 1,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(2, 1),
            FlSpot(3, 3),
            FlSpot(6, 6),
            FlSpot(8.8, 4),
            FlSpot(11.8, 6),
            FlSpot(15, 8),
            FlSpot(17, 11),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData earningweeklyData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Jan';
              case 5:
                return 'Feb';
              case 8:
                return 'Mar';
              case 11:
                return 'Apr';
              case 14:
                return 'May';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          /* colors: [
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2),
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2),
        ],*/
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
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

  LineChartData earningdaily() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.profliedivider,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Yesterday';
              case 5:
                return 'Today';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
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
          reservedSize: 40,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1.9,
      maxX: 16,
      minY: 1,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(2, 1),
            FlSpot(3, 4),
            FlSpot(6, 6),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData earningdailyData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Jan';
              case 5:
                return 'Feb';
              case 8:
                return 'Mar';
              case 11:
                return 'Apr';
              case 14:
                return 'May';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          /*   colors: [
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2),
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2),
        ],*/
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
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

  LineChartData orderyearly() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.profliedivider,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '2017';
              case 5:
                return '2018';
              case 8:
                return '2019';
              case 11:
                return '2020';
              case 14:
                return '2021';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
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
          reservedSize: 40,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1.9,
      maxX: 16,
      minY: 1,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(2, 1),
            FlSpot(3, 2),
            FlSpot(6, 3),
            FlSpot(8.8, 8.5),
            FlSpot(11.8, 7),
            FlSpot(15, 11),
          ],
          isCurved: true,
          colors: gradientColors2,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors2.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData orderyearlyData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '2017';
              case 5:
                return '2018';
              case 8:
                return '2019';
              case 11:
                return '2020';
              case 14:
                return '2021';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          /*colors: [
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2),
          ],*/
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }

  LineChartData ordermonthly() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.profliedivider,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Jan';
              case 5:
                return 'Feb';
              case 8:
                return 'Mar';
              case 11:
                return 'Apr';
              case 14:
                return 'May';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
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
          reservedSize: 40,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1.9,
      maxX: 16,
      minY: 1,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(2, 1),
            FlSpot(3, 3),
            FlSpot(6, 5),
            FlSpot(8.8, 8.5),
            FlSpot(11.8, 3),
            FlSpot(15, 5),
          ],
          isCurved: true,
          colors: gradientColors2,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors2.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData ordermonthlyData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Jan';
              case 5:
                return 'Feb';
              case 8:
                return 'Mar';
              case 11:
                return 'Apr';
              case 14:
                return 'May';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          /*colors: [
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2),
          ],*/
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }

  LineChartData orderweekly() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.profliedivider,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Mon';
              case 5:
                return 'Tue';
              case 8:
                return 'Wed';
              case 11:
                return 'Thu';
              case 14:
                return 'Fri';
              case 16:
                return 'Sat';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
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
          reservedSize: 40,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1.9,
      maxX: 18,
      minY: 1,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(2, 1),
            FlSpot(3, 3),
            FlSpot(6, 6),
            FlSpot(8.8, 4),
            FlSpot(11.8, 6),
            FlSpot(15, 8),
            FlSpot(17, 11),
          ],
          isCurved: true,
          colors: gradientColors2,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors2.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData orderweeklyData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Jan';
              case 5:
                return 'Feb';
              case 8:
                return 'Mar';
              case 11:
                return 'Apr';
              case 14:
                return 'May';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          /* colors: [
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2),
          ],*/
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }

  LineChartData orderdaily() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.profliedivider,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Yesterday';
              case 5:
                return 'Today';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
              color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14),
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
          reservedSize: 40,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 1.9,
      maxX: 16,
      minY: 1,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(2, 1),
            FlSpot(3, 4),
            FlSpot(6, 6),
          ],
          isCurved: true,
          colors: gradientColors2,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors2.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData orderdailyData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, _) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'Jan';
              case 5:
                return 'Feb';
              case 8:
                return 'Mar';
              case 11:
                return 'Apr';
              case 14:
                return 'May';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTextStyles: (value, _) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
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
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          /*  colors: [
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2),
          ],*/
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors2[0], end: gradientColors2[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
