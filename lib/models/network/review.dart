import 'dart:convert';

class Review {
  final String? author;
  final String? avatar;
  final int? rating;
  final String? content;
  final String? createdAt;
  Review({
    this.author,
    this.avatar,
    this.rating,
    this.content,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author,
      'avatar': avatar,
      'rating': rating,
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      author: map['author'] != null ? map['author'] as String : null,
      avatar: map['author_details']['avatar_path'] != null
          ? map['author_details']['avatar_path'] as String
          : null,
      rating: map['author_details']['rating'] != null
          ? (map['author_details']['rating'] as double).toInt()
          : null,
      content: map['content'] != null ? map['content'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(author: $author, avatar: $avatar, rating: $rating, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.author == author &&
        other.avatar == avatar &&
        other.rating == rating &&
        other.content == content &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return author.hashCode ^
        avatar.hashCode ^
        rating.hashCode ^
        content.hashCode ^
        createdAt.hashCode;
  }
}
