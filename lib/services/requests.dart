import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:watrix/models/certification.dart';
import 'package:watrix/models/genre.dart';
import 'package:watrix/models/sort_movies.dart';
import 'package:watrix/models/sort_tv.dart';
import 'package:watrix/models/tv.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/duration_type.dart';
import 'package:watrix/services/entity_type.dart';
import 'package:watrix/services/utils.dart';

import '../models/base_model.dart';
import '../models/movie.dart';

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
    return "${Constants.baseUrl}${stringType}${Constants.popular}?api_key=${Constants.apiKey}&language=en-US";
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
    return "${Constants.baseUrl}${stringType}${Constants.topRated}?api_key=${Constants.apiKey}&language=en-US";
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

    return "${Constants.baseUrl}${Constants.trending}${stringType}${duration}?api_key=${Constants.apiKey}";
  }

  static String nowPlayingMovies({
    int page = 1,
  }) {
    return "${Constants.baseUrl}${Constants.movie}${Constants.nowPlaying}?api_key=${Constants.apiKey}&language=en-US&page=$page";
  }

  static String airingTodayTv({
    int page = 1,
  }) {
    return "${Constants.baseUrl}${Constants.tv}${Constants.airingToday}?api_key=${Constants.apiKey}&language=en-US&page=$page";
  }

  static String genres(
    EntityType type, {
    int page = 1,
  }) {
    String stringType;
    if (type == EntityType.movie) {
      stringType = Constants.movie;
    } else if (type == EntityType.tv) {
      stringType = Constants.tv;
    } else {
      throw FlutterError("Invalid media type");
    }

    return "${Constants.baseUrl}${Constants.genre}${stringType}/list?api_key=${Constants.apiKey}&language=en-US";
  }

  static String certifications(
    EntityType type, {
    int page = 1,
  }) {
    String stringType;
    if (type == EntityType.movie) {
      stringType = Constants.movie;
    } else if (type == EntityType.tv) {
      stringType = Constants.tv;
    } else {
      throw FlutterError("Invalid media type");
    }

    return "${Constants.baseUrl}${Constants.certification}${stringType}/list?api_key=${Constants.apiKey}";
  }

  static String search(
    EntityType type, {
    int page = 1,
  }) {
    String stringType;
    if (type == EntityType.movie) {
      stringType = Constants.movie;
    } else if (type == EntityType.tv) {
      stringType = Constants.tv;
    } else if (type == EntityType.people) {
      stringType = Constants.person;
    } else if (type == EntityType.all) {
      stringType = Constants.multi;
    } else {
      throw FlutterError("Invalid media type");
    }

    return "${Constants.baseUrl}${Constants.search}${stringType}?api_key=${Constants.apiKey}&language=en-US";
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

    if (withGenres != null && withGenres.isNotEmpty) {
      String q = withGenres.map((e) => e.id).toList().join(",");
      queries.add('with_genres=$q');
    }

    return queries.join("&");
  }

  static Future<List<BaseModel>> titlesFuture(
    String request, {
    int? limit,
    bool? skip,
    int page = 1,
  }) async {
    String req = "$request&page=$page";
    final response = await http.get(Uri.parse(req));
    var parsedList = json.decode(response.body)['results'];

    return Utils.convertToListStringWithSkipLimit(
      parsedList,
      limit ?? Constants.homeLimit,
      skip == true ? Random().nextInt(Constants.skipLimit) : 0,
    );
  }

  static Future<List<Genre>> genreFuture(String request) async {
    final response = await http.get(Uri.parse(request));
    var parsedList = json.decode(response.body)['genres'];
    return (parsedList as List).map((e) => Genre.fromMap(e)).toList();
  }

  static Future<List<BaseModel>> searchFuture(String query, String base,
      {int page = 1}) async {
    if (query.length < 1) {
      throw ErrorHint(
          "The length of query term cannot be less than 1 characters");
    }

    String encoded = Uri.encodeFull(query);

    final response =
        await http.get(Uri.parse(base + "&query=$encoded&page=$page"));
    var parsedList = json.decode(response.body)['results'];
    return Utils.convertToListString(parsedList);
  }

  static Future<List<Certification>> certificationsFuture(String query) async {
    final response = await http.get(Uri.parse(query));
    var parsedList = json.decode(response.body)['certifications']['IN'];
    return (parsedList as List).map((e) => Certification.fromMap(e)).toList();
  }

  static Future<List<BaseModel>> discoverFuture({
    required String query,
    required EntityType type,
    int page = 1,
  }) async {
    query = "$query&page=$page";
    String stringType =
        type == EntityType.movie ? Constants.movie : Constants.tv;
    String request =
        "${Constants.baseUrl}${Constants.discover}${stringType}?api_key=${Constants.apiKey}&${query}";

    final response = await http.get(Uri.parse(request));
    var parsedList = json.decode(response.body)['results'];
    return Utils.convertToListString(parsedList);
  }

  static Future<Movie> findMovie({required int id}) async {
    final response = await http.get(
      Uri.parse(
          "${Constants.baseUrl}${Constants.movie}/${id}?api_key=${Constants.apiKey}&language=en-US"),
    );
    return Movie.fromMap(json.decode(response.body));
  }

  static Future<Tv> findTv({required int id}) async {
    final response = await http.get(
      Uri.parse(
          "${Constants.baseUrl}${Constants.tv}/${id}?api_key=${Constants.apiKey}&language=en-US"),
    );
    return Tv.fromMap(json.decode(response.body));
  }
}
