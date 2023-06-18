import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinenexa/resources/settings_tile_obj.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/utils/link_opener.dart';
import 'package:cinenexa/utils/screen_size.dart';

import '../components/mobile/movie_tile.dart';
import '../components/tv/tv_movie_tile.dart';
import '../services/constants.dart';
import '../services/network/utils.dart';
import '../widgets/rounded_image_placeholder.dart';

class Style {
  static double movieTileWithTitleRatio = 1 / 1.8;
  static double largeRoundEdgeRadius = 16;
  static double smallRoundEdgeRadius = 8;
  static double cardElevation = 8;

  static const double iconSize = 60;
  static const double smallIconSize = 40;

  static const double tvTileWidth = 0.145;

  static List<SettingsTileObj> settingTiles = [
    SettingsTileObj(
      Strings.general,
      Icons.settings,
      Color.fromRGBO(46, 196, 182, 1),
    ),
    SettingsTileObj(
      Strings.extensions,
      Icons.extension_rounded,
      Color.fromRGBO(255, 159, 28, 1),
    ),
    SettingsTileObj(
      Strings.integrations,
      Icons.merge,
      Color.fromRGBO(255, 191, 105, 1),
    ),
    SettingsTileObj(
      Strings.player,
      Icons.play_arrow_rounded,
      Color.fromRGBO(203, 243, 240, 1),
    ),
    SettingsTileObj(
      Strings.more,
      Icons.more_horiz,
      Color.fromRGBO(233, 196, 106, 1),
    ),
    SettingsTileObj(
      Strings.reportBug,
      Icons.bug_report_rounded,
      Color.fromRGBO(231, 111, 81, 1),
    ),
    SettingsTileObj(
      Strings.rateCineNexa,
      Icons.star_rounded,
      Color.fromRGBO(255, 159, 28, 1),
    ),
  ];

  static List<SettingsTileObj> tvSettingTiles = [
    SettingsTileObj(
      Strings.connectTrakt,
      Icons.merge,
      Color.fromRGBO(255, 191, 105, 1),
    ),
    SettingsTileObj(
      Strings.syncInstalledExt,
      Icons.sync_rounded,
      Color.fromRGBO(236, 192, 192, 1),
    ),
    SettingsTileObj(
      Strings.seekDuration,
      Icons.play_arrow_rounded,
      Color.fromRGBO(203, 243, 240, 1),
    ),
    SettingsTileObj(
      Strings.defaultFit,
      Icons.screen_rotation_alt_rounded,
      Color.fromRGBO(233, 196, 106, 1),
    ),
    SettingsTileObj(
      Strings.subtitle,
      Icons.closed_caption_off_rounded,
      Color.fromRGBO(255, 159, 28, 1),
    ),
    SettingsTileObj(
      Strings.logout,
      Icons.logout_rounded,
      Color.fromRGBO(46, 196, 182, 1),
    ),
    SettingsTileObj(
      Strings.rateCineNexa,
      Icons.star_rounded,
      Color.fromRGBO(255, 159, 28, 1),
    ),
  ];

  static ThemeData themeData = ThemeData(
      primarySwatch: Colors.orange,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.poppins().fontFamily,
      focusColor: Colors.black,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.orange,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.orange,
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: Colors.white,
      ),
      colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: Colors.orange,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
      ));

  static TextStyle headingStyle = TextStyle(
    fontSize: 20,
  );

  static TextStyle largeHeadingStyle = TextStyle(
    fontSize: 25,
  );

  static ThemeData darkThemeData(BuildContext context) => ThemeData(
      primarySwatch: Colors.orange,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      focusColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.orange,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.orange,
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.white,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: Colors.black,
        selectedTileColor: Colors.black,
      ),
      colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: Colors.orange,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black,
      ));

  static BottomNavigationBarItem getbottomNavItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );
  }

  static void showToast(
      {required BuildContext context,
      required String text,
      bool long = false}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );

    /* Widget toast = Card(
      elevation: 15,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(largeRoundEdgeRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Asset.icon, width: 24, height: 24),
            SizedBox(width: 12.0),
            Expanded(
                child: Text(
              text,
            )),
          ],
        ),
      ),
    );
    FToast().init(context).showToast(
          child: toast,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: long != null ? 4 : 2),
        ); */
  }

  static void showBottomSheet(context, Widget child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: child,
        );
      },
    );
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

  static Widget getListTile({
    required BuildContext context,
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 0.95),
      margin:
          EdgeInsets.only(bottom: ScreenSize.getPercentOfHeight(context, 0.01)),
      child: ListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        leading: leading,
        trailing: trailing,
        enabled: enabled,
        onTap: onTap,
      ),
    );
  }

  static Widget getCardListTile({
    required BuildContext context,
    required String title,
    Widget? leading,
  }) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 0.12),
      child: Card(
        margin: EdgeInsets.only(
            bottom: ScreenSize.getPercentOfHeight(context, 0.01)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) leading,
              SizedBox(
                height: 2,
              ),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
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

  static Widget getTvMovieTile({
    required BaseModel item,
    required double widhtPercent,
    required bool showTitle,
    required BuildContext context,
    required Function(BaseModel) onClick,
    required double scale,
    double? aspectRatio,
  }) {
    return TvMovieTile(
      image: Utils.getPosterUrl(item.posterPath ?? ""),
      text: item.title!,
      width: ScreenSize.getPercentOfWidth(context, widhtPercent),
      showTitle: showTitle,
      onClick: () => onClick(item),
      scale: scale,
      aspectRatio: aspectRatio,
    );
  }

  static double getMovieTileHeight({
    required BuildContext context,
    required double widthPercent,
  }) {
    return ScreenSize.getPercentOfWidth(context, widthPercent) /
        Constants.posterAspectRatio;
  }

  static double getMovieTileBackdropHeight({
    required BuildContext context,
    required double widthPercent,
  }) {
    return ScreenSize.getPercentOfWidth(context, widthPercent) /
        Constants.backdropAspectRatio;
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

  static Widget getMovieTileBackdropPlaceHolder({
    required BuildContext context,
    required double widthPercent,
  }) {
    return RoundedImagePlaceholder(
      width: ScreenSize.getPercentOfWidth(context, widthPercent),
      ratio: Constants.backdropAspectRatio,
    );
  }

  static Widget getActorTile({
    required BuildContext context,
    required String? poster,
    required String? title,
    required VoidCallback callback,
    double? widthPercent,
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
            radius: ScreenSize.getPercentOfWidth(context, widthPercent ?? 0.15),
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
    String? text,
  }) {
    AwesomeDialog(
      context: context,
      autoDismiss: false,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          if (text != null)
            Text(
              text,
              textAlign: TextAlign.center,
            ),
        ],
      ),
      padding: EdgeInsets.all(8),
      useRootNavigator: true,
      onDismissCallback: (DismissType type) {},
    )..show();
  }

  static void showConfirmationDialog({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Confirm"),
          content: Text(text),
          actions: [
            CupertinoDialogAction(
              child: Text("Okay"),
              onPressed: onPressed,
            ),
            CupertinoDialogAction(
              child: Text(Strings.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showExternalLinkOpenWarning({
    required BuildContext context,
    required String extensionName,
    required String url,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Warning"),
          content:
              Text("$extensionName is trying to open an external url:\n$url"),
          actions: [
            CupertinoDialogAction(
              child: Text("Open"),
              onPressed: () {
                LinkOpener.openLink(url);
              },
            ),
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
