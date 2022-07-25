import 'package:flutter/material.dart';
import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/screens/product/CustomizationOptionScreen.dart';
import 'package:alnaqel_seller/screens/product/ProductScreen.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/images/loginn.png'))),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.23),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Palette.green,
                            size: 25,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Text(
                            "Add Item Image",
                            style: TextStyle(
                                color: Palette.green,
                                fontSize: 15,
                                fontFamily: "ProximaNova"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text(
                    "Title",
                    style: TextStyle(
                        color: Palette.loginhead,
                        fontSize: 16,
                        fontFamily: "ProximaBold"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Name",
                              hintStyle: TextStyle(
                                  color: Palette.switchs,
                                  fontSize: 13,
                                  fontFamily: "ProximaNova")),
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text(
                    "Product Type",
                    style: TextStyle(
                        color: Palette.loginhead,
                        fontSize: 16,
                        fontFamily: "ProximaBold"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Type",
                            style: TextStyle(
                                color: Palette.switchs,
                                fontSize: 14,
                                fontFamily: "ProximaBold"),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Palette.loginhead,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text(
                    "Category",
                    style: TextStyle(
                        color: Palette.loginhead,
                        fontSize: 16,
                        fontFamily: "ProximaBold"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Vegetarian",
                            style: TextStyle(
                                color: Palette.switchs,
                                fontSize: 14,
                                fontFamily: "ProximaBold"),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Palette.loginhead,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text(
                    "Ingredients",
                    style: TextStyle(
                        color: Palette.loginhead,
                        fontSize: 16,
                        fontFamily: "ProximaBold"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Add Ingredients",
                              hintStyle: TextStyle(
                                  color: Palette.switchs,
                                  fontSize: 13,
                                  fontFamily: "ProximaNova")),
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text(
                    "Price",
                    style: TextStyle(
                        color: Palette.loginhead,
                        fontSize: 16,
                        fontFamily: "ProximaBold"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Palette.white),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Price",
                              hintStyle: TextStyle(
                                  color: Palette.switchs,
                                  fontSize: 13,
                                  fontFamily: "ProximaNova")),
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomizationOptionScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.add,
                          color: Palette.green,
                        ),
                        Text(
                          " Add Customization Options",
                          style: TextStyle(
                              color: Palette.green,
                              fontFamily: "ProximaNova",
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProductScreen()));
        },
        child: Container(
          color: Palette.green,
          height: MediaQuery.of(context).size.height * 0.07,
          child: Center(
            child: Text(
              "Add This Item",
              style: TextStyle(
                  fontSize: 15,
                  color: Palette.white,
                  fontFamily: "ProximaNova"),
            ),
          ),
        ),
      ),
    );
  }
}
