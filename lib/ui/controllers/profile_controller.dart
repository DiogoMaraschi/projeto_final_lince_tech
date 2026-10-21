import 'package:flutter/cupertino.dart';

import '../../core/storage/preferences_service.dart';
import '../../entities/profile.dart';
import '../../modules/profile/usecases/get_profile_usecase.dart';

class ProfileController with ChangeNotifier {
  Profile? _profile;
  final PreferencesService preferences;
  final GetProfileUsecase _getProfileUsecase;

  ProfileController({
    required this.preferences,
    required GetProfileUsecase getProfileUsecase,
  }) : _getProfileUsecase = getProfileUsecase;

  bool _isDark = false;
  Locale _locale = const Locale('pt');


  bool get isDark => _isDark;

  Locale get locale => _locale;

  Profile? get profile => _profile;

  void loadTheme() {
    _isDark = preferences.getTheme();
    _locale = Locale(preferences.getLanguage());
  }

  Future<void> setDarkMode(bool value) async {
    _isDark = value;
    await preferences.saveTheme(_isDark);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    await preferences.saveLanguage(languageCode);
    notifyListeners();
  }

  String getFirstWord() {
    final name = _profile?.name.trim() ?? '';

    if (name.isEmpty) return '';

    return name.substring(0, 1).toUpperCase();
  }
  Future<void> loadProfile() async {
    try {
      _profile = await _getProfileUsecase();
      notifyListeners();
    } catch (e) {
      print('Erro ao carregar perfil: $e');
    }
  }
}
