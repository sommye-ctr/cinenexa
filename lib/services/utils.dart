import 'package:flutter/cupertino.dart';
import 'package:watrix/services/constants.dart';

import '../models/movie.dart';
import '../models/people.dart';
import '../models/tv.dart';

class Utils {
  static String getItemPoster<T>(T item) {
    String url;
    if (item is Movie) {
      url = (item).posterPath;
    } else if (item is Tv) {
      url = (item).posterPath;
    } else if (item is People) {
      url = (item).profilePath;
    } else {
      throw new FlutterError("The type is unidentified!");
    }
    return url;
  }

  static String getItemBackdrop<T>(T item) {
    String url;
    if (item is Movie) {
      url = (item).backdropPath;
    } else if (item is Tv) {
      url = (item).backdropPath;
    } else {
      throw new FlutterError("The type is unidentified!");
    }
    return url;
  }

  static String getItemName<T>(T item) {
    String name;
    if (item is Movie) {
      name = (item).title;
    } else if (item is Tv) {
      name = (item).name;
    } else if (item is People) {
      name = (item).name;
    } else {
      throw new FlutterError("The type is unidentified.");
    }
    return name;
  }

  static String getPosterUrl(String url) {
    return "${Constants.imageBaseUrl}${Constants.posterSize}${url}";
  }

  static String getBackdropUrl(String url) {
    return "${Constants.imageBaseUrl}${Constants.backdropSize}${url}";
  }
}
