import 'dart:io';

import 'package:alnaqel_seller/config/Palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:alnaqel_seller/routes/custome_router.dart';
import 'package:alnaqel_seller/routes/route_names.dart';
import 'package:alnaqel_seller/utilities/prefConstatnt.dart';
import 'package:alnaqel_seller/utilities/preference.dart';
import 'package:sizer/sizer.dart';

import 'localization/lang_localizations.dart';
import 'localization/localization_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   ByteData data = await PlatformAssetBundle().load('ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  await SharedPreferenceHelper.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((local) => {
          setState(() {
            this._locale = local;
          })
        });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Palette.green,
      statusBarIconBrightness: Brightness.light,
    ));
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Sizer(
        //return OrientationBuilder
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            theme: ThemeData(primaryColor: const Color(0xFF4A00E0)),
            locale: _locale,
            supportedLocales: [
              Locale(ENGLISH, 'US'),
              Locale(ARABIC, 'AE'),
            ],
            localizationsDelegates: [
              LanguageLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocal, supportedLocales) {
              for (var local in supportedLocales) {
                if (local.languageCode == deviceLocal!.languageCode &&
                    local.countryCode == deviceLocal.countryCode) {
                  return deviceLocal;
                }
              }
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            initialRoute:
                SharedPreferenceHelper.getBoolean(Preferences.is_logged_in) ==
                        true
                    ? homeRoute
                    : loginRoute,
            onGenerateRoute: CustomRouter.allRoutes,
          );
        },
      );
    }
  }
}
