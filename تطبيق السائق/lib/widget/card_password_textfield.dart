import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alnaqel_driver/util/constants.dart';

class CardPasswordTextFieldWidget extends StatefulWidget {
  CardPasswordTextFieldWidget(
      {required this.hintText,
      required this.isPasswordVisible,
      this.textEditingController,
      this.validator});

  String hintText;
  bool isPasswordVisible;
  Function? validator;
  final TextEditingController? textEditingController;

  @override
  _CardTextFieldWidgetState createState() => _CardTextFieldWidgetState();
}

class _CardTextFieldWidgetState extends State<CardPasswordTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(Constants.lightBlack),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 10),
        child: TextFormField(
          validator: widget.validator as String? Function(String?)?,
          controller: widget.textEditingController,
          obscureText: widget.isPasswordVisible,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: Constants.appFontBold),
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Color(Constants.colorHint)),
              hintText: widget.hintText,
              suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    // Based on passwordVisible state choose the icon
                    widget.isPasswordVisible
                        ? 'images/ic_eye_hide.svg'
                        : 'images/ic_eye.svg',
                    height: 15,
                    width: 15,
                    color: Color(Constants.colorHint),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.isPasswordVisible = !widget.isPasswordVisible;
                    });
                  }),
              errorStyle: TextStyle(
                  fontFamily: Constants.appFontBold, color: Colors.red),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
