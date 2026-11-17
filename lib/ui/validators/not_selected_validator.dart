import '../../l10n/app_localizations.dart';
String? isNotSelected<T>(T? value, AppLocalizations l10n) {
  if (value == null) {
    return l10n.commonRequired;
  }
  return null;
}
