// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserStats {
  int moviesWatched;
  int moviesMinutes;
  int showsWatched;
  int showsMinutes;
  UserStats({
    required this.moviesWatched,
    required this.moviesMinutes,
    required this.showsWatched,
    required this.showsMinutes,
  });

  UserStats copyWith({
    int? moviesWatched,
    int? moviesMinutes,
    int? showsWatched,
    int? showsMinutes,
  }) {
    return UserStats(
      moviesWatched: moviesWatched ?? this.moviesWatched,
      moviesMinutes: moviesMinutes ?? this.moviesMinutes,
      showsWatched: showsWatched ?? this.showsWatched,
      showsMinutes: showsMinutes ?? this.showsMinutes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'moviesWatched': moviesWatched,
      'moviesMinutes': moviesMinutes,
      'showsWatched': showsWatched,
      'showsMinutes': showsMinutes,
    };
  }

  factory UserStats.fromMap(Map<String, dynamic> map) {
    return UserStats(
      moviesWatched: map['movies']['watched'] as int,
      moviesMinutes: map['movies']['minutes'] as int,
      showsWatched: map['shows']['watched'] as int,
      showsMinutes: map['episodes']['minutes'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserStats.fromJson(String source) =>
      UserStats.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserStats(moviesWatched: $moviesWatched, moviesMinutes: $moviesMinutes, showsWatched: $showsWatched, showsMinutes: $showsMinutes)';
  }

  @override
  bool operator ==(covariant UserStats other) {
    if (identical(this, other)) return true;

    return other.moviesWatched == moviesWatched &&
        other.moviesMinutes == moviesMinutes &&
        other.showsWatched == showsWatched &&
        other.showsMinutes == showsMinutes;
  }

  @override
  int get hashCode {
    return moviesWatched.hashCode ^
        moviesMinutes.hashCode ^
        showsWatched.hashCode ^
        showsMinutes.hashCode;
  }
}
