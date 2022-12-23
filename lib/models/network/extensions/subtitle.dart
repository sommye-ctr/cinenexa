// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Subtitle {
  final String title;
  final String url;
  Subtitle({
    required this.title,
    required this.url,
  });

  Subtitle copyWith({
    String? title,
    String? url,
  }) {
    return Subtitle(
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
    };
  }

  factory Subtitle.fromMap(Map<String, dynamic> map) {
    return Subtitle(
      title: map['title'] as String,
      url: map['url'] as String,
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
