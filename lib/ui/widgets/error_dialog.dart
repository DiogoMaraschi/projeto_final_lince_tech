import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

Future<void> showErrorDialog(
    BuildContext context, {
      required String message,
      String? title,
    }) {
  final l10n = AppLocalizations.of(context)!;

  return showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(title ?? l10n.commonError),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}