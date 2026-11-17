import '../../l10n/app_localizations.dart';
import 'not_empty_validator.dart';

String? validateCnpj(String? value, AppLocalizations l10n) {
  final requiredError = isNotEmpty(value, l10n);

  if (requiredError != null) {
    return requiredError;
  }

  final cnpj = value!.replaceAll(RegExp(r'\D'), '');

  if (cnpj.length != 14) {
    return l10n.cnpjDigitsInvalid;
  }

  if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) {
    return l10n.cnpjInvalid;
  }

  int calculateDigit(String value) {
    final weights = value.length == 12
        ? [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        : [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

    var sum = 0;

    for (var i = 0; i < value.length; i++) {
      sum += int.parse(value[i]) * weights[i];
    }

    final remainder = sum % 11;

    return remainder < 2 ? 0 : 11 - remainder;
  }

  final firstDigit = calculateDigit(cnpj.substring(0, 12));

  if (firstDigit != int.parse(cnpj[12])) {
    return l10n.cnpjInvalid;
  }

  final secondDigit = calculateDigit(cnpj.substring(0, 13));

  if (secondDigit != int.parse(cnpj[13])) {
    return l10n.cnpjInvalid;
  }

  return null;
}
