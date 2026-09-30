import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/core/helper/network_helper.dart';
import 'package:wlcd/presentation/cubit/language/language_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  test('persists locale and updates all language request headers', () async {
    const storage = FlutterSecureStorage();
    final networkHelper = NetworkHelper();
    final cubit = LanguageCubit(storage: storage, networkHelper: networkHelper);

    await cubit.setLocale(const Locale('en'));

    expect(cubit.state, const Locale('en'));
    expect(await storage.read(key: LanguageCubit.localeKey), 'en');
    expect(networkHelper.dio.options.headers['Accept-Language'], 'en');
    expect(networkHelper.dio.options.headers['language'], 'en');
    expect(networkHelper.dio.options.headers['lang'], 'en');

    await cubit.close();
  });

  test('ignores unsupported locales', () async {
    final cubit = LanguageCubit();

    await cubit.setLocale(const Locale('fr'));

    expect(cubit.state, const Locale('ar'));
    await cubit.close();
  });
}
