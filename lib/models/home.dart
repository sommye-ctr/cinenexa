import 'dart:convert';

class Home {
  int id;
  String posterPath;
  String title;
  Home({
    required this.id,
    required this.posterPath,
    required this.title,
  });

  Home copyWith({
    int? id,
    String? posterPath,
    String? title,
  }) {
    return Home(
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_path': posterPath,
      'title': title,
    };
  }

  factory Home.fromMap(Map<String, dynamic> map) {
    return Home(
      id: map['id']?.toInt() ?? 0,
      posterPath: map['poster_path'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Home.fromJson(String source) => Home.fromMap(json.decode(source));

  @override
  String toString() => 'Home(id: $id, posterPath: $posterPath, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Home &&
        other.id == id &&
        other.posterPath == posterPath &&
        other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ posterPath.hashCode ^ title.hashCode;
}
