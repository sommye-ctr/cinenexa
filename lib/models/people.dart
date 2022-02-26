import 'dart:convert';

class People {
  int id;
  String name;
  String profilePath;
  double popularity;
  People({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.popularity,
  }) : super();

  People copyWith({
    int? id,
    String? name,
    String? profilePath,
    double? popularity,
  }) {
    return People(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePath: profilePath ?? this.profilePath,
      popularity: popularity ?? this.popularity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profilePath': profilePath,
      'popularity': popularity,
    };
  }

  factory People.fromMap(Map<String, dynamic> map) {
    return People(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory People.fromJson(String source) => People.fromMap(json.decode(source));

  @override
  String toString() {
    return 'People(id: $id, name: $name, profilePath: $profilePath, popularity: $popularity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is People &&
        other.id == id &&
        other.name == name &&
        other.profilePath == profilePath &&
        other.popularity == popularity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        profilePath.hashCode ^
        popularity.hashCode;
  }
}
