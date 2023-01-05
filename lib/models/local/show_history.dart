// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:cinenexa/models/network/genre.dart';
import 'package:cinenexa/models/network/trakt/trakt_show_history_season.dart';
import 'package:cinenexa/models/network/tv.dart';
import 'package:cinenexa/utils/date_time_formatter.dart';

import '../network/trakt/trakt_show_history_season_ep.dart';
import '../network/tv_season.dart';

part 'show_history.g.dart';

@Collection()
class ShowHistory {
  ShowHistory();

  late Id? id;

  late Tv? show;

  late List<TraktShowHistorySeason>? seasons;

  late DateTime? lastUpdatedAt;

  late TraktShowHistorySeasonEp? lastWatched;
  late int? lastWatchedSeason;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'show': show?.toMap(),
      'seasons': seasons?.map((x) => x.toMap()).toList(),
      'lastUpdatedAt': lastUpdatedAt,
      'lastWatched': lastWatched,
      'lastWatchedSeason': lastWatchedSeason,
    };
  }

  factory ShowHistory.fromMap(Map<String, dynamic> map) {
    Tv show = Tv.fromMap(map['show'] as Map<String, dynamic>);
    ShowHistory history = ShowHistory()
      ..show = show
      ..lastUpdatedAt =
          DateTimeFormatter.parseDate(map['last_updated_at']) ?? null
      ..id = show.id
      ..lastWatched = map['last_watched']
      ..lastWatchedSeason = map['last_watched_season']
      ..seasons = List<TraktShowHistorySeason>.from(
        (map['seasons'] as List).map<TraktShowHistorySeason>(
          (x) => TraktShowHistorySeason.fromMap(x as Map<String, dynamic>),
        ),
      );
    return history;
  }

  String toJson() => json.encode(toMap());

  factory ShowHistory.fromJson(String source) =>
      ShowHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return "id:$id lastUpdated:${lastUpdatedAt.toString()}  show:${show.toString()} seasons:${seasons.toString()}";
  }
}
