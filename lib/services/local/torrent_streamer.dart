import 'package:flutter/services.dart';

class TorrentStreamer {
  static const MethodChannel methodChannel =
      const MethodChannel("cinenexa/torrentStream");

  final String magnetLink;
  final int? fileIndex;

  final Function(String url)? onServerReady;
  final Function(int progress)? onProgress;
  final Function(String error)? onError;

  TorrentStreamer({
    required this.magnetLink,
    this.fileIndex,
    this.onError,
    this.onProgress,
    this.onServerReady,
  }) {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onServerReady":
          onServerReady?.call(call.arguments);
          break;
        case "onError":
          onError?.call(call.arguments);
          break;
        case "onProgress":
          if (call.arguments < 100) onProgress?.call(call.arguments);
          break;
        default:
      }
    });
  }

  void startStream() {
    methodChannel
        .invokeMethod("start", {"url": magnetLink, "index": fileIndex ?? -1});
  }

  void stopStream() {
    methodChannel.invokeMethod("stop");
  }
}
