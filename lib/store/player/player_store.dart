import 'package:mobx/mobx.dart';
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
  int? selectedTrack;

  @observable
  ObservableMap<int, String>? subtitles;
  @observable
  ObservableMap<int, String>? tracks;

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
  void setSubtitles(Map<int, String> sub) {
    subtitles = sub.asObservable();
  }

  @action
  void setTracks(Map<int, String> track) {
    tracks = track.asObservable();
  }

  @action
  void setSelectedTrack(int? track) {
    selectedTrack = track;
  }

  @action
  void setSelectedSubtitle(int? subtitle) {
    selectedSubtitle = subtitle;
  }
}
