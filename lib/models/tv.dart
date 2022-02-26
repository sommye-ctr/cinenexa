import 'dart:convert';

import 'package:flutter/foundation.dart';

class Tv {
  String name;
  int id;
  String posterPath;
  String backdropPath;
  String overview;
  String firstAirDate;
  List<int> genreIds;
  double voteAverage;

  Tv({
    required this.name,
    required this.id,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.firstAirDate,
    required this.genreIds,
    required this.voteAverage,
  });

  Tv copyWith({
    String? name,
    int? id,
    String? posterPath,
    String? backdropPath,
    String? overview,
    String? firstAirDate,
    List<int>? genreIds,
    double? voteAverage,
  }) {
    return Tv(
      name: name ?? this.name,
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      overview: overview ?? this.overview,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      genreIds: genreIds ?? this.genreIds,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'overview': overview,
      'first_air_date': firstAirDate,
      'genre_ids': genreIds,
      'vote_average': voteAverage,
    };
  }

  factory Tv.fromMap(Map<String, dynamic> map) {
    return Tv(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      firstAirDate: map['first_air_date'] ?? '',
      genreIds: List<int>.from(map['genreIds']),
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tv.fromJson(String source) => Tv.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tv(name: $name, id: $id, posterPath: $posterPath, backdropPath: $backdropPath, overview: $overview, firstAirDate: $firstAirDate, genreIds: $genreIds, voteAverage: $voteAverage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tv &&
        other.name == name &&
        other.id == id &&
        other.posterPath == posterPath &&
        other.backdropPath == backdropPath &&
        other.overview == overview &&
        other.firstAirDate == firstAirDate &&
        listEquals(other.genreIds, genreIds) &&
        other.voteAverage == voteAverage;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        posterPath.hashCode ^
        backdropPath.hashCode ^
        overview.hashCode ^
        firstAirDate.hashCode ^
        genreIds.hashCode ^
        voteAverage.hashCode;
  }
}
