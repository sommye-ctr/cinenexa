import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watrix/utils/screen_size.dart';

class Style {
  static double movieTileWithTitleRatio = 1 / 1.6;
  static double largeRoundEdgeRadius = 16;
  static double smallRoundEdgeRadius = 8;

  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.brown,
    brightness: Brightness.light,
  );

  static TextStyle headingStyle = TextStyle(
    fontSize: 22,
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
