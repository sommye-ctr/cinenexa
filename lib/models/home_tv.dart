import 'dart:convert';

import 'package:watrix/models/home.dart';

class HomeTv extends Home {
  String name;
  HomeTv({
    required int id,
    required String posterPath,
    required this.name,
    required String backdropPath,
  }) : super(id: id, backdropPath: backdropPath, posterPath: posterPath);

  HomeTv copyWith({
    int? id,
    String? posterPath,
    String? name,
    String? backdropPath,
  }) {
    return HomeTv(
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      name: name ?? this.name,
      backdropPath: backdropPath ?? this.backdropPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_path': posterPath,
      'name': name,
      'backdrop_path': backdropPath,
    };
  }

  factory HomeTv.fromMap(Map<String, dynamic> map) {
    return HomeTv(
      id: map['id']?.toInt() ?? 0,
      posterPath: map['poster_path'] ?? '',
      name: map['name'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeTv.fromJson(String source) => HomeTv.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeTv(id: $id, posterPath: $posterPath, name: $name, backdropPath: $backdropPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeTv &&
        other.id == id &&
        other.posterPath == posterPath &&
        other.name == name &&
        other.backdropPath == backdropPath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        posterPath.hashCode ^
        name.hashCode ^
        backdropPath.hashCode;
  }
}
