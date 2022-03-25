import 'dart:ui';

import 'package:e_agri_farmers/constants/lang/language.dart';
import 'package:e_agri_farmers/localization/lang_constants.dart';
import 'package:flutter/cupertino.dart';

import '../main.dart';

class ChangeLang{
  static Future<void> changeLanguage(Language language , BuildContext context) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }
}