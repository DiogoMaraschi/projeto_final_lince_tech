import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/storage/preferences_service.dart';

final Color primaryColor = const Color(0xFF4F46E5);
final Color backgroundColor = const Color(0xFFFAFAFC);
final Color hintColor = const Color(0xFFA1A1AA);
final Color labelColor = const Color(0xFF52525B);

void inicialize() async {
  final preferences = await SharedPreferences.getInstance();

  final preferencesService = PreferencesService(preferences: preferences);
}
