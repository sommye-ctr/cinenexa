import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:watrix/models/network/video.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/models/network/enums/duration_type.dart';
import 'package:watrix/models/network/enums/entity_type.dart';
import 'package:watrix/services/network/utils.dart';

import '../../models/local/enums/sort_movies.dart';
import '../../models/local/enums/sort_tv.dart';
import '../../models/network/base_model.dart';
import '../../models/network/certification.dart';
import '../../models/network/genre.dart';
import '../../models/network/movie.dart';
import '../../models/network/people.dart';
import '../../models/network/tv.dart';
import '../../models/network/tv_episode.dart';

class Requests {
  static String popular(EntityType type) {
    String stringType;
    if (type == EntityType.movie) {
      stringType = Constants.movie;
    } else if (type == EntityType.tv) {
      stringType = Constants.tv;
    } else if (type == EntityType.people) {
      stringType = Constants.person;
    } else {
      throw FlutterError("Invalid media type");
    }
    return "${stringType}${Constants.popular}";
  }

  static String topRated(EntityType type) {
    String stringType;
    if (type == EntityType.movie) {
      stringType = Constants.movie;
    } else if (type == EntityType.tv) {
      stringType = Constants.tv;
    } else {
      throw FlutterError("Invalid media type");
    }
    return "${stringType}${Constants.topRated}";
  }

  static String trending(EntityType type, DurationType durationType) {
    String stringType, duration;
    if (type == EntityType.movie) {
      stringType = Constants.movie;
    } else if (type == EntityType.tv) {
      stringType = Constants.tv;
    } else if (type == EntityType.people) {
      stringType = Constants.person;
    } else if (type == EntityType.all) {
      stringType = Constants.all;
    } else {
      throw FlutterError("Invalid media type");
    }

    if (durationType == DurationType.day) {
      duration = Constants.day;
    } else if (durationType == DurationType.week) {
      duration = Constants.week;
    } else {
      throw FlutterError("Invalid media type");
    }

    return "${Constants.trending}${stringType}${duration}";
  }

  static String genres(EntityType type) {
    String stringType;
    if (type == EntityType.movie) {
      stringType = Constants.movie;
    } else if (type == EntityType.tv) {
      stringType = Constants.tv;
    } else {
      throw FlutterError("Invalid media type");
    }

    return "${Constants.genre}${stringType}/list";
  }

  static String certifications(EntityType type) {
    String stringType;
    if (type == EntityType.movie) {
      stringType = Constants.movie;
    } else if (type == EntityType.tv) {
      stringType = Constants.tv;
    } else {
      throw FlutterError("Invalid media type");
    }

    return "${Constants.certification}${stringType}/list";
  }

  static String discover({
    required EntityType type,
    SortTvBy? sortTvBy,
    SortMoviesBy? sortMoviesBy,
    int page = 1,
    DateTime? releaseDateLessThan,
    DateTime? releaseDateMoreThan,
    int? voteAverageLessThan,
    int? voteAverageGreaterThan,
    List<Genre>? withGenres,
    String? certification,
    String? withPeople,
  }) {
    List<String> queries = ['language=en-US'];

    if (type == EntityType.movie && sortMoviesBy != null) {
      queries.add('sort_by=${Utils.getSortMoviesBy(sortMoviesBy)}');
    } else if (type == EntityType.tv && sortTvBy != null) {
      queries.add('sort_by=${Utils.getSortTvBy(sortTvBy)}');
    }

    if (type == EntityType.movie &&
        certification != null &&
        certification.isNotEmpty) {
      queries.addAll([
        'certification=$certification',
        'certification_country=IN',
      ]);
    }

    if (voteAverageGreaterThan != null) {
      queries.add('vote_average.gte=$voteAverageGreaterThan');
    }

    if (voteAverageLessThan != null) {
      queries.add('vote_average.lte=$voteAverageLessThan');
    }

    String dateBase =
        type == EntityType.movie ? "release_date" : "first_air_date";

    if (releaseDateMoreThan != null) {
      queries.add('$dateBase.gte=${releaseDateMoreThan.toIso8601String()}');
    }

    if (releaseDateLessThan != null) {
      queries.add('$dateBase.lte=${releaseDateLessThan.toIso8601String()}');
    }

    if (withPeople != null) {
      queries.add("with_people=$withPeople");
    }

    if (withGenres != null && withGenres.isNotEmpty) {
      String q = withGenres.map((e) => e.id).toList().join(",");
      queries.add('with_genres=$q');
    }

    return queries.join("&");
  }
}
