import 'dart:convert';

class Video {
  final String name;
  final String key;

  Video({
    required this.name,
    required this.key,
  });

  Video copyWith({
    String? name,
    String? key,
  }) {
    return Video(
      name: name ?? this.name,
      key: key ?? this.key,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'key': key,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      name: map['name'] ?? '',
      key: map['key'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));

  @override
  String toString() => 'Video(name: $name, key: $key)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Video && other.name == name && other.key == key;
  }

  @override
  int get hashCode => name.hashCode ^ key.hashCode;
}
