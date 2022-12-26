// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TraktUser {
  final String name;
  final String avatar;
  TraktUser({
    required this.name,
    required this.avatar,
  });

  TraktUser copyWith({
    String? name,
    String? avatar,
  }) {
    return TraktUser(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
    };
  }

  factory TraktUser.fromMap(Map<String, dynamic> map) {
    return TraktUser(
      name: map['name'] as String,
      avatar: map['images']['avatar']['full'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TraktUser.fromJson(String source) =>
      TraktUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TraktUser(name: $name, avatar: $avatar)';

  @override
  bool operator ==(covariant TraktUser other) {
    if (identical(this, other)) return true;

    return other.name == name && other.avatar == avatar;
  }

  @override
  int get hashCode => name.hashCode ^ avatar.hashCode;
}
