import 'package:flutter/rendering.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechRecognizer {
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
    required Function(SpeechRecognitionError err) onError,
    required VoidCallback onDone,
  }) async {
    final isAvailable = await _speech.initialize(
      onStatus: (status) {
        if (status == "done") {
          onDone();
        } else
          onListening(_speech.isListening);
      },
      onError: onError,
    );

    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    if (isAvailable) {
      _speech.listen(onResult: (value) => onResult(value.recognizedWords));
    }

    return isAvailable;
  }
}
