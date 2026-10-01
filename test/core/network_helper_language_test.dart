import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/core/helper/network_helper.dart';

void main() {
  group('NetworkHelper language headers', () {
    test('updates every supported API language header together', () {
      final network = NetworkHelper()..setLanguage('en');

      expect(network.dio.options.headers['Accept-Language'], 'en');
      expect(network.dio.options.headers['language'], 'en');
      expect(network.dio.options.headers['lang'], 'en');
    });

    test('normalizes unsupported locale codes to Arabic', () {
      final network = NetworkHelper()..setLanguage('fr');

      expect(network.dio.options.headers['Accept-Language'], 'ar');
      expect(network.dio.options.headers['language'], 'ar');
      expect(network.dio.options.headers['lang'], 'ar');
    });
  });
}
