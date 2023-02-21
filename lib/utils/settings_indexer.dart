import 'package:flutter/rendering.dart';

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
}
