//Step 1
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Step 2
class AppLocalization {
  //Step 3
  late final Locale _locale;
  AppLocalization(this._locale);

//Step 4
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

//Step 5
  late Map<String, String> _localizedValues;

  Future loadLanguage() async {
    String jsonStringValues =
        await rootBundle.loadString('asset/lang/${_locale.languageCode}.json');
    Map<String, dynamic> mappedValues = json.decode(jsonStringValues);

    _localizedValues =
        mappedValues.map((key, value) => MapEntry(key, value.toString()));
  }

//Step 6
  String? getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();
}

//Step 7

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ne', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.loadLanguage();
    return appLocalization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
