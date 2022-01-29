import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.brown,
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
