import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alnaqel_seller/utilities/prefConstatnt.dart';
import 'package:alnaqel_seller/utilities/preference.dart';

import 'lang_localizations.dart';

String? getTranslated(BuildContext context, String key) {
  return LanguageLocalization.of(context)!.getTranslateValue(key);
}

String statusToString(String status) {
  switch (status.toLowerCase()) {
    case "incoming":
      return "الي المخزن";
      case "inwarehouse":
      return "في المخزن";
       case "exporting":
      return "خارج المخزن";
    case "approve":
      return "قبول الطلب";
    case "pickup":
      return "تم التسليم للعميل";
    case "delivered":
      return "تم التوصيل للعميل";
    case "complete":
      return "تم الموافقة";
    case "ready_for_order":
      return "الطلب جاهز للتوصيل";
    case "prepare_for_order":
      return "جاري تجهيز الطلب";
      
      case "pending":
      return "معلق";
    case "cancel":
      return "تم الالغاء";
       case "reject":
      return "تم الرفض";
    default:
      return status;
  }
}

const String ENGLISH = "en";
const String ARABIC = "ar";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferenceHelper.setString(
      Preferences.current_language_code, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;

    case ARABIC:
      _temp = Locale(languageCode, 'AE');
      break;
    default:
      _temp = Locale(ENGLISH, 'US');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  String languageCode =
      SharedPreferenceHelper.getString(Preferences.current_language_code);
  return _locale(languageCode);
}
