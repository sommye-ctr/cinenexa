import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/models/sort_movies.dart';
import 'package:watrix/models/sort_tv.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/services/constants.dart';

class Utils {
  static String getPosterUrl(String url, {String? posterSize}) {
    return "${Constants.imageBaseUrl}${posterSize ?? Constants.posterSize}${url}";
  }

  static String getBackdropUrl(String url) {
    return "${Constants.imageBaseUrl}${Constants.backdropSize}${url}";
  }

  static String getStillUrl(String url) {
    return "${Constants.imageBaseUrl}${Constants.stillSize}$url";
  }

  static String getSortMoviesBy(SortMoviesBy sortMoviesBy) {
    switch (sortMoviesBy) {
      case SortMoviesBy.popularity:
        return "popularity.desc";
      case SortMoviesBy.releaseDate:
        return "release_date.desc";
      case SortMoviesBy.voteAverage:
        return "vote_average.desc";
    }
  }

  static String getSortTvBy(SortTvBy sortTvBy) {
    switch (sortTvBy) {
      case SortTvBy.popularity:
        return "popularity.desc";
      case SortTvBy.firstAirDate:
        return "first_air_date.desc";
      case SortTvBy.voteAverage:
        return "vote_average.desc";
    }
  }

  static String getEntityTypeBy(BaseModelType baseModelType) {
    switch (baseModelType) {
      case BaseModelType.movie:
        return Strings.movie;
      case BaseModelType.people:
        return Strings.actor;
      case BaseModelType.tv:
        return Strings.tvShow;
    }
  }

  static Color getColorByEntity(BaseModelType baseModelType) {
    switch (baseModelType) {
      case BaseModelType.movie:
        return Colors.green;
      case BaseModelType.people:
        return Colors.amber;
      case BaseModelType.tv:
        return Colors.cyan;
    }
  }

  static List<BaseModel> convertToListString(var parsedList) {
    return (parsedList as List).map((e) => BaseModel.fromMap(e)).toList();
  }

  static List<BaseModel> convertToListStringWithSkipLimit(
      var parsedList, int limit, int skip) {
    return (parsedList as List)
        .sublist(
          skip,
          limit,
        )
        .map((e) => BaseModel.fromMap(e))
        .toList();
  }
}
