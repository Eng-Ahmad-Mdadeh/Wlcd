import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/constants/app_storage_paths.dart';
import 'package:wlcd/core/helper/network_helper.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit({
    required FlutterSecureStorage storage,
    Locale initialLocale = const Locale('ar'),
  }) : _storage = storage,
       super(initialLocale) {
    NetworkHelper().setLanguage(initialLocale.languageCode);
  }

  static const List<String> supportedLocales = ['ar', 'en'];

  final FlutterSecureStorage _storage;

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale.languageCode)) {
      return;
    }
    if (state.languageCode == locale.languageCode) {
      return;
    }
    final normalizedLocale = Locale(locale.languageCode);
    NetworkHelper().setLanguage(normalizedLocale.languageCode);
    emit(normalizedLocale);
    try {
      await _storage.write(
        key: AppStoragePaths.lang,
        value: normalizedLocale.languageCode,
      );
    } catch (_) {
      // Keep the in-memory locale usable when secure storage is unavailable.
    }
  }
}
