import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
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
}
