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

  static Future<List<BaseModel>> titlesFuture(
    String request, {
    int? limit,
    bool? shuffle,
    int page = 1,
  }) async {
    String req = "$request&page=$page";
    final response = await http.get(Uri.parse(req));
    var parsedList = json.decode(response.body)['results'];

    return Utils.convertToListStringWithSkipLimit(
      parsedList,
      limit ?? Constants.homeLimit,
      shuffle ?? false,
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

  static Future<Map> getMovieDetails({required int id}) async {
    final response = await http.get(
      Uri.parse(
          "${Constants.baseUrl}${Constants.movie}/${id}?api_key=${Constants.apiKey}&language=en-US&append_to_response=credits,recommendations,videos"),
    );
    var map = json.decode(response.body);
    Video? vid = Utils.convertToVideo(map['videos']['results'] as List);
    return {
      "movie": Movie.fromMap(map),
      "credits": Utils.convertToListString(map['credits']['cast']),
      "recommended":
          Utils.convertToListString(map['recommendations']['results']),
      "video": vid,
    };
  }

  static Future<Map> getTvDetails({required int id}) async {
    final response = await http.get(
      Uri.parse(
          "${Constants.baseUrl}${Constants.tv}/${id}?api_key=${Constants.apiKey}&language=en-US&append_to_response=credits,recommendations,videos"),
    );
    var map = json.decode(response.body);
    Video? vid = Utils.convertToVideo(map['videos']['results'] as List);
    return {
      "tv": Tv.fromMap(map),
      "credits": Utils.convertToListString(map['credits']['cast']),
      "recommended":
          Utils.convertToListString(map['recommendations']['results']),
      "video": vid,
    };
  }

  static Future<Map> getPeopleDetails({required int id}) async {
    final response = await http.get(
      Uri.parse(
          "${Constants.baseUrl}${Constants.person}/${id}?api_key=${Constants.apiKey}&language=en-US&append_to_response=combined_credits"),
    );

    var map = json.decode(response.body);
    return {
      "person": People.fromMap(map),
      "credits": Utils.convertToListString(map['combined_credits']['cast'])
    };
  }

  static Future<List<TvEpisode>> getSeasonEpisodes(
      {required int tvId, required int seasonNo}) async {
    final response = await http.get(
      Uri.parse(
          "${Constants.baseUrl}${Constants.tv}/${tvId}/season/${seasonNo}?api_key=${Constants.apiKey}&language=en-US"),
    );
    var parsedList = json.decode(response.body)['episodes'];
    return (parsedList as List).map((e) => TvEpisode.fromMap(e)).toList();
  }
}
