import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _themeKey = 'theme_mode';
  Brightness _brightness = Brightness.light;

  ThemeProvider() {
    _loadTheme();
  }

  Brightness get brightness => _brightness;

  void toggleTheme() {
    _brightness =
        _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey) ?? 'light';
    _brightness = themeString == 'dark' ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _themeKey, _brightness == Brightness.dark ? 'dark' : 'light');
  }
}
