import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:alnaqel_user/model/cartmodel.dart';
import 'package:alnaqel_user/screens/splash_screen.dart';
import 'package:alnaqel_user/utils/SharedPreferenceUtil.dart';
import 'package:alnaqel_user/utils/constants.dart';
import 'package:alnaqel_user/utils/localization/localizations_delegate.dart';
import 'package:alnaqel_user/utils/preference_utils.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:scoped_model/scoped_model.dart';
import 'utils/localization/locale_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  await SharedPreferenceUtil.getInstance();
  runApp(MyApp(
    model: CartModel(),
  ));
}

class MyApp extends StatefulWidget {
  final CartModel model;

  const MyApp({Key? key, required this.model}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    PreferenceUtils.init();
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: true,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      child: ScopedModel<CartModel>(
        model: widget.model,
        child: MaterialApp(
          locale: _locale,
          supportedLocales: [
            Locale('en', ''),
            Locale('ar', ''),
          ],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color(Constants.colorBackground),
            accentColor: Color(Constants.colorTheme),
          ),
          home: SplashScreen(
            model: widget.model,
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
