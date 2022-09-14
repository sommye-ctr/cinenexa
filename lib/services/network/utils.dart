import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:watrix/models/network/video.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/services/constants.dart';

import '../../models/local/enums/sort_movies.dart';
import '../../models/local/enums/sort_tv.dart';
import '../../models/network/base_model.dart';
import '../../models/network/enums/entity_type.dart';

class Utils {
  static String getPosterUrl(String url, {String? posterSize}) {
    return "${Constants.tmdbImageBase}${posterSize ?? Constants.posterSize}${url}";
  }

  static String getBackdropUrl(String url) {
    return "${Constants.tmdbImageBase}${Constants.backdropSize}${url}";
  }

  static String getStillUrl(String url) {
    return "${Constants.tmdbImageBase}${Constants.stillSize}$url";
  }

  static String getProfileUrl(String url) {
    return "${Constants.tmdbImageBase}${Constants.profileSize}$url";
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

  static String getStringByBasemodelType(BaseModelType baseModelType) {
    switch (baseModelType) {
      case BaseModelType.movie:
        return Strings.movie;
      case BaseModelType.people:
        return Strings.actor;
      case BaseModelType.tv:
        return Strings.tvShow;
    }
  }

  static EntityType getEntityByString(String str) {
    switch (str) {
      case Strings.all:
        return EntityType.all;
      case Strings.movies:
        return EntityType.movie;
      case Strings.tvShows:
        return EntityType.tv;
      default:
        throw UnimplementedError();
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

  static List<BaseModel> convertToBaseModelList(var parsedList) {
    return (parsedList as List).map((e) => BaseModel.fromMap(e)).toList();
  }

  static dynamic parseJson(dynamic object) {
    return json.decode(object);
  }

  static Video? convertToVideo(var parsedList) {
    if (parsedList.isEmpty) return null;
    return parsedList
        .map((e) {
          if (e['type'] == "Trailer") return Video.fromMap(e);
        })
        .toList()
        .first;
  }

  static List<BaseModel> convertToBaseModelListWithSkipLimit(
      var parsedList, int limit, bool shuffle) {
    List<BaseModel> list = (parsedList as List)
        .sublist(
          0,
          limit,
        )
        .map((e) => BaseModel.fromMap(e))
        .toList();

    if (shuffle) {
      list.shuffle();
    }
    return list;
  }
}
