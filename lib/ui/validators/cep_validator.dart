import '../../l10n/app_localizations.dart';
String? validateCep(String? value, AppLocalizations l10n) {
  if (value == null || value.trim().isEmpty) {
    return l10n.cepRequired;
  }

  final cep = value.replaceAll(RegExp(r'\D'), '');

  if (cep.length != 8) {
    return l10n.cepInvalid;
  }

  return null;
}
