import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:watrix/models/network/custom_exception.dart';
import 'package:watrix/services/constants.dart';

class Api {
  Future<dynamic> getRequest(String url, {bool haveQueries = false}) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(Constants.tmdbBase +
            url +
            (haveQueries ? "&" : "?") +
            "api_key=${Constants.apiKey}&language=en-US"),
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
        Uri.parse("${Constants.traktBase}${url}"),
        headers: Constants.traktRequestHeaders,
      );
      resp = _invalidate(response);
    } on SocketException {
      throw FetchException("No internet connection");
    }
    return resp;
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
