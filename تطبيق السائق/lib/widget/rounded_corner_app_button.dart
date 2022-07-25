import 'package:flutter/material.dart';
import 'package:alnaqel_driver/util/constants.dart';

class RoundedCornerAppButton extends StatelessWidget {
  RoundedCornerAppButton({required this.btnLable, required this.onPressed});

  final btnLable;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // elevation: 5.0,
      // textColor: Colors.white,
      // color: Color(Constants.colorTheme),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0, 15.0),
        child: Text(
          btnLable,
          style: TextStyle(
              fontFamily: Constants.appFont,
              fontWeight: FontWeight.w900,
              fontSize: 16.0),
        ),
      ),
      onPressed: onPressed as void Function()?,
      // shape: new RoundedRectangleBorder(
      //   borderRadius: new BorderRadius.circular(15.0),
      // ),
    );
  }
}
