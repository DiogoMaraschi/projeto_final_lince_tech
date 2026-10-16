import 'package:flutter/cupertino.dart';

import '../../core/storage/preferences_service.dart';

class ProfileController with ChangeNotifier{
  final PreferencesService preferences;

  ProfileController({required this.preferences});

  String? _imagePath;
  bool _isDark = false;
  Locale _locale = const Locale('pt');

  String? get imagePath => _imagePath;
  bool get isDark => _isDark;
  Locale get locale => _locale;

  void load(){
    _isDark = preferences.getTheme();
    _locale = Locale(preferences.getLanguage());
  }

  Future<void> setDarkMode(bool value) async{
    _isDark = value;
    await preferences.saveTheme(_isDark);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async{
    _locale = Locale(languageCode);
    await preferences.saveLanguage(languageCode);
    notifyListeners();
  }

  String getFirstWord(){
    return 'D';
  }
}