import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _themeKey = 'theme';
  static const String _languageKey = 'language';

  final SharedPreferences preferences;

  PreferencesService({required this.preferences});

  // Theme
  Future<void> saveTheme(bool isDark) async {
    await preferences.setBool(_themeKey, isDark);
  }

  bool getTheme() {
    return preferences.getBool(_themeKey) ?? false;
  }

  //Language
  Future<void> saveLanguage(String language) async {
    await preferences.getString(_languageKey);
  }

  String getLanguage() {
    return preferences.getString(_languageKey) ?? 'pt';
  }
}
