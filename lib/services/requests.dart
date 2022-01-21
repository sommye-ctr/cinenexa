import 'dart:convert';
import 'package:watrix/models/home.dart';
import 'package:http/http.dart' as http;
import 'package:watrix/services/constants.dart';

class Requests {
  static String _baseUrl = "https://api.themoviedb.org/3";

  static String popularMovies =
      "$_baseUrl/movie/popular?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String topRatedMovies =
      "$_baseUrl/movie/top_rated?api_key=${Constants.apiKey}&language=en-US&page=1";

  static String nowPlayingMovies =
      "$_baseUrl/movie/now_playing?api_key=${Constants.apiKey}&language=en-US&page=1";

  static Future<List<Home>> homeMoviesFuture(String request) async {
    final response = await http.get(Uri.parse(request));
    var parsedList = json.decode(response.body)['results'];
    return (parsedList as List)
        .sublist(0, Constants.homeLimit)
        .map((e) => Home.fromMap(e))
        .toList();
  }
}
