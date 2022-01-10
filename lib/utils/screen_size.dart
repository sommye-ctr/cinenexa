import 'package:flutter/widgets.dart';

class ScreenSize {
  static Size _getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getPercentOfHeight(BuildContext context, double percent) {
    return _getScreenSize(context).height * percent;
  }

  static double getPercentOfWidth(BuildContext context, double percent) {
    return _getScreenSize(context).width * percent;
  }
}
