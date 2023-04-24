import '../models/network/trakt/trakt_show_history_season.dart';
import '../models/network/trakt/trakt_show_history_season_ep.dart';
import '../models/network/tv.dart';
import '../models/network/tv_episode.dart';
import 'date_time_formatter.dart';

class ShowEpisodesUtils {
  static Map calculateLastWatchedEp(List<TraktShowHistorySeason> items) {
    Map<int, TraktShowHistorySeasonEp> latestEps = {};

    for (var season in items) {
      latestEps.putIfAbsent(
          season.number!,
          () => season.episodes!.reduce((value, element) {
                DateTime valueDate =
                    DateTimeFormatter.parseDate(value.lastWatchedAt)!;
                DateTime elementDate =
                    DateTimeFormatter.parseDate(element.lastWatchedAt)!;
                return valueDate.compareTo(elementDate) > 0 ? value : element;
              }));
    }
    TraktShowHistorySeasonEp t = latestEps.values.reduce((value, element) {
      return DateTimeFormatter.parseDate(value.lastWatchedAt)!
              .isAfter(DateTimeFormatter.parseDate(element.lastWatchedAt)!)
          ? value
          : element;
    });

    return {
      "ep": t,
      "seasonNo":
          latestEps.keys.firstWhere((element) => latestEps[element] == t),
    };
  }

  static bool isEpisodeLastOfSeason(
      int episodeNumber, List<TvEpisode> episodes) {
    return episodeNumber == episodes.last.episodeNumber;
  }

  static bool hasNextSeason(
      int seasonNumber, List<TraktShowHistorySeason> seasons) {
    return seasonNumber == seasons.last.number;
  }

  static TraktShowHistorySeasonEp getNextEp(
    List<TraktShowHistorySeasonEp> episodes,
    Tv show,
    int currentEp,
  ) {
    int index = episodes.indexWhere((element) => element.number == currentEp);

    try {
      return episodes[index + 1];
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
