import 'dart:convert';

import 'package:flutter/foundation.dart';

class Movie {
  String title;
  int id;
  String posterPath;
  String backdropPath;
  String overView;
  String releaseDate;
  List<int> genreIds;
  Movie({
    required this.title,
    required this.id,
    required this.posterPath,
    required this.backdropPath,
    required this.overView,
    required this.releaseDate,
    required this.genreIds,
  });

  Movie copyWith({
    String? title,
    int? id,
    String? posterPath,
    String? backdropPath,
    String? overView,
    String? releaseDate,
    List<int>? genreIds,
  }) {
    return Movie(
      title: title ?? this.title,
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      overView: overView ?? this.overView,
      releaseDate: releaseDate ?? this.releaseDate,
      genreIds: genreIds ?? this.genreIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
      'overView': overView,
      'releaseDate': releaseDate,
      'genreIds': genreIds,
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
      genreIds: List<int>.from(map['genre_ids']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(title: $title, id: $id, posterPath: $posterPath, backdropPath: $backdropPath, overView: $overView, releaseDate: $releaseDate, genreIds: $genreIds)';
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
        listEquals(other.genreIds, genreIds);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        posterPath.hashCode ^
        backdropPath.hashCode ^
        overView.hashCode ^
        releaseDate.hashCode ^
        genreIds.hashCode;
  }
}
