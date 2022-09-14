// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:watrix/models/network/trakt/trakt_ids.dart';

class TraktEpisode {
  String? title;
  int? season;
  int? number;
  TraktIds? ids;
  TraktEpisode({
    this.title,
    this.season,
    this.number,
    this.ids,
  });

  TraktEpisode copyWith({
    String? title,
    int? season,
    int? number,
    TraktIds? ids,
  }) {
    return TraktEpisode(
      title: title ?? this.title,
      season: season ?? this.season,
      number: number ?? this.number,
      ids: ids ?? this.ids,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'season': season,
      'number': number,
      'ids': ids?.toMap(),
    };
  }

  factory TraktEpisode.fromMap(Map<String, dynamic> map) {
    return TraktEpisode(
      title: map['title'] != null ? map['title'] as String : null,
      season: map['season'] != null ? map['season'] as int : null,
      number: map['number'] != null ? map['number'] as int : null,
      ids: map['ids'] != null
          ? TraktIds.fromMap(map['ids'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TraktEpisode.fromJson(String source) =>
      TraktEpisode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TraktEpisode(title: $title, season: $season, number: $number, ids: $ids)';
  }

  @override
  bool operator ==(covariant TraktEpisode other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.season == season &&
        other.number == number &&
        other.ids == ids;
  }

  @override
  int get hashCode {
    return title.hashCode ^ season.hashCode ^ number.hashCode ^ ids.hashCode;
  }
}
