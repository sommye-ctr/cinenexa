// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TraktIds {
  int? tmdb;
  int? trakt;
  String? imdb;
  TraktIds({
    this.tmdb,
    this.trakt,
    this.imdb,
  });

  TraktIds copyWith({
    int? tmdb,
    int? trakt,
    String? imdb,
  }) {
    return TraktIds(
      tmdb: tmdb ?? this.tmdb,
      trakt: trakt ?? this.trakt,
      imdb: imdb ?? this.imdb,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tmdb': tmdb,
      'trakt': trakt,
      'imdb': imdb,
    };
  }

  factory TraktIds.fromMap(Map<String, dynamic> map) {
    return TraktIds(
      tmdb: map['tmdb'] != null ? map['tmdb'] as int : null,
      trakt: map['trakt'] != null ? map['trakt'] as int : null,
      imdb: map['imdb'] != null ? map['imdb'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TraktIds.fromJson(String source) =>
      TraktIds.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Ids(tmdb: $tmdb, trakt: $trakt, imdb: $imdb)';

  @override
  bool operator ==(covariant TraktIds other) {
    if (identical(this, other)) return true;

    return other.tmdb == tmdb && other.trakt == trakt && other.imdb == imdb;
  }

  @override
  int get hashCode => tmdb.hashCode ^ trakt.hashCode ^ imdb.hashCode;
}
