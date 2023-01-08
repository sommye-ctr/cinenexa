import 'package:isar/isar.dart';
import 'package:cinenexa/models/network/genre.dart';
import 'package:cinenexa/models/network/movie.dart';
import 'package:cinenexa/models/network/trakt/trakt_progress.dart';
import 'package:cinenexa/models/network/tv.dart';

import '../network/tv_season.dart';

part 'progress.g.dart';

@Collection()
class Progress {
  Id? id;

  late double progress;
  late String type;
  int? seasonNo;
  int? episodeNo;

  Movie? movie;
  Tv? show;
  int? playbackId;

  @Index()
  DateTime? pausedAt;
}

extension ProgressConverter on Progress {
  TraktProgress getTraktProgress() {
    return TraktProgress(
      type: this.type,
      episodeNo: this.episodeNo,
      movie: this.movie,
      progress: this.progress,
      seasonNo: this.seasonNo,
      show: this.show,
      pausedAt: this.pausedAt,
      playbackId: this.playbackId,
    );
  }
}
