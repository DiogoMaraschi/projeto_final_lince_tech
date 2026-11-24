import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

enum _ImageSourceOption { camera, gallery, remove }

Future<void> showImageSourceOptions(
  BuildContext context, {
  required Future<void> Function() onCameraSelected,
  required Future<void> Function() onGallerySelected,
  required VoidCallback onRemoveSelected,
  required bool hasPath,
}) async {
  final option = await showModalBottomSheet<_ImageSourceOption>(
    context: context,
    builder: (sheetContext) {
      final l10n = AppLocalizations.of(context)!;

      final children = <Widget>[
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined),
          title: Text(l10n.imageSourceTakePhoto),
          onTap: () => Navigator.pop(sheetContext, _ImageSourceOption.camera),
        ),
        ListTile(
          leading: const Icon(Icons.photo_library_outlined),
          title: Text(l10n.imageSourceChooseGallery),
          onTap: () => Navigator.pop(sheetContext, _ImageSourceOption.gallery),
        ),

        if (hasPath)
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: Text(l10n.removeImage),
            onTap: () => Navigator.pop(sheetContext, _ImageSourceOption.remove),
          ),
      ];

      return SafeArea(child: Wrap(children: children));
    },
  );

  if (!context.mounted || option == null) return;

  switch (option) {
    case _ImageSourceOption.camera:
      await onCameraSelected();
    case _ImageSourceOption.gallery:
      await onGallerySelected();
    case _ImageSourceOption.remove:
      onRemoveSelected();
  }
}
