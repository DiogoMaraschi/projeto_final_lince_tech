import 'package:flutter/material.dart';
import 'package:projeto_final_lince_tech/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'core/dependencies/injection.dart';
import 'ui/app_colors.dart';
import 'ui/controllers/profile_controller.dart';
import 'ui/pages/carrier_details.dart';
import 'ui/pages/carrier_list.dart';
import 'ui/pages/costumer_list.dart';
import 'ui/pages/main_navigation_page.dart';
import 'ui/pages/product_details.dart';
import 'ui/pages/product_list.dart';
import 'ui/pages/profile.dart';
import 'ui/pages/profile_details.dart';
import 'ui/widgets/carrier_card.dart';
import 'ui/widgets/product_card.dart';

late final Injection injection;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  injection = Injection();
  await injection.inicialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ProfileController(
              preferences: injection.preferencesService,
              getProfileUsecase: injection.getProfileUsecase,
            )
            ..loadTheme()
            ..loadProfile(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<ProfileController>();

    return MaterialApp(
      title: 'Gestão de Produtos',

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: settings.locale,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      themeMode: settings.isDark ? ThemeMode.dark : ThemeMode.light,

      home: const MainNavigationPage(),
    );
  }
}

class _initialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CustomerListPage()),
            ),
            child: Text('Clientes'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CarrierListPage()),
            ),
            child: Text('Transportadoras'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductListPage()),
            ),
            child: Text('Produtos'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfilePage()),
            ),
            child: Text('Perfil'),
          ),
        ],
      ),
    );
  }
}
