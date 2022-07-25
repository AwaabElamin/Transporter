import 'package:flutter/material.dart';
import 'package:alnaqel_user/utils/localization/language/languageArabic.dart';
import 'package:alnaqel_user/utils/localization/language/languageSpanish.dart';
import 'package:alnaqel_user/utils/localization/language/language_en.dart';

import 'language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageArabic();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
