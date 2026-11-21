import '../../core/utils/digits_only.dart';
import '../../l10n/app_localizations.dart';

String? validatePositiveMoney(String? value, AppLocalizations l10n) {
  final digits = digitsOnly(value ?? '');

  if (digits.isEmpty || int.parse(digits) <= 0) {
    return l10n.moneyMustBePositive;
  }

  return null;
}
