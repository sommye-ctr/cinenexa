import 'package:flutter/cupertino.dart';

class MyTheme with ChangeNotifier {
  bool _isDarkMode = false;
  bool get darkMode => _isDarkMode;

  void changeTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
