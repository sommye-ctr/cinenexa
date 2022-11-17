import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/utils/screen_size.dart';

import '../components/movie_tile.dart';
import '../services/constants.dart';
import '../services/network/utils.dart';
import '../widgets/rounded_image_placeholder.dart';

class Style {
  static double movieTileWithTitleRatio = 1 / 1.6;
  static double largeRoundEdgeRadius = 16;
  static double smallRoundEdgeRadius = 8;
  static double cardElevation = 8;

  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.orange,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    focusColor: Colors.black,
    scaffoldBackgroundColor: Color.fromARGB(255, 249, 246, 246),
    backgroundColor: Color.fromARGB(255, 249, 246, 246),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
    ),
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
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
      );

  static BottomNavigationBarItem getbottomNavItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );
  }

  static void showSnackBar(
      {required BuildContext context, required String text}) {
    final snack = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      shape: StadiumBorder(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  static Widget getChip(context, String text) {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenSize.getPercentOfWidth(context, 0.01),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
          color: Colors.grey.withOpacity(0.4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
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

  static Widget getMovieTile({
    required BaseModel item,
    required double widhtPercent,
    required bool showTitle,
    required BuildContext context,
    required Function(BaseModel) onClick,
  }) {
    return MovieTile(
      image: Utils.getPosterUrl(item.posterPath ?? ""),
      text: item.title!,
      width: ScreenSize.getPercentOfWidth(context, widhtPercent),
      showTitle: showTitle,
      onClick: () => onClick(item),
    );
  }

  static double getMovieTileHeight({
    required BuildContext context,
    required double widthPercent,
  }) {
    return ScreenSize.getPercentOfWidth(context, widthPercent) /
        Constants.posterAspectRatio;
  }

  static Widget getMovieTilePlaceHolder({
    required BuildContext context,
    required double widthPercent,
  }) {
    return RoundedImagePlaceholder(
      width: ScreenSize.getPercentOfWidth(context, widthPercent),
      ratio: Constants.posterAspectRatio,
    );
  }

  static Widget getActorTile({
    required BuildContext context,
    required String? poster,
    required String? title,
    required VoidCallback callback,
  }) {
    int length = title?.length ?? 0;
    return GestureDetector(
      onTap: callback,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider(Utils.getPosterUrl(poster ?? "")),
            radius: ScreenSize.getPercentOfWidth(context, 0.15),
          ),
          Text(
            (length >= 15 ? "${title?.substring(0, 10)}..." : title) ?? "",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  static void showLoadingDialog({
    required BuildContext context,
  }) {
    AwesomeDialog(
      context: context,
      autoDismiss: false,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: Colors.transparent,
      body: Center(
        child: CircularProgressIndicator(),
      ),
      padding: EdgeInsets.all(8),
      useRootNavigator: true,
      onDismissCallback: (DismissType type) {},
    )..show();
  }
}
