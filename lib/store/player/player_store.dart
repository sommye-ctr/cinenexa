import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:mobx/mobx.dart';
import 'package:watrix/models/local/vlc_player_subtitles.dart';
import 'package:watrix/models/network/extensions/extension_stream.dart';
import 'package:watrix/services/local/database.dart';
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

  //@observable
  //ObservableMap<int, String>? subtitles;

  @observable
  ObservableList<VlcPlayerSubtitle> subs = <VlcPlayerSubtitle>[].asObservable();

  @observable
  ObservableMap<int, String>? tracks;

  @observable
  int seekDuration = 30;

  int duration = 0;
  bool initialCalled = false;
  String? castingDevice;

  final VlcPlayerController controller;
  final ExtensionStream extensionStream;
  final double? progress;

  _PlayerStoreBase({
    required this.controller,
    required this.extensionStream,
    this.progress,
  }) {
    init();
  }

  @action
  Future init() async {
    seekDuration = await Database().getSeekDuration();
    controller.addOnRendererEventListener((event, p1, p2) {
      if (event == VlcRendererEventType.detached) {
        setCasting(false);
      }
    });

    if (extensionStream.subtitles != null &&
        extensionStream.subtitles!.isNotEmpty) {
      for (var element in extensionStream.subtitles!) {
        subs.add(VlcPlayerSubtitle(
          name: element.title,
          source: element.url,
        ));
      }
    }

    controller.addListener(() async {
      if (controller.value.playingState == PlayingState.buffering) {
        setBuffering(true);
      } else {
        setBuffering(false);
      }

      if (controller.value.isInitialized) {
        duration = controller.value.duration.inMilliseconds;
        controller.startRendererScanning();
      }

      if (controller.value.playingState == PlayingState.playing) {
        if (!initialCalled) {
          if (progress != null) {
            int seconds = (duration * progress!) ~/ 100;

            await controller.pause();
            await controller.play();
            await controller.seekTo(Duration(milliseconds: seconds));
          }

          setTracks(await controller.getAudioTracks());
          setSelectedTrack(await controller.getAudioTrack());

          var list = await controller.getSpuTracks();
          list.forEach(
            (key, value) {
              subs.add(VlcPlayerSubtitle(
                name: value,
                vlcId: key,
              ));
            },
          );
          setSelectedSubtitle(await controller.getSpuTrack());

          initialCalled = true;
        }

        setPosition(controller.value.position);
        setBuffered(
          Duration(seconds: (controller.value.bufferPercent * duration) ~/ 100),
        );
      }
    });
  }

  @action
  void setSubtitleDelay(int delay) {
    subtitleDelay = delay;
  }

  void setCastingDevice(String device) {
    castingDevice = device;
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
  void changeSubtitle(int index) {
    if (index == -1) {
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
    setSelectedSubtitle(subtitle.id);
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

  @action
  void setCasting(bool status) {
    casting = status;
  }
}
