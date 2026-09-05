import 'package:flutter/material.dart';
import 'package:projeto_final_lince_tech/l10n/app_localizations.dart';
import 'package:projeto_final_lince_tech/presentation/pages/product_details.dart';

import 'global.dart';

void main() {
  inicialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Produtos',

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),

      home: const ProductDetails(),
    );
  }
}
