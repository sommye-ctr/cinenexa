import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:watrix/models/local/favorites.dart';
import 'package:watrix/models/network/people.dart';
import 'package:watrix/models/network/tv.dart';

import 'movie.dart';

class BaseModel {
  BaseModelType? type;
  String? title;
  int? id;
  String? posterPath;
  String? backdropPath;
  String? overview;
  String? releaseDate;
  List<int>? genreIds;
  double? voteAverage;
  BaseModel({
    this.type,
    this.title,
    this.id,
    this.posterPath,
    this.backdropPath,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.voteAverage,
  });

  BaseModel copyWith({
    String? title,
    int? id,
    String? posterPath,
    String? backdropPath,
    String? overview,
    String? releaseDate,
    List<int>? genreIds,
    double? voteAverage,
  }) {
    return BaseModel(
      title: title ?? this.title,
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
      genreIds: genreIds ?? this.genreIds,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'overview': overview,
      'release_date': releaseDate,
      'genre_ids': genreIds,
      'vote_average': voteAverage,
    };
  }

  factory BaseModel.fromMap(Map<String, dynamic> map) {
    BaseModelType type;

    if (map['title'] != null) {
      type = BaseModelType.movie;
    } else if (map['profile_path'] != null) {
      type = BaseModelType.people;
    } else {
      type = BaseModelType.tv;
    }

    String? poster = map['poster_path'] ?? map['profile_path'];
    String title = map['title'] ?? map['name'];
    String? date = map['release_date'] ?? map['first_air_date'];
    List<int>? genre =
        map['genre_ids'] != null ? List<int>.from(map['genre_ids']) : null;
    return BaseModel(
      type: type,
      title: title,
      id: map['id']?.toInt(),
      posterPath: poster,
      backdropPath: map['backdrop_path'],
      overview: map['overview'],
      releaseDate: date,
      genreIds: genre,
      voteAverage: (map['vote_average'] ?? map['popularity']).toDouble(),
    );
  }

  factory BaseModel.fromMovie(Movie movie) {
    return BaseModel(
      type: BaseModelType.movie,
      backdropPath: movie.backdropPath,
      posterPath: movie.posterPath,
      id: movie.id,
      overview: movie.overView,
      title: movie.title,
      voteAverage: movie.voteAverage,
      genreIds: movie.genreIds,
      releaseDate: movie.releaseDate,
    );
  }

  factory BaseModel.fromFavorite(Favorites favorites) {
    return BaseModel(
      type: BaseModelType.values.byName(favorites.type),
      backdropPath: favorites.backdropPath,
      genreIds: favorites.genreIds,
      id: favorites.id,
      overview: favorites.overview,
      posterPath: favorites.posterPath,
      releaseDate: favorites.releaseDate,
      title: favorites.title,
      voteAverage: favorites.voteAverage,
    );
  }

  Favorites toFavorite() {
    return Favorites()
      ..backdropPath = backdropPath!
      ..genreIds = genreIds!
      ..id = id!
      ..overview = overview!
      ..posterPath = posterPath!
      ..releaseDate = releaseDate!
      ..title = title!
      ..voteAverage = voteAverage!
      ..type = type!.toString().split('.').last;
  }

  factory BaseModel.fromTv(Tv tv) {
    return BaseModel(
      type: BaseModelType.tv,
      backdropPath: tv.backdropPath,
      posterPath: tv.posterPath,
      id: tv.id,
      overview: tv.overview,
      title: tv.name,
      voteAverage: tv.voteAverage,
      genreIds: tv.genreIds,
      releaseDate: tv.firstAirDate,
    );
  }

  factory BaseModel.fromPeople(People people) {
    return BaseModel(
      type: BaseModelType.people,
      id: people.id,
      title: people.name,
      posterPath: people.profilePath,
      voteAverage: people.popularity,
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseModel.fromJson(String source) =>
      BaseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BaseModel(title: $title, id: $id, posterPath: $posterPath, backdropPath: $backdropPath, overview: $overview, releaseDate: $releaseDate, genreIds: $genreIds, voteAverage: $voteAverage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseModel &&
        other.title == title &&
        other.id == id &&
        other.posterPath == posterPath &&
        other.backdropPath == backdropPath &&
        other.overview == overview &&
        other.releaseDate == releaseDate &&
        listEquals(other.genreIds, genreIds) &&
        other.voteAverage == voteAverage;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        posterPath.hashCode ^
        backdropPath.hashCode ^
        overview.hashCode ^
        releaseDate.hashCode ^
        genreIds.hashCode ^
        voteAverage.hashCode;
  }
}

enum BaseModelType {
  movie,
  tv,
  people,
}

extension BaseConverter on BaseModelType {
  String getString() {
    switch (this) {
      case BaseModelType.movie:
        return "movie";
      case BaseModelType.tv:
        return "show";
      case BaseModelType.people:
        return "people";
    }
  }
}
