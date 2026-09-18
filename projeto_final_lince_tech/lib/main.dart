import 'package:flutter/material.dart';
import 'package:projeto_final_lince_tech/l10n/app_localizations.dart';
import 'core/dependecies/injection.dart';
import 'presentation/pages/carrier_details.dart';
import 'presentation/pages/product_details.dart';

late final Injection injection;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  injection = Injection();

  await injection.inicialize();

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

      home: const CarrierDetails(),
    );
  }
}
