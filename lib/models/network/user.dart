// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CineNexaUser {
  String id;
  String name;
  String avatar;
  String email;
  CineNexaUser({
    required this.id,
    required this.name,
    required this.avatar,
    required this.email,
  });

  CineNexaUser copyWith({
    String? name,
    String? avatar,
    String? email,
    String? id,
  }) {
    return CineNexaUser(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
      'email': email,
      'id': id,
    };
  }

  factory CineNexaUser.fromMap(Map<String, dynamic> map) {
    return CineNexaUser(
      name: map['name'] as String,
      avatar: map['images']['avatar']['full'] as String,
      email: map['email'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CineNexaUser.fromJson(String source) =>
      CineNexaUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, avatar: $avatar)';

  @override
  bool operator ==(covariant CineNexaUser other) {
    if (identical(this, other)) return true;

    return other.name == name && other.avatar == avatar && other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ avatar.hashCode ^ email.hashCode;
}
