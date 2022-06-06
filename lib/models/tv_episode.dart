import 'dart:convert';

class TvEpisode {
  final String name;
  final String overview;
  final String airDate;
  final int episodeNumber;
  final int runtime;
  final String stillPath;
  final double voteAverage;

  TvEpisode({
    required this.name,
    required this.overview,
    required this.airDate,
    required this.episodeNumber,
    required this.runtime,
    required this.stillPath,
    required this.voteAverage,
  });

  TvEpisode copyWith({
    String? name,
    String? overview,
    String? airDate,
    int? episodeNumber,
    int? runtime,
    String? stillPath,
    double? voteAverage,
  }) {
    return TvEpisode(
      name: name ?? this.name,
      overview: overview ?? this.overview,
      airDate: airDate ?? this.airDate,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      runtime: runtime ?? this.runtime,
      stillPath: stillPath ?? this.stillPath,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'overview': overview,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'runtime': runtime,
      'still_path': stillPath,
      'vote_average': voteAverage,
    };
  }

  factory TvEpisode.fromMap(Map<String, dynamic> map) {
    return TvEpisode(
      name: map['name'] ?? '',
      overview: map['overview'] ?? '',
      airDate: map['air_date'] ?? '',
      episodeNumber: map['episode_number']?.toInt() ?? 0,
      runtime: map['runtime']?.toInt() ?? 0,
      stillPath: map['still_path'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TvEpisode.fromJson(String source) =>
      TvEpisode.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TvEpisode(name: $name, overview: $overview, airDate: $airDate, episodeNumber: $episodeNumber, runtime: $runtime, stillPath: $stillPath, voteAverage: $voteAverage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TvEpisode &&
        other.name == name &&
        other.overview == overview &&
        other.airDate == airDate &&
        other.episodeNumber == episodeNumber &&
        other.runtime == runtime &&
        other.stillPath == stillPath &&
        other.voteAverage == voteAverage;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        overview.hashCode ^
        airDate.hashCode ^
        episodeNumber.hashCode ^
        runtime.hashCode ^
        stillPath.hashCode ^
        voteAverage.hashCode;
  }
}
