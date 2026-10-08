import 'package:flutter/widgets.dart';

import '../../entities/customer.dart';
import '../../l10n/app_localizations.dart';

extension EstablishmentTypeLocalization on EstablishmentType {
  String translate(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      EstablishmentType.academia => l10n.costumerCategoryGym,
      EstablishmentType.escola => l10n.costumerCategorySchool,
      EstablishmentType.outro => l10n.costumerCategoryOther,
    };
  }
}
