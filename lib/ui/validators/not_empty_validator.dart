import '../../l10n/app_localizations.dart';
String? isNotEmpty(String? value, AppLocalizations l10n) {
  if (value == null || value.trim().isEmpty) {
    return l10n.commonRequired;
  }
  return null;
}
