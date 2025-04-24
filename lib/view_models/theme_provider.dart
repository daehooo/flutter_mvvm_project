import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{

  ThemeData _themeMode = MyThemeData.lightTheme;
  ThemeData get themeData => _themeMode;

  final String themeKey = "themeKey";

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(themeKey) ?? true;
    _themeMode = isDarkMode ? MyThemeData.lightTheme : MyThemeData.darkTheme;
    notifyListeners();
  }
  
  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _themeMode == MyThemeData.darkTheme ? MyThemeData.lightTheme : MyThemeData.darkTheme;
    prefs.setBool(themeKey, _themeMode == MyThemeData.darkTheme);
    notifyListeners();
  }
}