import 'package:flutter/widgets.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/enums/languages.dart';
import 'package:cinenexa/services/constants.dart';
import 'package:cinenexa/models/network/enums/duration_type.dart';
import 'package:cinenexa/models/network/enums/entity_type.dart';
import 'package:cinenexa/services/network/utils.dart';

import '../../models/local/enums/sort_movies.dart';
import '../../models/local/enums/sort_tv.dart';
import '../../models/network/genre.dart';

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

  static String reviews(BaseModelType type, int id) {
    String string;
    if (type == BaseModelType.movie) {
      string = Constants.movies;
    } else if (type == BaseModelType.tv) {
      string = Constants.shows;
    } else {
      throw FlutterError("Invalid media type");
    }
    return "${string}/$id${Constants.comments}/likes";
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
    List<int>? releaseYears,
    int? voteAverageLessThan,
    int? voteAverageGreaterThan,
    List<Genre>? withGenres,
    String? certification,
    String? withPeople,
    List<Languages>? withLanguages,
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

    String yearBase = type == EntityType.movie
        ? "primary_release_year"
        : "first_air_date_year";
    if (releaseYears != null) {
      queries.add('$yearBase=${releaseYears.join("|")}');
    }

    if (withPeople != null) {
      queries.add("with_people=$withPeople");
    }

    if (withGenres != null && withGenres.isNotEmpty) {
      String q = withGenres.map((e) => e.id).toList().join(",");
      queries.add('with_genres=$q');
    }

    if (withLanguages != null && withLanguages.isNotEmpty) {
      String q = withLanguages.map((e) => e.name).toList().join("|");
      queries.add('with_original_language=$q');
    }
    return queries.join("&");
  }
}
