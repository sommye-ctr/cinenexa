// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'package:cinenexa/models/network/trakt/trakt_show_history_season_ep.dart';

part 'trakt_show_history_season.g.dart';

@embedded
class TraktShowHistorySeason {
  int? number;
  List<TraktShowHistorySeasonEp>? episodes;
  TraktShowHistorySeason({
    this.number,
    this.episodes,
  });

  TraktShowHistorySeason copyWith({
    int? number,
    List<TraktShowHistorySeasonEp>? episodes,
  }) {
    return TraktShowHistorySeason(
      number: number ?? this.number,
      episodes: episodes ?? this.episodes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'episodes': episodes?.map((x) => x.toMap()).toList(),
    };
  }

  factory TraktShowHistorySeason.fromMap(Map<String, dynamic> map) {
    return TraktShowHistorySeason(
      number: map['number'] != null ? map['number'] as int : null,
      episodes: map['episodes'] != null
          ? List<TraktShowHistorySeasonEp>.from(
              (map['episodes'] as List).map<TraktShowHistorySeasonEp?>(
                (x) =>
                    TraktShowHistorySeasonEp.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TraktShowHistorySeason.fromJson(String source) =>
      TraktShowHistorySeason.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TraktShowHistorySeason(number: $number, episodes: $episodes)';

  @override
  bool operator ==(covariant TraktShowHistorySeason other) {
    if (identical(this, other)) return true;

    return other.number == number && listEquals(other.episodes, episodes);
  }

  @override
  int get hashCode => number.hashCode ^ episodes.hashCode;
}
