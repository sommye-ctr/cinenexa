// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

part 'trakt_show_history_season_ep.g.dart';

@embedded
class TraktShowHistorySeasonEp {
  int? number;
  int? plays;
  String? lastWatchedAt;
  TraktShowHistorySeasonEp({
    this.number,
    this.plays,
    this.lastWatchedAt,
  });

  TraktShowHistorySeasonEp copyWith({
    int? number,
    int? plays,
    String? lastWatchedAt,
  }) {
    return TraktShowHistorySeasonEp(
      number: number ?? this.number,
      plays: plays ?? this.plays,
      lastWatchedAt: lastWatchedAt ?? this.lastWatchedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'plays': plays,
      'last_watched_at': lastWatchedAt,
    };
  }

  factory TraktShowHistorySeasonEp.fromMap(Map<String, dynamic> map) {
    return TraktShowHistorySeasonEp(
      number: map['number'] != null ? map['number'] as int : null,
      plays: map['plays'] != null ? map['plays'] as int : null,
      lastWatchedAt: map['last_watched_at'] != null
          ? map['last_watched_at'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TraktShowHistorySeasonEp.fromJson(String source) =>
      TraktShowHistorySeasonEp.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TraktShowSeasonEp(number: $number, plays: $plays, lastWatchedAt: $lastWatchedAt)';

  @override
  bool operator ==(covariant TraktShowHistorySeasonEp other) {
    if (identical(this, other)) return true;

    return other.number == number &&
        other.plays == plays &&
        other.lastWatchedAt == lastWatchedAt;
  }

  @override
  int get hashCode => number.hashCode ^ plays.hashCode ^ lastWatchedAt.hashCode;
}
