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
  bool nextEp = false;
  @observable
  bool nextEpInit = false;
  @observable
  bool nextEpCancel = false;

  @observable
  int speedIndex = 0;
  @observable
  int fitIndex = 0;
  @observable
  int subtitleDelay = 0;

  @observable
  Duration position = Duration();
  @observable
  Duration buffered = Duration();

  @observable
  int? selectedSubtitle;

  @observable
  ObservableList<TvEpisode> episodes = <TvEpisode>[].asObservable();
  late int? currentEpIndex, season;
  int? nextEpIndex;

  int seekDuration = 30;
  int nextEpPopupDuration = 30;
  bool autoPlay = false;

  Duration duration = Duration();

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
    int? episode,
  }) {
    episodes.addAll(detailsStore.episodes);
    currentEpIndex = detailsStore.episodes
        .indexWhere((element) => element.episodeNumber == episode);

    init();
  }

  @action
  Future init() async {
    seekDuration = await Database().getSeekDuration();
    nextEpPopupDuration = await Database().getNextEpDuration();
    autoPlay = await Database().getAutoPlay();

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
          setBuffered(
              controller.videoPlayerController!.value.buffered.first.end);
          setPosition(controller.videoPlayerController!.value.position);
          _handleNextEpPopup();
          break;
        case BetterPlayerEventType.play:
          if (casting) controller.pause();
          break;
        default:
      }
    });
  }

  void _handleNextEpPopup() {
    if (!autoPlay || season == null) {
      return;
    }
    Duration? duration = controller.videoPlayerController!.value.duration;
    int diff = duration == null ? 0 : (duration.inSeconds - position.inSeconds);

    if (position.inSeconds >= 1 &&
        diff <= (nextEpPopupDuration + 15) &&
        !nextEpInit) {
      nextEpInit = true;
      if (currentEpIndex == episodes.length - 1) {
        fetchNewEps();
      } else {
        setEpisode();
      }
    } else {
      setNextEpFlag(false);
    }
    if (position.inSeconds >= 1 && diff <= nextEpPopupDuration && !nextEp) {
      setNextEpFlag(true);
    }
  }

  Future initSeek() async {
    controller.videoPlayerController!.seekTo(position);
    duration = controller.videoPlayerController!.value.duration!;
    int seconds = (duration.inMilliseconds * progress!) ~/ 100;

    await controller.play();
    await controller.seekTo(Duration(milliseconds: seconds));
    await controller.play();
  }

  @action
  Future fetchNewEps() async {
    if (detailsStore.tv!.seasons!.length - 1 >=
        detailsStore.chosenSeason! + 1) {
      List<TvEpisode> list =
          await detailsStore.onSeasonChanged(detailsStore.chosenSeason! + 1);
      detailsStore.onEpBackClicked();
      detailsStore.onEpiodeClicked(0);
      nextEpIndex = 0;
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
    nextEpIndex = currentEpIndex! + 1;
    detailsStore.onEpBackClicked();
    detailsStore.onEpiodeClicked(nextEpIndex!);
    fetchStreams();
  }

  @action
  Future fetchStreams() async {
    detailsStore.fetchStreams();
  }

  @action
  void setNextEpFlag(bool value) {
    this.nextEp = value;
  }

  @action
  void setNextEpCancel(bool value) {
    this.nextEpCancel = value;
  }

  @action
  void setDuration(Duration duration) {
    this.duration = duration;
  }

  @action
  void setSubtitleDelay(int delay) {
    subtitleDelay = delay;
  }

  @action
  void setSpeedIndex(int index) {
    speedIndex = index;
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
        type: BetterPlayerSubtitlesSourceType.network,
        urls: [sub.url],
        selectedByDefault: true,
      ),
    );
    setSelectedSubtitle(index);
    /* if (index == -1) {
      controller.setSpuTrack(-1);
      setSelectedSubtitle(null);
      return;
    }

    VlcPlayerSubtitle subtitle = subs[index];
    if (subtitle.vlcId != null) {
      controller.setSpuTrack(subtitle.vlcId!);
      setSelectedSubtitle(subtitle.id);
      return;
    }

    controller.addSubtitleFromNetwork(subtitle.source!, isSelected: true);
    setSelectedSubtitle(subtitle.id); */
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
