import 'dart:async';
import 'package:cinenexa/models/local/installed_extensions.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
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

    int countReceived = 0;

    void fetch() async {
      await _init();
      for (int i = 0; i < installedExtensions.length; i++) {
        _getStream(
          baseModel: baseModel,
          extension: installedExtensions[i],
          imdbId: imdbId,
          traktId: traktId,
          season: season,
          episode: episode,
        ).then((value) {
          countReceived++;
          streamController.add(value);

          if (countReceived == installedExtensions.length) {
            streamController.close();
          }
        });
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
    try {
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

      Response? response;
      try {
        if (extension.userData != null && extension.userData!.isNotEmpty) {
          response = await putResponse(extension, query);
        } else {
          response = await getResponse(extension, query);
        }
      } on DioError catch (e) {
        if (e.type == DioErrorType) {
          return [];
        }
        return [];
      }
      var data = _handleResponse(response, extension);
      return data;
    } catch (e) {
      return [];
    }
  }

  Future<Response> putResponse(
      InstalledExtensions extension, Map<String, dynamic> query) async {
    var result = dio.put(
      extension.endpoint!,
      queryParameters: query,
      data: {
        "params": extension.userData,
      },
        print("showing event");
      options: Options(
        receiveTimeout: 30000,
      ),
    );
    return result;
  }

  Future<Response> getResponse(
      InstalledExtensions extension, Map<String, dynamic> query) async {
    var resp = dio.get(
      extension.endpoint!,
      queryParameters: query,
      options: Options(
        receiveTimeout: 30000,
      ),
    );
    return resp;
  }

  List<ExtensionStream> _handleResponse(
      Response response, InstalledExtensions extension) {
    try {
      if ((response.statusCode == 200 || response.statusCode == 304) &&
          response.data != null) {
        var data;
        if (response.data is Map) {
          data = response.data as Map<String, dynamic>;
        } else if (response.data is String) {
          data = Utils.parseJson(response.data);
        }
        var list = data['streams'] as List;

        //List<ExtensionStream> list = sources['streams']
        //  .map((e) => ExtensionStream.fromMap(e)..extension = extension)
        //.toList();
        List<ExtensionStream> modLIst = list
            .map((e) => ExtensionStream.fromMap(e)
              ..extension = extension.getExtension())
            .toList();
        return modLIst;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
