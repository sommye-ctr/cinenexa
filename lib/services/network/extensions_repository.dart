import 'dart:async';
import 'package:cinenexa/models/local/installed_extensions.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cinenexa/utils/date_time_formatter.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/network/extensions/extension.dart';

class ExtensionsRepository {
  final List<InstalledExtensions> installedExtensions;

  late CacheOptions options;
  late Dio dio;

  ExtensionsRepository({required this.installedExtensions});

  Future _init() async {
    var cacheDir = await getTemporaryDirectory();
    options = CacheOptions(
      store: HiveCacheStore(cacheDir.path),
      priority: CachePriority.normal,
      maxStale: Duration(days: 2),
      policy: CachePolicy.forceCache,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    );
    dio = Dio()..interceptors.add(DioCacheInterceptor(options: options));
  }

  Stream<List<ExtensionStream>> loadStreams(
      {required BaseModel baseModel,
      required int traktId,
      required String imdbId,
      int? season,
      int? episode}) {
    late StreamController<List<ExtensionStream>> streamController;

    void fetch() async {
      await _init();
      for (int i = 0; i < installedExtensions.length; i++) {
        var stream = await _getStream(
          baseModel: baseModel,
          extension: installedExtensions[i],
          imdbId: imdbId,
          traktId: traktId,
          season: season,
          episode: episode,
        );
        streamController.add(stream);
        if (i == installedExtensions.length - 1) {
          streamController.close();
        }
      }
    }

    streamController = StreamController(onListen: fetch);
    return streamController.stream;
  }

  Future<List<ExtensionStream>> _getStream({
    required BaseModel baseModel,
    required InstalledExtensions extension,
    required int traktId,
    required String imdbId,
    int? season,
    int? episode,
  }) async {
    final query = {
      "type": baseModel.type!.getString(),
      "name": baseModel.title,
      "releaseYear":
          DateTimeFormatter.getYearFromString(baseModel.releaseDate!),
      "tmdbId": baseModel.id,
      "season": season,
      "episode": episode,
      "traktId": traktId,
      "imdbId": imdbId,
    };

    Response response;
    try {
      if (extension.userData != null && extension.userData!.isNotEmpty) {
        response = await putResponse(extension, query);
      } else {
        response = await getResponse(extension, query);
      }
    } on DioError catch (e, trace) {
      if (e.type == DioErrorType) {
        return [];
      }
      FirebaseCrashlytics.instance.recordError(e, trace);
      return [];
    }
    return _handleResponse(response.data, extension);
  }

  Future<Response> putResponse(
      InstalledExtensions extension, Map<String, dynamic> query) {
    return dio.put(
      extension.endpoint!,
      queryParameters: query,
      data: {
        "params": extension.userData,
      },
      options: Options(
        receiveTimeout: 30000,
      ),
    );
  }

  Future<Response> getResponse(
      InstalledExtensions extension, Map<String, dynamic> query) {
    return dio.get(
      extension.endpoint!,
      queryParameters: query,
      options: Options(
        receiveTimeout: 30000,
      ),
    );
  }

  List<ExtensionStream> _handleResponse(
      String response, InstalledExtensions extension) {
    if (response.isNotEmpty) {
      try {
        Map sources = Utils.parseJson(response);

        //List<ExtensionStream> list = sources['streams']
        //  .map((e) => ExtensionStream.fromMap(e)..extension = extension)
        //.toList();
        List list = sources['streams'];
        List<ExtensionStream> modLIst = list
            .map((e) => ExtensionStream.fromMap(e)
              ..extension = extension.getExtension())
            .toList();
        return modLIst;
      } catch (e, trace) {
        FirebaseCrashlytics.instance.recordError(e, trace);
        return [];
      }
    }
    return [];
  }
}
