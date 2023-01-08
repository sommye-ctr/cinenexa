// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cinenexa/models/network/extensions/extension.dart';

class UserExtensions {
  final String id;
  final DateTime createdAt;
  final Extension extension;
  UserExtensions({
    required this.id,
    required this.createdAt,
    required this.extension,
  });

  UserExtensions copyWith({
    String? id,
    DateTime? createdAt,
    Extension? extension,
  }) {
    return UserExtensions(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      extension: extension ?? this.extension,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.millisecondsSinceEpoch,
      'extension_id': extension.toMap(),
    };
  }

  factory UserExtensions.fromMap(Map<String, dynamic> map) {
    return UserExtensions(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      extension: Extension.fromMap(map['extension_id'] as Map<String, dynamic>),
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
        other.extension == extension;
  }

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode ^ extension.hashCode;
}
