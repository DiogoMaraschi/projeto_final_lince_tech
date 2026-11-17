import '../../l10n/app_localizations.dart';
String? validateEmail(String? value, AppLocalizations l10n) {
  if (value == null || value.trim().isEmpty) {
    return l10n.emailRequired;
  }

  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  if (!emailRegex.hasMatch(value)) {
    return l10n.emailInvalid;
  }

  return null;
}
