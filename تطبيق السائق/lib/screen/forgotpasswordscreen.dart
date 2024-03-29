import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alnaqel_driver/apiservice/ApiHeader.dart';
import 'package:alnaqel_driver/apiservice/Apiservice.dart';
import 'package:alnaqel_driver/localization/language/languages.dart';
import 'package:alnaqel_driver/screen/forgototpscreen.dart';
import 'package:alnaqel_driver/util/app_toolbar.dart';
import 'package:alnaqel_driver/util/constants.dart';
import 'package:alnaqel_driver/util/preferenceutils.dart';
import 'package:alnaqel_driver/widget/app_lable_widget.dart';
import 'package:alnaqel_driver/widget/card_textfield.dart';
import 'package:alnaqel_driver/widget/hero_image_app_logo.dart';
import 'package:alnaqel_driver/widget/rounded_corner_app_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  TextEditingController _text_email = TextEditingController();

  FocusNode _focusNode = new FocusNode();

  final _formKey = new GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;

    double defaultScreenWidth = screenwidth;
    double defaultScreenHeight = screenHeight;

    /*ScreenUtil.init(context,
        designSize: Size(defaultScreenWidth, defaultScreenHeight),
        allowFontScaling: true);*/

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/background_image.png'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          appBar: ApplicationToolbar(
              appbarTitle: Languages.of(context)!.forgotpasswordlabel),
          backgroundColor: Colors.transparent,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            opacity: 1.0,
            color: Colors.transparent.withOpacity(0.2),
            progressIndicator:
                SpinKitFadingCircle(color: Color(Constants.greentext)),
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autoValidate,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HeroImage(),
                          Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
                            child: SvgPicture.asset(
                              'images/email.svg',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(20),
                                right: ScreenUtil().setWidth(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppLableWidget(
                                  title: Languages.of(context)!.emaillabel,
                                ),
                                CardTextFieldWidget(
                                  focus: (v) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  textInputAction: TextInputAction.next,
                                  hintText:
                                      Languages.of(context)!.enteremaillabel,
                                  textInputType: TextInputType.emailAddress,
                                  textEditingController: _text_email,
                                  validator: Constants.kvalidateEmail,
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                RoundedCornerAppButton(
                                    btnLable:
                                        Languages.of(context)!.submitlable,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        print("true");

                                        Constants.checkNetwork().whenComplete(
                                            () => callApiEndEmailOtp(
                                                  _text_email.text,
                                                  context,
                                                ));
                                      } else {
                                        setState(() {
                                          _autoValidate =
                                              AutovalidateMode.always;
                                        });
                                      }
                                    }),
                                SizedBox(
                                  height: ScreenUtil().setHeight(15),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                            child: Text(
                              Languages.of(context)!.checkemailotplable,
                              style: TextStyle(
                                color: Color(Constants.colorGray),
                                fontSize: ScreenUtil().setSp(10),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  callApiEndEmailOtp(String email, BuildContext context) {
    setState(() {
      showSpinner = true;
    });

    RestClient(ApiHeader().dioData())
        .driverforgotpassotp(email)
        .then((response) {
      final body = json.decode(response!);
      bool? sucess = body['success'];
      print(sucess);

      if (sucess == true) {
        print(true);

        var msg = body['msg'];
        var driverId = body['data'];
        setState(() {
          showSpinner = false;

          PreferenceUtils.setString(Constants.driveremail, email);
        });
        Constants.createSnackBar(msg, context, Color(Constants.greentext));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotOTPScreen(driverId)),
        );
      } else if (sucess == false) {
        setState(() {
          showSpinner = false;
        });

        var msg = body['data'];
        print(msg);
        Constants.createSnackBar(msg, context, Color(Constants.redtext));
      }
    }).catchError((Object obj) {
      setState(() {
        showSpinner = false;
      });

      // pr.hide();
      print("error:$obj.");
      print(obj.runtimeType);

      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response!;
          print(res);

          var responsecode = res.statusCode;
          // print(responsecode);

          if (responsecode == 401) {
            print(responsecode);
            print(res.statusMessage);
          } else if (responsecode == 422) {
            print("code:$responsecode");
          }

          break;
        default:
      }
    });
  }
}
