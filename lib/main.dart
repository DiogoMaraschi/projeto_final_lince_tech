import 'package:flutter/material.dart';
import 'package:projeto_final_lince_tech/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'core/dependencies/injection.dart';
import 'ui/app_theme.dart';
import 'ui/controllers/profile/profile_controller.dart';
import 'ui/pages/main_navigation_page.dart';

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
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: settings.locale,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      themeMode: settings.isDark ? ThemeMode.dark : ThemeMode.light,

      home: MainNavigationPage(),
    );
  }
}
