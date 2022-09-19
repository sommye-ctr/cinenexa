// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:watrix/models/network/trakt/trakt_history_episode.dart';
import 'package:watrix/services/local/trakt_history_episode_converter.dart';

part 'show_history_season.g.dart';

@Collection()
class ShowHistorySeason {
  int? id;

  late int number;
  @TraktHistoryEpisodeConverter()
  late List<TraktHistoryEpisode> episodes;

  ShowHistorySeason();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'episodes': episodes.map((x) => x.toMap()).toList(),
    };
  }

  factory ShowHistorySeason.fromMap(Map<String, dynamic> map) {
    return ShowHistorySeason()
      ..number = map['number'] as int
      ..episodes = List<TraktHistoryEpisode>.from(
        (map['episodes'] as List).map<TraktHistoryEpisode>(
          (x) => TraktHistoryEpisode.fromMap(x as Map<String, dynamic>),
        ),
      );
  }

  String toJson() => json.encode(toMap());

  factory ShowHistorySeason.fromJson(String source) =>
      ShowHistorySeason.fromMap(json.decode(source) as Map<String, dynamic>);
}
