import 'package:intl/intl.dart';

import '../utils/digits_only.dart';

class DisplayFormatters {
  DisplayFormatters._();

  static String formatCnpj(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }

    final digits = digitsOnly(value);

    if (digits.length != 14) {
      return value;
    }

    return '${digits.substring(0, 2)}.'
        '${digits.substring(2, 5)}.'
        '${digits.substring(5, 8)}/'
        '${digits.substring(8, 12)}-'
        '${digits.substring(12, 14)}';
  }

  static String formatMoney(num? value) {
    if (value == null) return '';

    return NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    ).format(value);
  }

  static String formatDate(String? value) {
    if (value == null || value.isEmpty) return '';

    final date = DateTime.tryParse(value);
    if (date == null) return value;

    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  static String formatPhone(String? value) {
    if (value == null || value.trim().isEmpty) return '';

    final digits = digitsOnly(value);

    if (digits.length == 10) {
      return '(${digits.substring(0, 2)}) '
          '${digits.substring(2, 6)}-'
          '${digits.substring(6)}';
    }

    if (digits.length == 11) {
      return '(${digits.substring(0, 2)}) '
          '${digits.substring(2, 7)}-'
          '${digits.substring(7)}';
    }

    return value;
  }
}
