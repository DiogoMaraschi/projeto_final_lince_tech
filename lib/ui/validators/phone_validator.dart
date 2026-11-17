import '../../l10n/app_localizations.dart';
String? validatePhone(String? value, AppLocalizations l10n) {
  if (value == null || value.trim().isEmpty) {
    return l10n.phoneRequired;
  }

  final phone = value.replaceAll(RegExp(r'\D'), '');

  if (phone.length != 10 && phone.length != 11) {
    return l10n.phoneInvalid;
  }

  return null;
}
