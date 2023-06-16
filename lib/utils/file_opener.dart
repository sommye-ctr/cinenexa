import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:path/path.dart' as p;

class FileOpener {
  static Future<Map?> openSrtFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['srt'],
      type: FileType.custom,
    );

    if (result != null) {
      return {
        "name": result.files[0].name,
        "path": result.files[0].path,
      };
    } else {
      return null;
    }
  }

  static Future<ClosedCaptionFile> downloadSrtFile(String url) async {
    try {
      final data = await http.get(Uri.parse(url));

      if (p.extension(url) == ".vtt") {
        return WebVTTCaptionFile(data.body);
      }
      return SubRipCaptionFile(data.body);
    } catch (e) {
      return SubRipCaptionFile("");
    }
  }

  static Future<ClosedCaptionFile> loadSubRipCaptionFile(File srtFile) async {
    final srtContent = await srtFile.readAsString();
    return SubRipCaptionFile(srtContent);
  }
}
