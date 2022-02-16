import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:watrix/models/genre.dart';
import 'package:watrix/models/people.dart';
import 'package:watrix/models/movie.dart';
import 'package:watrix/models/tv.dart';
import 'package:watrix/services/constants.dart';

class Requests {
  static String popularMovies =
      "${Constants.baseUrl}${Constants.movie}${Constants.popular}?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String topRatedMovies =
      "${Constants.baseUrl}${Constants.movie}${Constants.topRated}?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String nowPlayingMovies =
      "${Constants.baseUrl}${Constants.movie}${Constants.nowPlaying}?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String dailyTrendingMovies =
      "${Constants.baseUrl}${Constants.trending}${Constants.movie}/day?api_key=${Constants.apiKey}";

  static String weeklyTrendingMovies =
      "${Constants.baseUrl}${Constants.trending}${Constants.movie}/week?api_key=${Constants.apiKey}";

  static String popularTv =
      "${Constants.baseUrl}${Constants.tv}${Constants.popular}?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String topRatedTv =
      "${Constants.baseUrl}${Constants.tv}${Constants.topRated}?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String airingTodayTv =
      "${Constants.baseUrl}${Constants.tv}${Constants.airingToday}?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String dailyTrendingTv =
      "${Constants.baseUrl}${Constants.trending}${Constants.tv}/day?api_key=${Constants.apiKey}";

  static String weeklyTrendingTv =
      "${Constants.baseUrl}${Constants.trending}${Constants.tv}/week?api_key=${Constants.apiKey}";

  static String popularPerson =
      "${Constants.baseUrl}${Constants.person}${Constants.popular}?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String search =
      "${Constants.baseUrl}${Constants.search}${Constants.movie}?api_key=${Constants.apiKey}&language=en-US";

  static String movieGenre =
      "${Constants.baseUrl}${Constants.genre}${Constants.movie}/list?api_key=${Constants.apiKey}&language=en-US";

  static String certifications =
      "${Constants.baseUrl}${Constants.certification}${Constants.movie}/list?api_key=${Constants.apiKey}";

  static Future<List<Movie>> moviesFuture(
    String request, {
    int? limit,
    bool? skip,
  }) async {
    final response = await http.get(Uri.parse(request));
    var parsedList = json.decode(response.body)['results'];

    return (parsedList as List)
        .sublist(
          skip == true ? Random().nextInt(Constants.skipLimit) : 0,
          limit ?? Constants.homeLimit,
        )
        .map((e) => Movie.fromMap(e))
        .toList();
  }

  static Future<List<Tv>> tvFuture(
    String request, {
    int? limit,
    bool? skip,
  }) async {
    final response = await http.get(Uri.parse(request));
    var parsedList = json.decode(response.body)['results'];
    return (parsedList as List)
        .sublist(
          skip == true ? Random().nextInt(Constants.skipLimit) : 0,
          limit ?? Constants.homeLimit,
        )
        .map((e) => Tv.fromMap(e))
        .toList();
  }

  static Future<List<People>> peopleFuture(
    String request, {
    int? limit,
    bool? skip,
  }) async {
    final response = await http.get(Uri.parse(request));
    var parsedList = json.decode(response.body)['results'];
    return (parsedList as List)
        .sublist(
          skip == true ? Random().nextInt(Constants.skipLimit) : 0,
          limit ?? Constants.homeLimit,
        )
        .map((e) => People.fromMap(e))
        .toList();
  }

  static Future<List<Genre>> genreFuture(String request) async {
    final response = await http.get(Uri.parse(request));
    var parsedList = json.decode(response.body)['genres'];
    return (parsedList as List).map((e) => Genre.fromMap(e)).toList();
  }

  static Future<List<Movie>> searchMovie(String query) async {
    if (query.length < 1) {
      throw ErrorHint(
          "The length of query term cannot be less than 1 characters");
    }

    String encoded = Uri.encodeFull(query);

    final response = await http.get(Uri.parse(search + "&query=$encoded"));
    var parsedList = json.decode(response.body)['results'];
    return (parsedList as List).map((e) => Movie.fromMap(e)).toList();
  }

  static Future<List<String>> certificationsFuture(String query) async {
    final response = await http.get(Uri.parse(query));
    var parsedList = json.decode(response.body)['certifications']['IN'];
    return (parsedList as List)
        .map((e) => e['certification'].toString())
        .toList();
  }
}
