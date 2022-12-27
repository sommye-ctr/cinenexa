import 'dart:async';

import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/extensions/extension.dart';
import 'package:watrix/models/network/extensions/extension_stream.dart';
import 'package:watrix/services/temp_data.dart';

class ExtensionsRepository {
  static Future<List<ExtensionStream>> getSampleExtension(
      int index, int start) async {
    await Future.delayed(Duration(seconds: 2));
    return TempData.streams.sublist(start, index);
  }

  static Stream<List<ExtensionStream>> loadStreams(
      {required BaseModel baseModel, int? season, int? episode}) {
    late StreamController<List<ExtensionStream>> streamController;

    void fetch() async {
      streamController.add(await getSampleExtension(3, 0));
      streamController.add(await getSampleExtension(6, 3));
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
}
