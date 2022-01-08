import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.red,
  );

  static BottomNavigationBarItem getbottomNavItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );
  }
}
