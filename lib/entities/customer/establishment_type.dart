import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

enum EstablishmentType {
  academia,
  escola,
  outro;

  String translate(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return switch (this) {
      academia => l10n!.costumerCategoryGym,
      escola => l10n!.costumerCategorySchool,
      outro => l10n!.costumerCategoryOther,
    };
  }

  String get databaseValue {
    return switch (this) {
      EstablishmentType.academia => 'academia',
      EstablishmentType.escola => 'escola',
      EstablishmentType.outro => 'outro',
    };
  }

  static EstablishmentType fromDatabaseValue(String value) {
    return switch (value) {
      'academia' => EstablishmentType.academia,
      'escola' => EstablishmentType.escola,
      'outro' => EstablishmentType.outro,
      _ => throw ArgumentError('Tipo de estabelecimento inválido: $value'),
    };
  }
}
