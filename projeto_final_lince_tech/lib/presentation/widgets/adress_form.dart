import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'commom_label.dart';

class AdressForm extends StatelessWidget {
  const AdressForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(children: [CommomLabel(text: 'implemente')]);
  }
}
