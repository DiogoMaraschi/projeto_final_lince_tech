import '../../l10n/app_localizations.dart';
import '../formatters/app_formatters.dart';

String? validatePositiveMoney(String? value, AppLocalizations l10n) {
  final digits = AppFormatters.onlyNumber(value ?? '');

  if (digits.isEmpty || int.parse(digits) <= 0) {
    return l10n.moneyMustBePositive;
  }

  return null;
}
