import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.brown,
    brightness: Brightness.light,
  );

  static ThemeData darkThemeData(BuildContext context) => ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static BottomNavigationBarItem getbottomNavItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );
  }

  static TextStyle headingStyle = TextStyle(
    fontSize: 18,
  );
}
