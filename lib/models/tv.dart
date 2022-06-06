import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:watrix/models/tv_season.dart';

import 'genre.dart';

class Tv {
  String name;
  int id;
  String posterPath;
  String backdropPath;
  String overview;
  String firstAirDate;
  List<int> genreIds;
  double voteAverage;

  List<Genre>? genres;
  String? lastAirDate;
  int? noOfEpisodes;
  int? noOfSeasons;
  List<TvSeason>? seasons;
  Tv({
    required this.name,
    required this.id,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.firstAirDate,
    required this.genreIds,
    required this.voteAverage,
    this.genres,
    this.lastAirDate,
    this.noOfEpisodes,
    this.noOfSeasons,
    this.seasons,
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
    List<Genre>? genres,
    String? lastAirDate,
    int? noOfEpisodes,
    int? noOfSeasons,
    List<TvSeason>? seasons,
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
      genres: genres ?? this.genres,
      lastAirDate: lastAirDate ?? this.lastAirDate,
      noOfEpisodes: noOfEpisodes ?? this.noOfEpisodes,
      noOfSeasons: noOfSeasons ?? this.noOfSeasons,
      seasons: seasons ?? this.seasons,
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
      'genres': genres?.map((x) => x.toMap()).toList(),
      'last_air_date': lastAirDate,
      'number_of_episodes': noOfEpisodes,
      'number_of_seasons': noOfSeasons,
      'seasons': seasons?.map((x) => x.toMap()).toList(),
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
      genreIds: List<int>.from(map['genre_ids'] ?? []),
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      genres: map['genres'] != null
          ? List<Genre>.from(map['genres']?.map((x) => Genre.fromMap(x)))
          : null,
      lastAirDate: map['last_air_date'],
      noOfEpisodes: map['number_of_episodes']?.toInt(),
      noOfSeasons: map['number_of_seasons']?.toInt(),
      seasons: map['seasons'] != null
          ? List<TvSeason>.from(map['seasons']?.map((x) => TvSeason.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tv.fromJson(String source) => Tv.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tv(name: $name, id: $id, posterPath: $posterPath, backdropPath: $backdropPath, overview: $overview, firstAirDate: $firstAirDate, genreIds: $genreIds, voteAverage: $voteAverage, genres: $genres, lastAirDate: $lastAirDate, noOfEpisodes: $noOfEpisodes, noOfSeasons: $noOfSeasons, seasons: $seasons)';
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
        other.voteAverage == voteAverage &&
        listEquals(other.genres, genres) &&
        other.lastAirDate == lastAirDate &&
        other.noOfEpisodes == noOfEpisodes &&
        other.noOfSeasons == noOfSeasons &&
        listEquals(other.seasons, seasons);
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
        voteAverage.hashCode ^
        genres.hashCode ^
        lastAirDate.hashCode ^
        noOfEpisodes.hashCode ^
        noOfSeasons.hashCode ^
        seasons.hashCode;
  }
}
