import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:watrix/models/network/custom_exception.dart';

class Api {
  static const String apiKey =
      "c76700d23b7e001aa141938818340e79"; //TODO Obfuscate this
  static String base = "https://api.themoviedb.org/3";

  static const String traktApi =
      "4cd822c6833df1369125d7c2f8266524993f460908af5381207e4c147059c3d4";
  static String traktBase = "https://api.trakt.tv";

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'trakt-api-key': '$traktApi',
    'trakt-api-version': "2",
  };

  Future<dynamic> getRequest(String url, {bool haveQueries = false}) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(base +
            url +
            (haveQueries ? "&" : "?") +
            "api_key=$apiKey&language=en-US"),
      );
      responseJson = json.decode(_invalidate(response).body);
    } on SocketException {
      throw FetchException("No internet connection");
    }
    return responseJson;
  }

  Future<dynamic> getTraktRequest(String url) async {
    var resp;
    try {
      final response = await http.get(
        Uri.parse("${traktBase}${url}"),
        headers: requestHeaders,
      );
      resp = _invalidate(response);
    } on SocketException {
      throw FetchException("No internet connection");
    }
    return resp;
  }

  dynamic parseJson(dynamic object) {
    return json.decode(object);
  }

  http.Response _invalidate(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorisedException(response.body);
      case 404:
        throw NotFoundException(response.body);
      case 500:
        throw FetchException(response.body);
      case 200:
        return response;
      default:
        throw UnimplementedError(response.reasonPhrase);
    }
  }
}
