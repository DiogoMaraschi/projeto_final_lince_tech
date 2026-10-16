import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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
}