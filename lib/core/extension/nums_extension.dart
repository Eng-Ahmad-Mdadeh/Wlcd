import 'package:intl/intl.dart';

extension NumsExtension on num {
  String toStringAsFixedWithCheck(int fractionDigits) {
    final number = toStringAsFixed(fractionDigits);
    if (number.contains('.')) {
      String fractionalPart = number.split('.').last;
      if (fractionalPart.isNotEmpty) {
        if (fractionalPart[0] != '0') {
          return number;
        } else {
          return number.split('.').first;
        }
      } else {
        return toString();
      }
    } else {
      return toString();
    }
  }

  String toShortPrice(int fractionDigits) {
    if (this > 1000 && this < 999999) {
      return '${(this / 1000).ceil()} K';
    }
    if (this > 999999) {
      return '${(this / 999999).ceil()} M';
    }
    return toStringAsFixedWithCheck(fractionDigits);
  }

  String toCommaSeparated() {
    final formatter = NumberFormat('#,###');
    return formatter.format(this);
  }
}
