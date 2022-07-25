import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:alnaqel_seller/config/Palette.dart';

class OrderDetail extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'))),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Aalfred Sanaderson",
                              style: TextStyle(
                                  color: Palette.loginhead,
                                  fontFamily: "ProximaNova",
                                  fontSize: 16),
                            ),
                          ),
                          Container(
                            child: Image.asset("assets/images/call.png"),
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
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.29,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/veg.svg"),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Veg Noodles With Market",
                                          style: TextStyle(
                                              color: Palette.loginhead,
                                              fontSize: 14,
                                              fontFamily: "ProximaNova"),
                                        ),
                                        Text(
                                          "Veggies Combo",
                                          style: TextStyle(
                                              color: Palette.loginhead,
                                              fontSize: 14,
                                              fontFamily: "ProximaNova"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "1",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 14,
                                    fontFamily: "ProximaNova"),
                              ),
                              Text(
                                "\u0024150",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 14,
                                    fontFamily: "ProximaBold"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                          child: Text(
                            "Extra Toppings, Extra Sauce,",
                            style: TextStyle(
                                color: Palette.switchs,
                                fontSize: 14,
                                fontFamily: "ProximaNova"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 01, 0, 0),
                          child: Text(
                            "Extra Vegetables",
                            style: TextStyle(
                                color: Palette.switchs,
                                fontSize: 14,
                                fontFamily: "ProximaNova"),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          indent: 15,
                          endIndent: 25,
                          color: Palette.divider,
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
                                  Image.asset("assets/images/veg.svg"),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      "Choco Vanilla Thick Shake",
                                      style: TextStyle(
                                          color: Palette.loginhead,
                                          fontSize: 14,
                                          fontFamily: "ProximaNova"),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "4",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 14,
                                    fontFamily: "ProximaNova"),
                              ),
                              Text(
                                "\u0024280",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 14,
                                    fontFamily: "ProximaBold"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          indent: 15,
                          endIndent: 25,
                          color: Palette.divider,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/veg.svg"),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      "Thin Crust Italian Taste",
                                      style: TextStyle(
                                          color: Palette.loginhead,
                                          fontSize: 14,
                                          fontFamily: "ProximaNova"),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "1",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 14,
                                    fontFamily: "ProximaNova"),
                              ),
                              Text(
                                "\u0024110",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 14,
                                    fontFamily: "ProximaBold"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                          child: Text(
                            "Extra Toppings, Extra Sauce,",
                            style: TextStyle(
                                color: Palette.switchs,
                                fontSize: 14,
                                fontFamily: "ProximaNova"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 01, 0, 0),
                          child: Text(
                            "Extra Vegetables",
                            style: TextStyle(
                                color: Palette.switchs,
                                fontSize: 14,
                                fontFamily: "ProximaNova"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.37,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Veg Noodles With Market",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 15,
                                    fontFamily: "ProximaNova"),
                              ),
                              Text(
                                "\u0024150",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 15,
                                    fontFamily: "ProximaBold"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 02, 0, 0),
                          child: Row(
                            children: [
                              Text(
                                "Veggies Combo ",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 15,
                                    fontFamily: "ProximaNova"),
                              ),
                              Text(
                                "x 1",
                                style: TextStyle(
                                    color: Palette.green,
                                    fontSize: 15,
                                    fontFamily: "ProximaBold"),
                              )
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
                              Row(
                                children: [
                                  Text(
                                    "Choco Vanilla Thick Shake ",
                                    style: TextStyle(
                                        color: Palette.loginhead,
                                        fontSize: 15,
                                        fontFamily: "ProximaNova"),
                                  ),
                                  Text(
                                    "x 4",
                                    style: TextStyle(
                                        color: Palette.green,
                                        fontSize: 15,
                                        fontFamily: "ProximaBold"),
                                  ),
                                ],
                              ),
                              Text(
                                "\u0024280",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 15,
                                    fontFamily: "ProximaBold"),
                              )
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
                              Row(
                                children: [
                                  Text(
                                    "Thin Crust Italian Taste ",
                                    style: TextStyle(
                                        color: Palette.loginhead,
                                        fontSize: 15,
                                        fontFamily: "ProximaNova"),
                                  ),
                                  Text(
                                    "x 1",
                                    style: TextStyle(
                                        color: Palette.green,
                                        fontSize: 15,
                                        fontFamily: "ProximaBold"),
                                  ),
                                ],
                              ),
                              Text(
                                "\u0024110",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 15,
                                    fontFamily: "ProximaBold"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 10.0,
                          dashColor: Palette.divider,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal ",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 15,
                                    fontFamily: "ProximaNova"),
                              ),
                              Text(
                                "\u0024110",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 15,
                                    fontFamily: "ProximaBold"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 10.0,
                          dashColor: Palette.divider,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Applied Coupon",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontSize: 15,
                                    fontFamily: "ProximaNova"),
                              ),
                              Text(
                                "-\u0024162",
                                style: TextStyle(
                                    color: Palette.removeacct,
                                    fontSize: 15,
                                    fontFamily: "ProximaBold"),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                          child: Text(
                            "FPAR1223F(30%)",
                            style: TextStyle(
                                color: Palette.green,
                                fontSize: 15,
                                fontFamily: "ProximaBold"),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 10.0,
                          dashColor: Palette.divider,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand Total",
                                style: TextStyle(
                                    color: Palette.green,
                                    fontSize: 15,
                                    fontFamily: "ProximaBold"),
                              ),
                              Text(
                                "\u0024378",
                                style: TextStyle(
                                    color: Palette.green,
                                    fontSize: 15,
                                    fontFamily: "ProximaBold"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black),
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Martin Lucifer",
                                          style: TextStyle(
                                              color: Palette.loginhead,
                                              fontSize: 15,
                                              fontFamily: "ProximaBold"),
                                        ),
                                        Text(
                                          "+1 000 000 0000",
                                          style: TextStyle(
                                              color: Palette.switchs,
                                              fontSize: 15,
                                              fontFamily: "ProximaNova"),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Container(
                            child: Image.asset("assets/images/call.png"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Container(
                                  child: Image.asset("assets/images/from.png")),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(26, 5, 0, 5),
                              child: DottedLine(
                                direction: Axis.vertical,
                                lineLength: 50,
                                lineThickness: 3.0,
                                dashLength: 2.0,
                                dashColor: Palette.loginhead,
                                dashRadius: 0.0,
                                dashGapLength: 4.0,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Container(
                                  child: Image.asset("assets/images/two.png")),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Text(
                                "Alex's Kitchen",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaBold",
                                    fontSize: 16),
                              ),
                              Text(
                                "600 W 9th St, Los Angeles, CA 90015,\nUnited States",
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: "ProximaNova",
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: "ProximaBold",
                                    fontSize: 16),
                              ),
                              Text(
                                "702 N Figueroa St, Los Angeles, CA 30092,\nUnited States",
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: "ProximaNova",
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
