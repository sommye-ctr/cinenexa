import 'dart:convert';

import 'package:watrix/models/home.dart';

class HomeMovie extends Home {
  String title;

  HomeMovie({
    required int id,
    required String posterPath,
    required this.title,
    required String backdropPath,
  }) : super(id: id, backdropPath: backdropPath, posterPath: posterPath);

  HomeMovie copyWith({
    int? id,
    String? posterPath,
    String? title,
    String? backdropPath,
  }) {
    return HomeMovie(
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      title: title ?? this.title,
      backdropPath: backdropPath ?? this.backdropPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_path': posterPath,
      'title': title,
      'backdrop_path': backdropPath,
    };
  }

  factory HomeMovie.fromMap(Map<String, dynamic> map) {
    return HomeMovie(
      id: map['id']?.toInt() ?? 0,
      posterPath: map['poster_path'] ?? '',
      title: map['title'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeMovie.fromJson(String source) =>
      HomeMovie.fromMap(json.decode(source));

  @override
  String toString() => 'Home(id: $id, posterPath: $posterPath, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeMovie &&
        other.id == id &&
        other.posterPath == posterPath &&
        other.title == title &&
        other.backdropPath == backdropPath;
  }

  @override
  int get hashCode => id.hashCode ^ posterPath.hashCode ^ title.hashCode;
}
