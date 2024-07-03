import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _prefs;
  late bool _isDarkTheme;

  bool get isDarkTheme => _isDarkTheme;

  ThemeNotifier() {
    _isDarkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    _isDarkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _isDarkTheme);
  }
}
