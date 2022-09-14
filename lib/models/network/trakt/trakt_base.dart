// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:watrix/models/network/trakt/trakt_ids.dart';

class TraktBase {
  String? title;
  int? year;
  TraktIds? ids;
  TraktBase({
    this.title,
    this.year,
    this.ids,
  });

  TraktBase copyWith({
    String? title,
    int? year,
    TraktIds? ids,
  }) {
    return TraktBase(
      title: title ?? this.title,
      year: year ?? this.year,
      ids: ids ?? this.ids,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'year': year,
      'ids': ids?.toMap(),
    };
  }

  factory TraktBase.fromMap(Map<String, dynamic> map) {
    return TraktBase(
      title: map['title'] != null ? map['title'] as String : null,
      year: map['year'] != null ? map['year'] as int : null,
      ids: map['ids'] != null
          ? TraktIds.fromMap(map['ids'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TraktBase.fromJson(String source) =>
      TraktBase.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TraktBase(title: $title, year: $year, ids: $ids)';

  @override
  bool operator ==(covariant TraktBase other) {
    if (identical(this, other)) return true;

    return other.title == title && other.year == year && other.ids == ids;
  }

  @override
  int get hashCode => title.hashCode ^ year.hashCode ^ ids.hashCode;
}
