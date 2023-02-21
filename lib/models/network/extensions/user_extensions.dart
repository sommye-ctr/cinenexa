// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cinenexa/models/network/extensions/extension.dart';

class UserExtensions {
  final int id;
  final DateTime createdAt;
  final Extension extension;
  final String? userData;

  UserExtensions({
    required this.id,
    required this.createdAt,
    required this.extension,
    this.userData,
  });

  UserExtensions copyWith({
    int? id,
    DateTime? createdAt,
    Extension? extension,
    String? userData,
  }) {
    return UserExtensions(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      extension: extension ?? this.extension,
      userData: userData ?? this.userData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.millisecondsSinceEpoch,
      'extension_id': extension.toMap(),
      'user_data': userData
    };
  }

  factory UserExtensions.fromMap(Map<String, dynamic> map) {
    return UserExtensions(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      extension: Extension.fromMap(map['extension_id'] as Map<String, dynamic>),
      userData: map['user_data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserExtensions.fromJson(String source) =>
      UserExtensions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserExtensions(id: $id, createdAt: $createdAt, extension: $extension)';

  @override
  bool operator ==(covariant UserExtensions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.extension == extension &&
        other.userData == userData;
  }

  @override
  int get hashCode =>
      id.hashCode ^ createdAt.hashCode ^ extension.hashCode ^ userData.hashCode;
}
