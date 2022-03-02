import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:watrix/models/genre.dart';

class Movie {
  String title;
  int id;
  String posterPath;
  String backdropPath;
  String overView;
  String releaseDate;
  List<int> genreIds;
  double voteAverage;
  int? runtime;
  List<Genre>? genres;

  Movie({
    required this.title,
    required this.id,
    required this.posterPath,
    required this.backdropPath,
    required this.overView,
    required this.releaseDate,
    required this.genreIds,
    required this.voteAverage,
    this.runtime,
    this.genres,
  });

  Movie copyWith({
    String? title,
    int? id,
    String? posterPath,
    String? backdropPath,
    String? overView,
    String? releaseDate,
    List<int>? genreIds,
    double? voteAverage,
    int? runtime,
    List<Genre>? genres,
  }) {
    return Movie(
      title: title ?? this.title,
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      overView: overView ?? this.overView,
      releaseDate: releaseDate ?? this.releaseDate,
      genreIds: genreIds ?? this.genreIds,
      voteAverage: voteAverage ?? this.voteAverage,
      runtime: runtime ?? this.runtime,
      genres: genres ?? this.genres,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'overview': overView,
      'release_date': releaseDate,
      'genre_ids': genreIds,
      'vote_average': voteAverage,
      'runtime': runtime,
      'genres': genres?.map((x) => x.toMap()).toList(),
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      id: map['id']?.toInt() ?? 0,
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overView: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      genreIds: List<int>.from(map['genre_ids'] ?? []),
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      runtime: map['runtime']?.toInt(),
      genres: map['genres'] != null
          ? List<Genre>.from(map['genres']?.map((x) => Genre.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(title: $title, id: $id, posterPath: $posterPath, backdropPath: $backdropPath, overView: $overView, releaseDate: $releaseDate, genreIds: $genreIds, voteAverage: $voteAverage, runtime: $runtime, genres: $genres)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.title == title &&
        other.id == id &&
        other.posterPath == posterPath &&
        other.backdropPath == backdropPath &&
        other.overView == overView &&
        other.releaseDate == releaseDate &&
        listEquals(other.genreIds, genreIds) &&
        other.voteAverage == voteAverage &&
        other.runtime == runtime &&
        listEquals(other.genres, genres);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        posterPath.hashCode ^
        backdropPath.hashCode ^
        overView.hashCode ^
        releaseDate.hashCode ^
        genreIds.hashCode ^
        voteAverage.hashCode ^
        runtime.hashCode ^
        genres.hashCode;
  }
}
