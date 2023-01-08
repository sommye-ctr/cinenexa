import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:cinenexa/models/local/progress.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/movie.dart';
import 'package:cinenexa/models/network/tv.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/trakt_oauth_client.dart';
import 'package:cinenexa/services/network/trakt_repository.dart';

class ScrobbleManager {
  final VlcPlayerController playerController;
  final BaseModel item;
  final Movie? movie;
  final Tv? show;
  final int? season, episode, id;
  final bool isTraktLogged;

  final TraktRepository traktRepository =
      TraktRepository(client: TraktOAuthClient());
  final Database localDb = Database();

  bool pause = false;
  bool scrobbleStarted = false;

  ScrobbleManager({
    required this.playerController,
    required this.item,
    required this.isTraktLogged,
    this.show,
    this.id,
    this.movie,
    this.season,
    this.episode,
  }) {
    playerController;
    playerController.addListener(() {
      PlayingState state = playerController.value.playingState;
      if (state == PlayingState.paused) {
        paused();
        pause = true;
        scrobbleStarted = false;
      }
      if (state == PlayingState.ended) {
        stopped();
      }
      if (state == PlayingState.playing) {
        if (pause && !scrobbleStarted) {
          start();
        }
        pause = false;
      }
    });
  }

  void start() {
    scrobbleStarted = true;
    double progress = _getProgress();
    progress;

    if (isTraktLogged) {
      traktRepository
          .scrobbleStart(
        type: item.type!,
        tmdbId: id!,
        progress: _getProgress(),
      )
          .then(
        (value) {
          localDb.addProgress(progress: _getProgressObject());
        },
      );
    } else {
      localDb.addProgress(progress: _getProgressObject());
    }
  }

  void paused() {
    double progress = _getProgress();
    if (playerController.value.isEnded) {
      stopped();
      return;
    }
    if (progress >= 90) {
      stopped();
      return;
    }
    localDb.addProgress(progress: _getProgressObject());

    if (isTraktLogged)
      traktRepository.scrobblePause(
        type: item.type!,
        tmdbId: id!,
        progress: _getProgress(),
      );
  }

  void stopped() {
    if (isTraktLogged) {
      traktRepository
          .scrobbleStop(
            type: item.type!,
            tmdbId: id!,
            progress: _getProgress(),
          )
          .whenComplete(() => localDb.removeProgress(tmdbId: id!));
    } else {
      localDb.removeProgress(tmdbId: id!);
    }
  }

  Progress _getProgressObject() {
    return Progress()
      ..id = item.id
      ..pausedAt = DateTime.now().toUtc()
      ..progress = _getProgress()
      ..movie = movie
      ..show = show
      ..episodeNo = episode
      ..seasonNo = season
      ..type = item.type == BaseModelType.movie ? "movie" : "episode";
  }

  double _getProgress() {
    return (playerController.value.position.inSeconds /
            playerController.value.duration.inSeconds) *
        100;
  }
}
