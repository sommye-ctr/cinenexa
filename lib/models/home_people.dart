import 'dart:convert';

import 'package:watrix/models/home.dart';

class HomePeople extends Home {
  String name;
  String profilePath;
  HomePeople({
    required this.name,
    required this.profilePath,
    required int id,
  }) : super(id: id);

  HomePeople copyWith({
    int? id,
    String? name,
    String? profilePath,
  }) {
    return HomePeople(
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

  factory HomePeople.fromMap(Map<String, dynamic> map) {
    return HomePeople(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePeople.fromJson(String source) =>
      HomePeople.fromMap(json.decode(source));

  @override
  String toString() => 'HomePeople(name: $name, profilePath: $profilePath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomePeople &&
        other.name == name &&
        other.profilePath == profilePath;
  }

  @override
  int get hashCode => name.hashCode ^ profilePath.hashCode;
}
