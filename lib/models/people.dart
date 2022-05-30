import 'dart:convert';

class People {
  int id;
  String name;
  String profilePath;
  double popularity;

  String? birthday;
  String? biography;
  String? placeOfBirth;

  People({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.popularity,
    this.birthday,
    this.biography,
    this.placeOfBirth,
  }) : super();

  People copyWith({
    int? id,
    String? name,
    String? profilePath,
    double? popularity,
    String? birthday,
    String? biography,
    String? placeOfBirth,
  }) {
    return People(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePath: profilePath ?? this.profilePath,
      popularity: popularity ?? this.popularity,
      birthday: birthday ?? this.birthday,
      biography: biography ?? this.biography,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profile_path': profilePath,
      'popularity': popularity,
      'birthday': birthday,
      'biography': biography,
      'place_of_birth': placeOfBirth,
    };
  }

  factory People.fromMap(Map<String, dynamic> map) {
    return People(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      birthday: map['birthday'],
      biography: map['biography'],
      placeOfBirth: map['place_of_birth'],
    );
  }

  String toJson() => json.encode(toMap());

  factory People.fromJson(String source) => People.fromMap(json.decode(source));

  @override
  String toString() {
    return 'People(id: $id, name: $name, profilePath: $profilePath, popularity: $popularity, birthday: $birthday, biography: $biography, placeOfBirth: $placeOfBirth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is People &&
        other.id == id &&
        other.name == name &&
        other.profilePath == profilePath &&
        other.popularity == popularity &&
        other.birthday == birthday &&
        other.biography == biography &&
        other.placeOfBirth == placeOfBirth;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        profilePath.hashCode ^
        popularity.hashCode ^
        birthday.hashCode ^
        biography.hashCode ^
        placeOfBirth.hashCode;
  }
}
