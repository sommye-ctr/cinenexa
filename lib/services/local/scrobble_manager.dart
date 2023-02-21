import 'package:better_player/better_player.dart';
import 'package:cinenexa/models/local/progress.dart';
import 'package:cinenexa/models/local/show_history.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/movie.dart';
import 'package:cinenexa/models/network/tv.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/trakt_oauth_client.dart';
import 'package:cinenexa/services/network/trakt_repository.dart';
import 'package:cinenexa/store/player/player_store.dart';

class ScrobbleManager {
  final BetterPlayerController playerController;
  final BaseModel item;
  final Movie? movie;
  final Tv? show;
  final int? season, episode, id;
  final bool isTraktLogged;
  final PlayerStore playerStore;
  final ShowHistory? showHistory;
  final int? episodeId;

  final TraktRepository traktRepository =
      TraktRepository(client: TraktOAuthClient());
  final Database localDb = Database();

  ScrobbleManager({
    required this.playerController,
    required this.item,
    required this.isTraktLogged,
    required this.playerStore,
    this.showHistory,
    this.episodeId,
    this.show,
    this.id,
    this.movie,
    this.season,
    this.episode,
  }) {
    playerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
        paused();
      } else if (event.betterPlayerEventType ==
          BetterPlayerEventType.finished) {
        stopped();
      } else if (event.betterPlayerEventType == BetterPlayerEventType.play) {
        start();
      }
    });

    /* playerController.addListener(() {
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
    }); */
  }

  void start() {
    if (isTraktLogged) {
      traktRepository
          .scrobbleStart(
        type: item.type!,
        tmdbId: item.id!,
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

  void exit() {
    if (_getProgress() > 90) {
      stopped();
      if (item.type == BaseModelType.tv) {
        Database().watchEp(
          episodeNumber: episode!,
          episodeId: episodeId!,
          seasonNo: season,
          showHistory: showHistory,
          baseModelId: item.id!,
          tv: show!,
          isTraktLogged: isTraktLogged,
          repository: TraktRepository(client: TraktOAuthClient()),
        );
      }
      return;
    }
    paused();
  }

  void paused() {
    double progress = _getProgress();

    if (progress >= 90) {
      stopped();
      return;
    }

    localDb.addProgress(progress: _getProgressObject());

    if (isTraktLogged)
      traktRepository.scrobblePause(
        type: item.type!,
        tmdbId: item.id!,
        progress: _getProgress(),
      );
  }

  void stopped() {
    if (isTraktLogged) {
      traktRepository
          .scrobbleStop(
        type: item.type!,
        tmdbId: item.id!,
        progress: _getProgress(),
      )
          .whenComplete(() {
        localDb.removeProgress(tmdbId: item.id!);
      });
    } else {
      localDb.removeProgress(tmdbId: item.id!);
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
      ..stream = playerStore.extensionStream
      ..subtitle = playerStore.selectedSubtitle
      ..type = item.type == BaseModelType.movie ? "movie" : "episode";
  }

  double _getProgress() {
    return (playerController.videoPlayerController!.value.position.inSeconds /
            playerController.videoPlayerController!.value.duration!.inSeconds) *
        100;
  }
}
