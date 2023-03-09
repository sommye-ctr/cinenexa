import 'package:amplitude_flutter/amplitude.dart';

class Analytics {
  Amplitude amplitude;

  Analytics() : amplitude = Amplitude.getInstance();

  void logStartup() {
    amplitude.logEvent("Startup");
  }

  void logMoviePlay({required String title, required int tmdbId}) {
    amplitude.logEvent("Play", eventProperties: {
      "title": title,
      "tmdbId": tmdbId,
    });
  }

  void logAnonymousLogin() {
    amplitude.logEvent("Guest Login");
  }
}
