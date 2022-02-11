import 'dart:convert';

class People {
  int id;
  String name;
  String profilePath;
  People({
    required this.name,
    required this.profilePath,
    required this.id,
  }) : super();

  People copyWith({
    int? id,
    String? name,
    String? profilePath,
  }) {
    return People(
      name: name ?? this.name,
      profilePath: profilePath ?? this.profilePath,
      id: this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_path': profilePath,
    };
  }

  factory People.fromMap(Map<String, dynamic> map) {
    return People(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory People.fromJson(String source) => People.fromMap(json.decode(source));

  @override
  String toString() => 'HomePeople(name: $name, profilePath: $profilePath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is People &&
        other.name == name &&
        other.profilePath == profilePath;
  }

  @override
  int get hashCode => name.hashCode ^ profilePath.hashCode;
}
