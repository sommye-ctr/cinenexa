class Constants {
  static const String apiKey = "c76700d23b7e001aa141938818340e79";

  static String tmdbBase = "https://api.themoviedb.org/3";
  static String tmdbImageBase = "https://image.tmdb.org/t/p";

  static const String traktApi =
      "28acc06d101c220710f591128cb8c79a1a86409e94bd777876f42905dc179b26";
  static const String openSubApi = "0fgcaUNKBiPRFgbWOPelMRF0kkfjDA7L";
  static String traktBase = "https://api.trakt.tv";

  static Map<String, String> traktRequestHeaders = {
    'Content-type': 'application/json',
    'trakt-api-key': '$traktApi',
    'trakt-api-version': "2",
  };

  static Map<String, String> openSubRequestHeaders = {
    "Accept": "*/*",
    "Api-Key": '$openSubApi',
    "User-Agent": "Watrix",
  };

  static String posterSize = "/w300";
  static String backdropSize = "/w780";
  static String stillSize = "/w300";
  static String profileSize = "/w92";
  static String watchProviderSize = "/original";

  static String hdPosterSize = "/w500";

  static String movies = "/movies";
  static String shows = "/shows";

  static String movie = "/movie";
  static String tv = "/tv";
  static String person = "/person";
  static String all = "/all";
  static String multi = "/multi"; //alternative of all

  static String day = "/day";
  static String week = "/week";

  static String search = "/search";
  static String genre = "/genre";
  static String certification = "/certification";
  static String discover = "/discover";
  static String popular = "/popular";
  static String topRated = "/top_rated";
  static String nowPlaying = "/now_playing";
  static String trending = "/trending";
  static String airingToday = "/airing_today";

  static String comments = "/comments";

  static const double posterAspectRatio = 2 / 3;
  static const double backdropAspectRatio = 16 / 9;
  static const double stillAspectRatio = 16 / 9;

  static const int homeLimit = 10;
  static const int skipLimit = 5;
  static const int placeHolderListLimit = 5;
}
