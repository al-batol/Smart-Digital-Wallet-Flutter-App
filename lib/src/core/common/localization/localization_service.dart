import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static List<Locale> get supportedLanguages =>
      const _AppLocalizationsDelegate().supportedLanguages;
  bool isSupported(Locale type) =>
      const _AppLocalizationsDelegate().isSupported(type);

  late Map<String, String> _localizedValues;

  Future<void> load() async {
    // String jsonStringValues = await rootBundle.loadString(
    //   'assets/i18n/${locale.languageCode}.json',
    // );
    // Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    // _localizedValues = mappedJson.map(
    //   (key, value) => MapEntry(key, value.toString()),
    // );
  }

  String translate(String? key) {
    throwIf(_localizedValues[key] == null, 'key [$key] is missing');
    return _localizedValues[key!]!;
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationsDelegate();

  List<Locale> get supportedLanguages => appLanguages;

  @override
  bool isSupported(Locale locale) {
    List<String?> languageString = [];
    for (var language in appLanguages) {
      languageString.add(language.languageCode);
    }
    return languageString.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}

extension AppLocalizationService on BuildContext {
  String translate(String key) {
    try {
      return AppLocalization.of(this)!.translate(key);
    } catch (e) {
      return key;
    }
  }
}
