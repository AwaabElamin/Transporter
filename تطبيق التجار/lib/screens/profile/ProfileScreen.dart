import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/utilities/device_utils.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/models/vendor_detail.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:alnaqel_seller/screens/auth/LoginScreen.dart';
import 'package:alnaqel_seller/screens/profile/screens/CashBalanceScreen.dart';
import 'package:alnaqel_seller/screens/profile/screens/ChangeLanguageScreen.dart';
import 'package:alnaqel_seller/screens/profile/screens/ChangePasswordScreen.dart';
import 'package:alnaqel_seller/screens/profile/screens/EarningHistoryScreen.dart';
import 'package:alnaqel_seller/screens/profile/screens/FaqScreen.dart';
import 'package:alnaqel_seller/screens/profile/screens/ProfileEditScreen.dart';
import 'package:alnaqel_seller/utilities/prefConstatnt.dart';
import 'package:alnaqel_seller/utilities/preference.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<BaseModel<VendorDetail>>? vendorDetailFuture;

  @override
  void initState() {
    super.initState();
    vendorDetailFuture = getVendorDetails();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: .2,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/background.png'))),
          child: FutureBuilder<BaseModel<VendorDetail>>(
            future: vendorDetailFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return DeviceUtils.showProgress(true);
                } else {
                  DeviceUtils.showProgress(false);
                  var data = snapshot.data!.data!.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: kToolbarHeight + 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    data.vendorLogo!,
                                    fit: BoxFit.contain,
                                    height: 90,
                                    width: 90,
                                  )),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.6,
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    SharedPreferenceHelper.getString(
                                        Preferences.name),
                                    style: TextStyle(
                                        color: Palette.loginhead,
                                        fontSize: 16,
                                        fontFamily: proxima_nova_bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  Text(
                                    data.address!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Palette.loginhead,
                                        fontSize: 12,
                                        fontFamily: proxima_nova_reg),
                                  ),
                                  /* SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.005,
                            ),
                            Text(
                              data.,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Palette.switchs,
                                  fontSize: 10,
                                  fontFamily: proxima_nova_reg),
                            )*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 15,
                        endIndent: 25,
                        color: Palette.profliedivider,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListTile(
                          leading:
                              SvgPicture.asset("assets/images/profileedit.svg"),
                          title: Text(
                            getTranslated(context, edit_profile)!,
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaNova",
                                fontSize: 15),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Palette.loginhead,
                            size: 30,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileEditScreen(data)));
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 15,
                        endIndent: 25,
                        color: Palette.profliedivider,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListTile(
                          leading: SvgPicture.asset(
                              "assets/images/profilebalance.svg"),
                          title: Text(
                            getTranslated(context, my_cash_balance)!,
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaNova",
                                fontSize: 15),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Palette.loginhead,
                            size: 30,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CashBalanceScreen()));
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 15,
                        endIndent: 25,
                        color: Palette.profliedivider,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListTile(
                          leading: SvgPicture.asset(
                              "assets/images/profileearning.svg"),
                          title: Text(
                            getTranslated(context, earning_history)!,
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaNova",
                                fontSize: 15),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Palette.loginhead,
                            size: 30,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EarningHistoryScreen()));
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 15,
                        endIndent: 25,
                        color: Palette.profliedivider,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListTile(
                          leading: SvgPicture.asset(
                              "assets/images/profilelanguage.svg"),
                          title: Text(
                            getTranslated(context, change_app_language)!,
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaNova",
                                fontSize: 15),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Palette.loginhead,
                            size: 30,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeLanguageScreen()));
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 15,
                        endIndent: 25,
                        color: Palette.profliedivider,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListTile(
                          leading:
                              SvgPicture.asset("assets/images/profilefaq.svg"),
                          title: Text(
                            getTranslated(context, fAQs)!,
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: "ProximaNova",
                                fontSize: 15),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Palette.loginhead,
                            size: 30,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FaqScreen()));
                          },
                        ),
                      ),
                      /*Divider(
                  height: 1,
                  thickness: 1,
                  indent: 15,
                  endIndent: 25,
                  color: Palette.profliedivider,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListTile(
                    leading:
                    SvgPicture.asset("assets/images/profileprivacy.svg"),
                    title: Text(
                  "Privacy Policy",
                  style: TextStyle(
                      color: Palette.loginhead,
                      fontFamily: "ProximaNova",
                      fontSize: 15),
                    ),
                    trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Palette.loginhead,
                  size: 30,
                    ),
                    onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen()));
                    },
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 15,
                  endIndent: 25,
                  color: Palette.profliedivider,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListTile(
                    leading: SvgPicture.asset("assets/images/profileterms.svg"),
                    title: Text(
                  "Terms of Use",
                  style: TextStyle(
                      color: Palette.loginhead,
                      fontFamily: "ProximaNova",
                      fontSize: 15),
                    ),
                    trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Palette.loginhead,
                  size: 30,
                    ),
                    onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsScreen()));
                    },
                  ),
                ),*/
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 15,
                        endIndent: 25,
                        color: Palette.profliedivider,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListTile(
                          leading: SvgPicture.asset(
                              "assets/images/profileprivacy.svg"),
                          title: Text(
                            getTranslated(context, change_password)!,
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: proxima_nova_reg,
                                fontSize: 15),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Palette.loginhead,
                            size: 30,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen()));
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 15,
                        endIndent: 25,
                        color: Palette.profliedivider,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListTile(
                          leading: SvgPicture.asset(
                              "assets/images/profilesignout.svg"),
                          title: Text(
                            getTranslated(context, sign_out)!,
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontFamily: proxima_nova_reg,
                                fontSize: 15),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Palette.loginhead,
                            size: 30,
                          ),
                          onTap: () {
                            SharedPreferenceHelper.clearPref();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        indent: 15,
                        endIndent: 25,
                        color: Palette.profliedivider,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Center(child: Image.asset("assets/images/logo.png")),
                      Center(
                          child: Text(
                        "Version 1.0.0",
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontFamily: "ProximaNova",
                            fontSize: 11),
                      )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ],
                  );
                }
              } else {
                return DeviceUtils.showProgress(true);
              }
            },
          )),
    );
  }
}
