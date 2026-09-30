import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wlcd/core/helper/network_helper.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit({
    Locale initialLocale = const Locale('ar'),
    FlutterSecureStorage storage = const FlutterSecureStorage(),
    NetworkHelper? networkHelper,
  }) : _storage = storage,
       _networkHelper = networkHelper ?? NetworkHelper(),
       super(initialLocale) {
    _networkHelper.setLanguage(initialLocale.languageCode);
  }

  static const String localeKey = 'app_locale';
  static const List<String> supportedLocales = ['ar', 'en'];

  final FlutterSecureStorage _storage;
  final NetworkHelper _networkHelper;

  Future<void> setLocale(Locale locale) async {
    final languageCode = locale.languageCode;
    if (!supportedLocales.contains(languageCode) || state.languageCode == languageCode) return;

    try {
      await _storage.write(key: localeKey, value: languageCode);
    } catch (_) {
      // A storage failure must not prevent changing language for this session.
    }
    _networkHelper.setLanguage(languageCode);
    emit(locale);
  }
}
