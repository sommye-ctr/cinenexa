import 'package:isar/isar.dart';
import 'package:cinenexa/models/network/genre.dart';
import 'package:cinenexa/models/network/movie.dart';
import 'package:cinenexa/models/network/trakt/trakt_progress.dart';
import 'package:cinenexa/models/network/tv.dart';

import '../network/base_model.dart';
import '../network/extensions/extension.dart';
import '../network/extensions/extension_stream.dart';
import '../network/extensions/subtitle.dart';
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

  ExtensionStream? stream;
  int? subtitle;
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

  BaseModel getBaseModel() {
    bool isMovie = this.movie != null;
    return BaseModel(
      backdropPath: isMovie ? this.movie!.backdropPath : show!.backdropPath,
      genreIds: isMovie ? movie!.genreIds : show!.genreIds,
      id: isMovie ? movie!.id : show!.id,
      overview: isMovie ? movie!.overView : show!.overview,
      posterPath: isMovie ? movie!.posterPath : show!.posterPath,
      releaseDate: isMovie ? movie!.releaseDate : show!.firstAirDate,
      title: isMovie ? movie!.title : show!.name,
      type: isMovie ? BaseModelType.movie : BaseModelType.tv,
      voteAverage: isMovie ? movie!.voteAverage : show!.voteAverage,
    );
  }
}
