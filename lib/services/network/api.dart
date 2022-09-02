import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:watrix/models/network/custom_exception.dart';

class Api {
  static const String apiKey =
      "c76700d23b7e001aa141938818340e79"; //TODO Obfuscate this

  static String base = "https://api.themoviedb.org/3";

  Future<dynamic> getRequest(String url, {bool haveQueries = false}) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(base +
            url +
            (haveQueries ? "&" : "?") +
            "api_key=$apiKey&language=en-US"),
      );
      responseJson = _invalidate(response);
    } on SocketException {
      throw FetchException("No internet connection");
    }
    return responseJson;
  }

  dynamic _invalidate(http.Response response) {
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
        var responseJson = json.decode(response.body);
        return responseJson;
    }
  }
}
