import 'package:flutter/rendering.dart';

import '../resources/strings.dart';

class SettingsIndexer {
  static int getMaxCache(int maxCacheIndex) {
    switch (maxCacheIndex) {
      case 0:
        return 50;
      case 1:
        return 200;
      case 2:
        return 500;
      case 3:
        return 1000;
      case 4:
        return 2000;
      case 5:
        return 5000;
      case 6:
        return 10000;
      default:
        throw UnimplementedError("No cache index found!");
    }
  }

  static BoxFit getFit(int value) {
    if (value == 0) {
      return BoxFit.contain;
    } else if (value == 1) {
      return BoxFit.fill;
    } else if (value == 2) {
      return BoxFit.cover;
    }
    throw UnimplementedError("No fit index found");
  }

  static double getSpeed(int index) {
    double speed = 1;
    if (index == 0) {
      speed = 0.5;
    } else if (index == 1) {
      speed = 1;
    } else if (index == 2) {
      speed = 1.5;
    } else if (index == 3) {
      speed = 2;
    }
    return speed;
  }

  static Map<int, double> getSpeedFromValue(String value) {
    double speed = 1;
    int index = 1;
    if (value == Strings.playbackSpeeds[0]) {
      speed = 0.5;
      index = 0;
    } else if (value == Strings.playbackSpeeds[1]) {
      speed = 1;
      index = 1;
    } else if (value == Strings.playbackSpeeds[2]) {
      speed = 1.5;
      index = 2;
    } else if (value == Strings.playbackSpeeds[3]) {
      speed = 2;
      index = 3;
    }
    return {index: speed};
  }

  static Map<int, BoxFit> getFitFromValue(String value) {
    BoxFit boxFit = BoxFit.contain;
    int index = 0;

    if (value == Strings.fitTypes[0]) {
      boxFit = BoxFit.contain;
      index = 0;
    } else if (value == Strings.fitTypes[1]) {
      boxFit = BoxFit.fill;
      index = 1;
    } else if (value == Strings.fitTypes[2]) {
      boxFit = BoxFit.cover;
      index = 2;
    }

    return {index: boxFit};
  }
}
