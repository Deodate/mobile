import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'themeMode';
  late SharedPreferences _prefs; // Marking _prefs as late
  late ThemeMode _themeMode; // Marking _themeMode as late

  ThemeProvider() {
    _themeMode = ThemeMode.system;
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    bool isDark = _prefs.getBool(_themeKey) ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    await _prefs.setBool(_themeKey, _themeMode == ThemeMode.dark);
  }
}
