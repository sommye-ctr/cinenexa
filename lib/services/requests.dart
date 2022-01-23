import 'dart:convert';
import 'package:watrix/models/home_movie.dart';
import 'package:http/http.dart' as http;
import 'package:watrix/models/home_tv.dart';
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

  static String nowPlayingTv =
      "${Constants.baseUrl}${Constants.tv}${Constants.nowPlaying}?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String dailyTrendingTv =
      "${Constants.baseUrl}${Constants.trending}${Constants.tv}/day?api_key=${Constants.apiKey}";

  static String weeklyTrendingTv =
      "${Constants.baseUrl}${Constants.trending}${Constants.tv}/week?api_key=${Constants.apiKey}";

  static Future<List<HomeMovie>> homeMoviesFuture(String request) async {
    final response = await http.get(Uri.parse(request));
    var parsedList = json.decode(response.body)['results'];
    return (parsedList as List)
        .sublist(0, Constants.homeLimit)
        .map((e) => HomeMovie.fromMap(e))
        .toList();
  }

  static Future<List<HomeTv>> homeTvFuture(String request) async {
    final response = await http.get(Uri.parse(request));
    var parsedList = json.decode(response.body)['results'];
    return (parsedList as List)
        .sublist(0, Constants.homeLimit)
        .map((e) => HomeTv.fromMap(e))
        .toList();
  }
}
