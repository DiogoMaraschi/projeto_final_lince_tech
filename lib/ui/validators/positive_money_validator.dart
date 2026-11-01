import '../formatters/app_formatters.dart';

String? validatePositiveMoney(String? value) {
  final digits = AppFormatters.onlyNumber(value ?? '');

  if (digits.isEmpty || int.parse(digits) <= 0) {
    return 'Informe um valor maior que zero';
  }

  return null;
}
