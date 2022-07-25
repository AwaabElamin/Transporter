import 'package:flutter/material.dart';
import 'package:alnaqel_seller/config/Palette.dart';
import 'package:fl_chart/fl_chart.dart';

class EarningHistory extends StatefulWidget {
  @override
  _EarningHistoryState createState() => _EarningHistoryState();
}

class _EarningHistoryState extends State<EarningHistory> {
  String? _chosenValue = 'Yearly';
  String? _showValue = 'Yearly';

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    var showWidget = LineChart(
      showAvg ? avgData() : monthly(),
    );
    if (_showValue == 'Yearly') {
      showWidget = LineChart(
        showAvg ? avgData() : yearly(),
      );
    } else if (_showValue == 'Monthly') {
      showWidget = LineChart(
        showAvg ? avgData2() : monthly(),
      );
    } else if (_showValue == 'Weekly') {
      showWidget = LineChart(
        showAvg ? avgData3() : weekly(),
      );
    } else if (_showValue == 'Daily') {
      showWidget = LineChart(
        showAvg ? avgData4() : daily(),
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
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height * 0.1,
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
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
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
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\u0024539",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaThin",
                                    fontSize: 35),
                              ),
                              Text(
                                "Today's Earning",
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
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\u00243.5K",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaThin",
                                    fontSize: 35),
                              ),
                              Text(
                                "Weekly Earning",
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
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\u00247.2K",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaThin",
                                    fontSize: 35),
                              ),
                              Text(
                                "Monthly Earning",
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
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\u002450K",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaThin",
                                    fontSize: 35),
                              ),
                              Text(
                                "Yearly Earning",
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
              ],
            )
          ],
        ),
      ),
    );
  }

  LineChartData yearly() {
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
          getTitlesWidget: (value, meta) {
            
            String val = () {
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
            }();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(val,
                style: TextStyle(
                  color: Palette.loginhead,
                  fontSize: 14,
                ),
              ),
            );
          },
        )),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
           getTitlesWidget: (value, meta) {
            
            String val = () {
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
            }();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(val,
                style: TextStyle(
                  color: Palette.loginhead,
                  fontSize: 14,
                ),
              ),
            );
          },
          
          
          reservedSize: 40,
        )),
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
          color: gradientColors.first,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color:
                gradientColors.map((color) => color.withOpacity(0.3)).toList().first,
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
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
        bottomTitles:   AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          reservedSize: 22,
           getTitlesWidget: (value, meta) {
            
            String val = () {
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
            }();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(val,
                style: TextStyle(color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },
        )),
        leftTitles:   AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            
            String val = () {
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
            }();
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(val,
                style: TextStyle(
                    color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
                ),
              ),
            );
          },
          
         
          reservedSize: 28,
        )),
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
          //  colors: Colors.grey,
          /*colors: [
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
          belowBarData: BarAreaData(show: true, color: 
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  LineChartData monthly() {
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
          getTitlesWidget: (value, meta) {
            
            String val = () {
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
            }();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(val,
                style: TextStyle(
                      color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14
                ),
              ),
            );
          },
        )),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
             getTitlesWidget: (value, meta) {
            
            String val = () {
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
            }();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(val,
                style: TextStyle(
                      color: Palette.loginhead,
              fontFamily: "ProximaNova",
              fontSize: 14
                ),
              ),
            );
          },
         
          
          reservedSize: 40,
        ),)
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
          color: gradientColors.first,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color:
                gradientColors.map((color) => color.withOpacity(0.3)).toList().first,
          ),
        ),
      ],
    );
  }

  LineChartData avgData2() {
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
          getTitlesWidget: (value, meta) {
            
            String val = () {
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
            }();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(val,
                style: TextStyle(
                    color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16
                ),
              ),
            );
          },
        )),
        leftTitles:  AxisTitles(
            sideTitles:SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            
            String val = () {
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
            }();
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(val,
                style: TextStyle(
                     color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
                ),
              ),
            );
          },
          reservedSize: 28,
        ),
      )),
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
          belowBarData: BarAreaData(show: true, color: 
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  LineChartData weekly() {
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
        )),
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
      )),
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
          color: gradientColors.first,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color:
                gradientColors.map((color) => color.withOpacity(0.3)).toList().first,
          ),
        ),
      ],
    );
  }

  LineChartData avgData3() {
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
        )),
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
      )),
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
          belowBarData: BarAreaData(show: true, color: 
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  LineChartData daily() {
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
        )),
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
      )),
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
            color:
                gradientColors.map((color) => color.withOpacity(0.3)).toList().first
          ),
        ),
      ],
    );
  }

  LineChartData avgData4() {
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
          getTitlesWidget: ,
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
        )),
        leftTitles:    AxisTitles(
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
        )),
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
          belowBarData: BarAreaData(show: true, color: 
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}
