// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Review {
  final String? user;
  final int? rating;
  final String? comment;
  final String? createdAt;
  final bool? review;

  Review({
    this.user,
    this.rating,
    this.comment,
    this.createdAt,
    this.review,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
      'review': review,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      user: map['user']['name'] != null ? map['user']['name'] as String : null,
      rating: map['user_stats']['rating'] != null
          ? map['user_stats']['rating'] as int
          : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
      review: map['review'] != null ? map['review'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(user: $user, rating: $rating, comment: $comment, createdAt: $createdAt, review: $review)';
  }
}
