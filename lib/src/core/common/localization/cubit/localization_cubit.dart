import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart'
    show appLanguages;

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final SharedPreferences sharedPreferences;
  static const String _localeKey = 'app_locale';

  LocalizationCubit({required this.sharedPreferences, required Locale locale})
    : super(LocalizationState(locale: locale));

  Future<void> changeAppLanguage(Locale locale) async {
    await sharedPreferences.setString(_localeKey, locale.languageCode);
    emit(LocalizationState(locale: locale));
  }

  void getSavedLocale() {
    final savedLocale = sharedPreferences.getString(_localeKey);
    if (savedLocale != null) {
      emit(LocalizationState(locale: Locale(savedLocale)));
    } else {
      emit(LocalizationState(locale: appLanguages[0]));
    }
  }
}
