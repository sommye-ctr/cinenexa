import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watrix/utils/screen_size.dart';

class Style {
  static double movieTileWithTitleRatio = 1 / 1.6;
  static double largeRoundEdgeRadius = 16;
  static double smallRoundEdgeRadius = 8;

  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.orange,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    focusColor: Colors.black,
    scaffoldBackgroundColor: Color.fromARGB(255, 249, 246, 246),
  );

  static TextStyle headingStyle = TextStyle(
    fontSize: 20,
  );

  static ThemeData darkThemeData(BuildContext context) => ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
        focusColor: Colors.white,
        scaffoldBackgroundColor: Color.fromARGB(255, 27, 27, 27),
        backgroundColor: Color.fromARGB(255, 27, 27, 27),
      );

  static BottomNavigationBarItem getbottomNavItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );
  }

  static Widget getVerticalSpacing(
      {required BuildContext context, double? percent}) {
    return SizedBox(
      height: ScreenSize.getPercentOfHeight(context, percent ?? 0.02),
    );
  }

  static Widget getVerticalHorizontalSpacing(
      {required BuildContext context, double? percent}) {
    return SizedBox(
      height: ScreenSize.getPercentOfHeight(context, percent ?? 0.02),
      width: ScreenSize.getPercentOfWidth(context, percent ?? 0.02),
    );
  }
}
