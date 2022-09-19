import 'package:isar/isar.dart';
import 'package:watrix/models/network/trakt/trakt_history_episode.dart';

import '../network/utils.dart';

class TraktHistoryEpisodeConverter
    extends TypeConverter<List<TraktHistoryEpisode>, String> {
  const TraktHistoryEpisodeConverter();

  @override
  List<TraktHistoryEpisode> fromIsar(String object) {
    return (Utils.parseJson(object) as List)
        .map((e) => TraktHistoryEpisode.fromJson(e))
        .toList();
  }

  @override
  String toIsar(List<TraktHistoryEpisode> object) {
    return Utils.encodeJson(object.map((e) => e.toJson()).toList());
  }
}
