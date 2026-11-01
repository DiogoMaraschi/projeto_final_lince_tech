import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppFormatters {
  AppFormatters._();

  static MaskTextInputFormatter cnpj() {
    return MaskTextInputFormatter(
      mask: '##.###.###/####-##',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter phone() {
    return MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  static CurrencyTextInputFormatter money() {
    return CurrencyTextInputFormatter.currency(
      locale: 'pt_BR',
      symbol: 'R\$ ',
      decimalDigits: 2,
      enableNegative: false,
    );
  }

  static String onlyNumber(String valor) {
    return valor.replaceAll(RegExp(r'\D'), '');
  }

  static MaskTextInputFormatter zipcode() {
    return MaskTextInputFormatter(
      mask: '#####-###',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  static String formatCnpj(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }

    final digits = onlyNumber(value);

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
}