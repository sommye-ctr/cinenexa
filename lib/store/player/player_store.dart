import 'package:better_player/better_player.dart';
import 'package:cinenexa/models/network/extensions/subtitle.dart';
import 'package:mobx/mobx.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:cinenexa/services/local/database.dart';

import '../../models/network/tv_episode.dart';
import '../details/details_store.dart';
part 'player_store.g.dart';

class PlayerStore = _PlayerStoreBase with _$PlayerStore;

abstract class _PlayerStoreBase with Store {
  @observable
  bool showControls = true;
  @observable
  bool buffering = true;
  @observable
  bool locked = false;
  @observable
  bool casting = false;
  @observable
  bool playing = false;

  @observable
  int speedIndex = 1;
  @observable
  int fitIndex = 0;

  @observable
  Duration position = Duration();
  @observable
  Duration buffered = Duration();

  @observable
  int? selectedSubtitle;

  @observable
  ObservableList<TvEpisode> episodes = <TvEpisode>[].asObservable();
  late int? currentEpIndex, season;

  int seekDuration = 30;

  Duration duration = Duration();
  bool initDone = false;

  final BetterPlayerController controller;
  final ExtensionStream extensionStream;
  final DetailsStore detailsStore;
  final double? progress;

  _PlayerStoreBase({
    required this.controller,
    required this.extensionStream,
    required this.detailsStore,
    this.progress,
    this.season,
  }) {
    episodes.addAll(detailsStore.episodes);

    init();
  }

  @action
  Future init() async {
    seekDuration = await Database().getSeekDuration();
    controller.addEventsListener((event) {
      switch (event.betterPlayerEventType) {
        case BetterPlayerEventType.bufferingStart:
          setBuffering(true);
          break;
        case BetterPlayerEventType.bufferingEnd:
          setBuffering(false);
          break;
        case BetterPlayerEventType.initialized:
          initSeek();
          break;
        case BetterPlayerEventType.progress:
          if (buffering == true) {
            setBuffering(false);
          }
          setBuffered(
              controller.videoPlayerController!.value.buffered.first.end);
          setPosition(controller.videoPlayerController!.value.position);
          break;
        case BetterPlayerEventType.play:
          if (casting) controller.pause();
          break;
        default:
      }
    });
  }

  Future initSeek() async {
    controller.videoPlayerController!.seekTo(position);
    duration = controller.videoPlayerController!.value.duration!;
    int seconds = (duration.inMilliseconds * (progress ?? 0)) ~/ 100;

    await controller.play();
    await controller.seekTo(Duration(milliseconds: seconds));
    await controller.play();
    initDone = true;
  }

  @action
  Future fetchNewEps() async {
    if (detailsStore.tv!.seasons!.length - 1 >=
        detailsStore.chosenSeason! + 1) {
      List<TvEpisode> list =
          await detailsStore.onSeasonChanged(detailsStore.chosenSeason! + 1);
      detailsStore.onEpBackClicked();
      detailsStore.onEpiodeClicked(0);
      season =
          detailsStore.tv?.seasons?[detailsStore.chosenSeason!].seasonNumber ??
              0;
      episodes.clear();
      episodes.addAll(list);
      fetchStreams();
    }
  }

  @action
  void setEpisode() {
    int ep = detailsStore.chosenEpisode!;
    detailsStore.onEpBackClicked();
    detailsStore.onEpiodeClicked(ep + 1);
    fetchStreams();
  }

  @action
  Future fetchStreams() async {
    detailsStore.fetchStreams();
  }

  @action
  void seekFoward() {
    Duration forward = Duration(
      seconds: position.inSeconds + seekDuration,
    );

    if (forward > controller.videoPlayerController!.value.duration!) {
      controller.seekTo(Duration(seconds: 0));
    } else {
      controller.seekTo(forward);
    }
    controller.play();
  }

  @action
  void seekBackward() {
    Duration rewind = Duration(
      seconds: position.inSeconds - seekDuration,
    );
    controller.seekTo(rewind);
    controller.play();
  }

  @action
  void setDuration(Duration duration) {
    this.duration = duration;
  }

  @action
  void setSpeedIndex(int index) {
    speedIndex = index;
  }

  @action
  void setPlaying(bool value) {
    playing = value;
  }

  @action
  void setFitIndex(int index) {
    fitIndex = index;
  }

  @action
  void setPosition(Duration duration) {
    position = duration;
  }

  @action
  void setBuffered(Duration duration) {
    buffered = duration;
  }

  @action
  void setShowControls(bool show) {
    showControls = show;
  }

  @action
  void setBuffering(bool buffer) {
    buffering = buffer;
  }

  @action
  void setLocked(bool lock) {
    locked = lock;
  }

  @action
  void addSubtitle(Subtitle sub) {
    extensionStream.addSubtitle(sub);
    changeSubtitle(extensionStream.subtitles!.length - 1);
  }

  @action
  Future changeSubtitle(int index) async {
    if (index < 0) {
      await controller.setupSubtitleSource(BetterPlayerSubtitlesSource());
      setSelectedSubtitle(null);
      return;
    }
    Subtitle sub = extensionStream.subtitles![index];

    await controller.setupSubtitleSource(
      BetterPlayerSubtitlesSource(
        name: sub.title,
        type: sub.path != null
            ? BetterPlayerSubtitlesSourceType.file
            : BetterPlayerSubtitlesSourceType.network,
        urls: [sub.url ?? sub.path],
        selectedByDefault: true,
      ),
    );
    setSelectedSubtitle(index);
  }

  @action
  void setSelectedSubtitle(int? subtitle) {
    selectedSubtitle = subtitle;
  }

  @action
  void setCasting(bool status) {
    casting = status;
  }
}
