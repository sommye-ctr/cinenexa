import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.brown,
    brightness: Brightness.light,
  );

  static ThemeData darkThemeData = ThemeData(
    primarySwatch: Colors.orange,
    brightness: Brightness.dark,
  );

  static BottomNavigationBarItem getbottomNavItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );
  }

  static TextStyle headingStyle = TextStyle(
    fontSize: 30,
  );
}
