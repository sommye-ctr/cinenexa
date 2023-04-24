import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:http/http.dart' as http;
import 'package:cinenexa/models/network/custom_exception.dart';
import 'package:cinenexa/services/constants.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/network/extensions/extension.dart';

class Api {
  late Dio dio;

  Api() {
    _init();
  }

  _init() async {
    var cacheDir = await getTemporaryDirectory();
    dio = Dio()
      ..interceptors.add(
        DioCacheInterceptor(
          options: CacheOptions(
            store: HiveCacheStore(cacheDir.path),
            priority: CachePriority.normal,
            maxStale: Duration(days: 2),
            policy: CachePolicy.forceCache,
            keyBuilder: CacheOptions.defaultCacheKeyBuilder,
          ),
        ),
      );
  }

  Future<dynamic> getRequest(String url,
      {bool haveQueries = false, bool cache = false}) async {
    var responseJson;

    try {
      if (cache) {
        final response = await dio.getUri(Uri.parse(Constants.tmdbBase +
            url +
            (haveQueries ? "&" : "?") +
            "api_key=${Constants.apiKey}&language=en-US"));

        responseJson = _invalidateDio(response).data;
      } else {
        final response = await http.get(
          Uri.parse(Constants.tmdbBase +
              url +
              (haveQueries ? "&" : "?") +
              "api_key=${Constants.apiKey}&language=en-US"),
        );
        responseJson = json.decode(_invalidate(response).body);
      }
    } on SocketException {
      throw FetchException("No internet connection");
    } catch (e) {
      throw Exception(e);
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

  Future<String> getJsonFile(Extension extension) async {
    var cacheDir = await getTemporaryDirectory();
    Dio dio = Dio()
      ..interceptors.add(
        DioCacheInterceptor(
          options: CacheOptions(
            store: HiveCacheStore(cacheDir.path),
            priority: CachePriority.normal,
            maxStale: Duration(days: 14),
            policy: CachePolicy.forceCache,
            keyBuilder: CacheOptions.defaultCacheKeyBuilder,
          ),
        ),
      );
    Response response = await dio.get(extension.configJson!);
    return response.data;
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

  Response _invalidateDio(Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.data);
      case 401:
        throw UnauthorisedException(response.data);
      case 404:
        throw NotFoundException(response.data);
      case 500:
        throw FetchException(response.data);
      case 200:
        return response;
      case 304:
        return response;
      default:
        throw UnimplementedError(response.statusMessage);
    }
  }
}
