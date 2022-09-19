// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TraktHistoryEpisode {
  final int number;
  final int plays;
  final String last_watched_at;
  TraktHistoryEpisode({
    required this.number,
    required this.plays,
    required this.last_watched_at,
  });

  TraktHistoryEpisode copyWith({
    int? number,
    int? plays,
    String? last_watched_at,
  }) {
    return TraktHistoryEpisode(
      number: number ?? this.number,
      plays: plays ?? this.plays,
      last_watched_at: last_watched_at ?? this.last_watched_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'plays': plays,
      'last_watched_at': last_watched_at,
    };
  }

  factory TraktHistoryEpisode.fromMap(Map<String, dynamic> map) {
    return TraktHistoryEpisode(
      number: map['number'] as int,
      plays: map['plays'] as int,
      last_watched_at: map['last_watched_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TraktHistoryEpisode.fromJson(String source) =>
      TraktHistoryEpisode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TraktHistoryEpisode(number: $number, plays: $plays, last_watched_at: $last_watched_at)';

  @override
  bool operator ==(covariant TraktHistoryEpisode other) {
    if (identical(this, other)) return true;

    return other.number == number &&
        other.plays == plays &&
        other.last_watched_at == last_watched_at;
  }

  @override
  int get hashCode =>
      number.hashCode ^ plays.hashCode ^ last_watched_at.hashCode;
}
