import 'package:isar/isar.dart';
import 'package:watrix/models/network/movie.dart';
import 'package:watrix/models/network/trakt/trakt_progress.dart';
import 'package:watrix/models/network/tv.dart';
import 'package:watrix/services/local/movie_type_converter.dart';
import 'package:watrix/services/local/show_type_converter.dart';

part 'progress.g.dart';

@Collection()
class Progress {
  @Id()
  late int id;

  late double progress;
  late String type;
  int? seasonNo;
  int? episodeNo;

  @MovieTypeConverter()
  Movie? movie;
  @ShowTypeConverter()
  Tv? show;
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
    );
  }
}
