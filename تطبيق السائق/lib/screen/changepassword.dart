import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alnaqel_driver/apiservice/ApiHeader.dart';
import 'package:alnaqel_driver/apiservice/Apiservice.dart';
import 'package:alnaqel_driver/localization/language/languages.dart';
import 'package:alnaqel_driver/screen/forgotpasswordscreen.dart';
import 'package:alnaqel_driver/screen/homescreen.dart';
import 'package:alnaqel_driver/util/constants.dart';
import 'package:alnaqel_driver/util/preferenceutils.dart';
import 'package:alnaqel_driver/widget/app_lable_widget.dart';
import 'package:alnaqel_driver/widget/card_password_textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  String strCountryCode = '+249';
  String birthvalue = "1";
  final oldTextPassword = TextEditingController();
  final newTextPassword = TextEditingController();
  final confirmTextPassword = TextEditingController();
  bool _passwordVisible = true;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  // ProgressDialog pr;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    PreferenceUtils.init();
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenheight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;
    /* ScreenUtil.init(context,
        designSize: Size(screenwidth, screenheight), allowFontScaling: true);
*/
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/background_image.png'),
            fit: BoxFit.cover,
          )),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              // resizeToAvoidBottomPadding: true,
              resizeToAvoidBottomInset: true,
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(
                  Languages.of(context)!.changepasswordlable,
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(Constants.whitetext),
                    fontFamily: Constants.appFontBold,
                    fontSize: 18,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                automaticallyImplyLeading: true,
              ),
              body: ModalProgressHUD(
                inAsyncCall: showSpinner,
                opacity: 1.0,
                color: Colors.transparent.withOpacity(0.2),
                progressIndicator:
                    SpinKitFadingCircle(color: Color(Constants.greentext)),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return new Stack(
                    children: <Widget>[
                      new SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 60),
                          color: Colors.transparent,
                          child: Form(
                            key: _formKey,
                            autovalidateMode: _autoValidate,
                            child: Column(
                              // physics: NeverScrollableScrollPhysics(),
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.all(ScreenUtil().setWidth(8)),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 0, right: 5, bottom: 0, left: 5),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(0),
                                          right: ScreenUtil().setWidth(0)),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: AppLableWidget(
                                                title: Languages.of(context)!
                                                    .oldpasswordlable,
                                              ),
                                            ),
                                            CardPasswordTextFieldWidget(
                                                textEditingController:
                                                    oldTextPassword,
                                                validator:
                                                    Constants.kvalidatePassword,
                                                hintText: Languages.of(context)!
                                                    .enterpasswordlabel,
                                                isPasswordVisible:
                                                    _passwordVisible),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: AppLableWidget(
                                                title: 'New Password',
                                              ),
                                            ),
                                            CardPasswordTextFieldWidget(
                                                textEditingController:
                                                    newTextPassword,
                                                validator:
                                                    Constants.kvalidatePassword,
                                                hintText: Languages.of(context)!
                                                    .enterpasswordlabel,
                                                isPasswordVisible:
                                                    _passwordVisible),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: AppLableWidget(
                                                title: Languages.of(context)!
                                                    .confirmpasslable,
                                              ),
                                            ),
                                            CardPasswordTextFieldWidget(
                                                textEditingController:
                                                    confirmTextPassword,
                                                validator: validateConfPassword,
                                                hintText: Languages.of(context)!
                                                    .changepasswordlable,
                                                isPasswordVisible:
                                                    _passwordVisible),
                                            SizedBox(
                                              height: 100,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      new Container(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              // Constants.checkNetwork().whenComplete(() => pr.show());
                              Constants.checkNetwork().whenComplete(() =>
                                  CallChangePasswordApi(
                                      oldTextPassword.text,
                                      newTextPassword.text,
                                      confirmTextPassword.text,
                                      context));
                            } else {
                              setState(() {
                                // validation error
                                _autoValidate = AutovalidateMode.always;
                              });
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.0),
                                color: Color(Constants.greentext),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 0.0), //(x,y)
                                    blurRadius: 0.0,
                                  ),
                                ],
                              ),
                              width: screenwidth,
                              height: screenheight * 0.08,
                              child: Center(
                                child: Container(
                                  color: Color(Constants.greentext),
                                  child: Text(
                                    Languages.of(context)!
                                        .changemypasswordlable,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: Constants.appFont),
                                  ),
                                ),
                              )),
                        )),
                      )),
                      new Container(
                          margin: EdgeInsets.only(bottom: 40), child: Body1())
                    ],
                  );
                }),
              )),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return true;
  }

  String? validateConfPassword(String? value) {
    Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    RegExp regex = new RegExp(pattern as String);
    if (value!.length == 0) {
      return Languages.of(context)!.passwordrequiredlable;
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    } else if (newTextPassword.text != confirmTextPassword.text)
      return Languages.of(context)!.passwordnotmatchlable;
    else if (!regex.hasMatch(value))
      return Languages.of(context)!.passwordrequiredlable;
    else
      return null;
  }

  CallChangePasswordApi(String oldpassword, String newpassword,
      String confirmpassword, BuildContext context) {
    setState(() {
      showSpinner = true;
    });

    RestClient(ApiHeader().dioData())
        .driverchangepassword(oldpassword, newpassword, confirmpassword)
        .then((response) {
      if (mounted) {
        print(response.toString());
        final body = json.decode(response!);

        bool? sucess = body['success'];
        print(sucess);

        if (sucess == true) {
          setState(() {
            showSpinner = false;
          });

          var msg = body['data'];

          Constants.createSnackBar(msg, context, Color(Constants.greentext));

          Constants.toastMessage(msg);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(2)),
          );
        } else {
          setState(() {
            showSpinner = false;
          });

          var msg = body['data'];

          Constants.createSnackBar(msg, context, Color(Constants.redtext));
        }
      }
    }).catchError((Object obj) {
      final snackBar = SnackBar(
        content: Text(Languages.of(context)!.servererrorlable),
        backgroundColor: Color(Constants.redtext),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        showSpinner = false;
      });

      print("error:$obj");
      print(obj.runtimeType);
      //AppConstant.toastMessage("Internal Server Error");
    });
  }
}

class Body1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 0, bottom: 60),
              child: Text(
                Languages.of(context)!.dontremembaroldpasswordlable,
                maxLines: 2,
                overflow: TextOverflow.visible,
                style: TextStyle(
                    color: Color(Constants.whitetext),
                    fontFamily: Constants.appFontBold,
                    fontSize: 14),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => new ForgotPasswordScreen()));
              },
              child: Container(
                margin: EdgeInsets.only(left: 0, right: 10, bottom: 60),
                child: SvgPicture.asset("images/white_right.svg"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
