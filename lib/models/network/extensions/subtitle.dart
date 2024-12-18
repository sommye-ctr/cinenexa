// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

part 'subtitle.g.dart';

@embedded
class Subtitle {
  String? title;
  String? url;

  @Name("zPath")
  String? path;

  Subtitle();
  Subtitle.def({
    required this.title,
    this.url,
    this.path,
  });

  Subtitle copyWith({
    String? title,
    String? url,
  }) {
    return Subtitle.def(
      title: title ?? this.title,
      url: url ?? this.url,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
      'path': path,
    };
  }

  factory Subtitle.fromMap(Map<String, dynamic> map) {
    return Subtitle.def(
      title: map['title'] != null ? map['title'] as String : "Unknown",
      url: map['url'] != null ? map['url'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Subtitle.fromJson(String source) =>
      Subtitle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Subtitle(title: $title, url: $url)';

  @override
  bool operator ==(covariant Subtitle other) {
    if (identical(this, other)) return true;

    return other.title == title && other.url == url;
  }

  @override
  int get hashCode => title.hashCode ^ url.hashCode;
}
