import 'dart:async';
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
import 'package:alnaqel_driver/screen/forgotpassword2screen.dart';
import 'package:alnaqel_driver/util/app_toolbar.dart';
import 'package:alnaqel_driver/util/constants.dart';
import 'package:alnaqel_driver/util/preferenceutils.dart';
import 'package:alnaqel_driver/widget/app_lable_widget.dart';
import 'package:alnaqel_driver/widget/hero_image_app_logo.dart';
import 'package:alnaqel_driver/widget/rounded_corner_app_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotOTPScreen extends StatefulWidget {
  final int? driverId;

  ForgotOTPScreen(this.driverId);

  //

  @override
  _ForgotOTPScreen createState() => _ForgotOTPScreen();
}

class _ForgotOTPScreen extends State<ForgotOTPScreen> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  FocusNode _focusNode = new FocusNode();
  bool showSpinner = false;

  int _start = 60;
  late Timer _timer;

  int? getOTP;

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();

    startTimer();
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
    });

    // getOTP = SharedPreferenceUtil.getInt(Constants.registrationOTP);
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    /*ScreenUtil.init(context,
        designSize: Size(defaultScreenWidth, defaultScreenHeight),
        allowFontScaling: true);
*/
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/background_image.png'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          appBar: ApplicationToolbar(
            appbarTitle: Languages.of(context)!.otplable,
          ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HeroImage(),
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
                          child: SvgPicture.asset(
                            'images/ic_otp.svg',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(20),
                              right: ScreenUtil().setWidth(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppLableWidget(
                                    title: Languages.of(context)!.enterotplable,
                                    // title: PreferenceUtils.getString(Constants.driverotp.toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(30)),
                                    child: Text(
                                      '00 : $_start',
                                      style: TextStyle(
                                          fontFamily: Constants.appFont,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OTPTextField(
                                    editingController: textEditingController1,
                                    textInputAction: TextInputAction.next,
                                    focus: (v) {
                                      FocusScope.of(context).nextFocus();
                                    },
                                  ),
                                  OTPTextField(
                                    editingController: textEditingController2,
                                    textInputAction: TextInputAction.next,
                                    focus: (v) {
                                      FocusScope.of(context).nextFocus();
                                    },
                                  ),
                                  OTPTextField(
                                    editingController: textEditingController3,
                                    textInputAction: TextInputAction.next,
                                    focus: (v) {
                                      FocusScope.of(context).nextFocus();
                                    },
                                  ),
                                  OTPTextField(
                                    editingController: textEditingController4,
                                    textInputAction: TextInputAction.done,
                                    focus: (v) {
                                      FocusScope.of(context).dispose();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              RoundedCornerAppButton(
                                  btnLable:
                                      Languages.of(context)!.verifynowlable,
                                  onPressed: () {
                                    String otp = textEditingController1.text +
                                        textEditingController2.text +
                                        textEditingController3.text +
                                        textEditingController4.text;

                                    if (otp.length != 4) {
                                      Constants.createSnackBar(
                                          Languages.of(context)!
                                              .entervalidotplable,
                                          context,
                                          Color(Constants.greentext));
                                    } else {
                                      // Constants.checkNetwork().whenComplete(() =>   pr.show());
                                      Constants.checkNetwork().whenComplete(
                                          () =>
                                              callApiForCheckOTp(otp, context));
                                    }
                                  }),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              InkWell(
                                onTap: () {
                                  // Constants.checkNetwork().whenComplete(() =>   pr.show());
                                  Constants.checkNetwork().whenComplete(
                                      () => callApiForResendOtp(context));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Languages.of(context)!
                                          .dontrecivecodelable,
                                      style: TextStyle(
                                          fontFamily: Constants.appFont,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      Languages.of(context)!.resendotplable,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Constants.appFont,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
                          child: Text(
                            Languages.of(context)!.willshareotplable,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  callApiForCheckOTp(String otp, BuildContext context) {
    print("Driverid123:${widget.driverId}");

    setState(() {
      showSpinner = true;
    });

    RestClient(ApiHeader().dioData())
        .driverforgotcheckotp(
      widget.driverId.toString(),
      otp,
    )
        .then((response) {
      final body = json.decode(response!);
      bool? sucess = body['success'];
      print(sucess);

      if (sucess == true) {
        setState(() {
          showSpinner = false;
        });

        print(true);

        var msg = body['msg'];
        Constants.createSnackBar(msg, context, Color(Constants.greentext));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgotPasswordNextScreen(widget.driverId)),
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
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response!;
          print(res);

          var responsecode = res.statusCode;
          // print(responsecode);

          if (responsecode == 401) {
            setState(() {
              showSpinner = false;
            });
            print(responsecode);
            print(res.statusMessage);
          } else if (responsecode == 422) {
            setState(() {
              showSpinner = false;
            });
            print("code:$responsecode");
          }

          break;
        default:
          setState(() {
            showSpinner = false;
          });
      }
    });
  }

  callApiForResendOtp(BuildContext context) {
    setState(() {
      showSpinner = true;
    });
    RestClient(ApiHeader().dioData())
        .driverresendotp(PreferenceUtils.getString(Constants.driveremail))
        .then((response) {
      final body = json.decode(response!);
      bool? sucess = body['success'];
      print(sucess);

      if (sucess == true) {
        setState(() {
          showSpinner = false;
        });

        print(true);

        Constants.createSnackBar(Languages.of(context)!.otpsendsucesslable,
            context, Color(Constants.greentext));
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
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response!;
          print(res);

          var responsecode = res.statusCode;
          // print(responsecode);

          if (responsecode == 401) {
            setState(() {
              showSpinner = false;
            });
            print(responsecode);
            print(res.statusMessage);
          } else if (responsecode == 422) {
            setState(() {
              showSpinner = false;
            });
            print("code:$responsecode");
          }

          break;
        default:
          setState(() {
            showSpinner = false;
          });
      }
    });
  }
}

class OTPTextField extends StatelessWidget {
  final TextEditingController editingController;
  final TextInputAction textInputAction;
  final Function focus;

  OTPTextField(
      {required this.editingController,
      required this.textInputAction,
      required this.focus});

  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //   flex: 1,
    //   child:
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: ScreenUtil().setWidth(70),
        // width: 35,
        height: ScreenUtil().setHeight(70),
        alignment: Alignment.center,
        margin: EdgeInsets.all(2.0),
        child: Card(
          color: Color(Constants.lightBlack),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2.0,
          child: Center(
            child: TextFormField(
              onFieldSubmitted: focus as void Function(String)?,
              controller: editingController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              textInputAction: textInputAction,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              onChanged: (str) {
                if (str.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else {
                  FocusScope.of(context).previousFocus();
                }
              },
              style: TextStyle(
                  fontFamily: Constants.appFont,
                  fontSize: ScreenUtil().setSp(25),
                  color: Color(Constants.colorGray)),
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Color(Constants.colorHint),
                  ),
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
    // );
  }
}
