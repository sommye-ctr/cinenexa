import 'dart:async';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/services/temp_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:http/http.dart' as http;
import 'package:cinenexa/utils/date_time_formatter.dart';

import '../../models/network/extensions/extension.dart';

class ExtensionsRepository {
  final List<Extension> installedExtensions;

  ExtensionsRepository({required this.installedExtensions});

  Stream<List<ExtensionStream>> loadStreams(
      {required BaseModel baseModel,
      required int traktId,
      required String imdbId,
      int? season,
      int? episode}) {
    late StreamController<List<ExtensionStream>> streamController;

    void fetch() async {
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

    /* Map<String, dynamic> map = {
      "type": baseModel.type.toString(),
      "season": season,
      "episode": episode,
      "id": baseModel.id,
    };

    for (var element in extensions) {
      Uri uri = Uri.parse(element.endpoint).replace(queryParameters: map);
      http.get(uri).then((value) {
        streamController.add(ExtensionStream.fromMap(Utils.encodeJson(value.body))..extension = element);
      });
    }

    yield* streamController.stream; */
  }

  Future<List<ExtensionStream>> _getStream({
    required BaseModel baseModel,
    required Extension extension,
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
    final parsedUri = Uri.parse(extension.endpoint);
    final Uri uri = Uri.https(parsedUri.authority, '',
        query.map((key, value) => MapEntry(key, value.toString())));

    var response;

    try {
      response = await http.get(uri).timeout(Duration(seconds: 30));
    } on TimeoutException {
      return [];
    } catch (e, trace) {
      FirebaseCrashlytics.instance.recordError(e, trace);

      return [];
    }
    return _handleResponse(response, extension);
  }

  List<ExtensionStream> _handleResponse(
      http.Response response, Extension extension) {
    if (response.body.isNotEmpty) {
      try {
        Map sources = Utils.parseJson(response.body);

        //List<ExtensionStream> list = sources['streams']
        //  .map((e) => ExtensionStream.fromMap(e)..extension = extension)
        //.toList();
        List list = sources['streams'];
        List<ExtensionStream> modLIst = list
            .map((e) => ExtensionStream.fromMap(e)..extension = extension)
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
