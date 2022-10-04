// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:watrix/models/local/progress.dart';
import 'package:watrix/models/network/movie.dart';
import 'package:watrix/models/network/tv.dart';

import '../../../utils/date_time_formatter.dart';

class TraktProgress {
  double? progress;
  String? type;

  Movie? movie;
  Tv? show;
  int? seasonNo;
  int? episodeNo;
  DateTime? pausedAt;
  int? playbackId;
  TraktProgress({
    this.progress,
    this.type,
    this.movie,
    this.show,
    this.seasonNo,
    this.episodeNo,
    this.pausedAt,
    this.playbackId,
  });

  TraktProgress copyWith({
    double? progress,
    String? type,
    Movie? movie,
    Tv? show,
    int? seasonNo,
    int? episodeNo,
  }) {
    return TraktProgress(
      progress: progress ?? this.progress,
      type: type ?? this.type,
      movie: movie ?? this.movie,
      show: show ?? this.show,
      seasonNo: seasonNo ?? this.seasonNo,
      episodeNo: episodeNo ?? this.episodeNo,
      pausedAt: pausedAt ?? this.pausedAt,
      playbackId: playbackId ?? this.playbackId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'progress': progress,
      'type': type,
      'movie': movie?.toMap(),
      'show': show?.toMap(),
      'seasonNo': seasonNo,
      'episodeNo': episodeNo,
      'pausedAt': pausedAt,
      'playbackId': playbackId,
    };
  }

  factory TraktProgress.fromMap(Map<String, dynamic> map) {
    return TraktProgress(
        progress: map['progress'] != null ? map['progress'] as double : null,
        type: map['type'] != null ? map['type'] as String : null,
        movie: map['movie'] != null
            ? Movie.fromMap(map['movie'] as Map<String, dynamic>)
            : null,
        show: map['show'] != null
            ? Tv.fromMap(map['show'] as Map<String, dynamic>)
            : null,
        seasonNo: map['seasonNo'] != null ? map['seasonNo'] as int : null,
        episodeNo: map['episodeNo'] != null ? map['episodeNo'] as int : null,
        playbackId: map['id'] != null ? map['id'] : null,
        pausedAt: map['paused_at'] != null
            ? DateTimeFormatter.parseDate(map['paused_at'])
            : null);
  }

  String toJson() => json.encode(toMap());

  factory TraktProgress.fromJson(String source) =>
      TraktProgress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TraktProgress(progress: $progress, type: $type, movie: $movie, show: $show, seasonNo: $seasonNo, episodeNo: $episodeNo)';
  }

  @override
  bool operator ==(covariant TraktProgress other) {
    if (identical(this, other)) return true;

    return other.progress == progress &&
        other.type == type &&
        other.movie == movie &&
        other.show == show &&
        other.seasonNo == seasonNo &&
        other.episodeNo == episodeNo &&
        other.pausedAt == pausedAt &&
        other.playbackId == playbackId;
  }

  @override
  int get hashCode {
    return progress.hashCode ^
        type.hashCode ^
        movie.hashCode ^
        show.hashCode ^
        seasonNo.hashCode ^
        episodeNo.hashCode ^
        pausedAt.hashCode ^
        playbackId.hashCode;
  }
}

extension TraktProgressConverter on TraktProgress {
  Progress getProgress() {
    if (this.movie == null) {
      return Progress()
        ..episodeNo = this.episodeNo!
        ..progress = this.progress!
        ..seasonNo = this.seasonNo!
        ..type = this.type!
        ..show = this.show!
        ..id = this.show!.id
        ..pausedAt = this.pausedAt
        ..playbackId = this.playbackId;
    }
    return Progress()
      ..progress = this.progress!
      ..type = this.type!
      ..movie = this.movie!
      ..id = this.movie!.id
      ..pausedAt = this.pausedAt
      ..playbackId = this.playbackId;
  }
}
