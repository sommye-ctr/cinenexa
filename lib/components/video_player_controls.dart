import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/custom_checkbox_list.dart';
import 'package:provider/provider.dart';

import '../models/network/base_model.dart';
import '../models/network/extensions/extension_stream.dart';
import '../models/network/movie.dart';
import '../models/network/tv.dart';
import '../services/local/scrobble_manager.dart';
import '../store/player/player_store.dart';
import '../store/user/user_store.dart';

class VideoPlayerControls extends StatefulWidget {
  final BetterPlayerController controller;

  final int? id;
  final BaseModel? baseModel;
  final Movie? movie;
  final Tv? show;
  final int? season, episode;
  final double? progress;
  final int? fitIndex;

  final GlobalKey? playerKey;

  final ExtensionStream stream;
  const VideoPlayerControls({
    Key? key,
    required this.controller,
    required this.stream,
    this.baseModel,
    this.id,
    this.movie,
    this.show,
    this.episode,
    this.season,
    this.progress,
    this.playerKey,
    this.fitIndex,
  }) : super(key: key);

  @override
  State<VideoPlayerControls> createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  static const double iconSize = 60;
  static const Duration hideDuration = Duration(seconds: 5);

  Timer? hideTimer;
  ScrobbleManager? scrobbleManager;
  late PlayerStore playerStore;

  @override
  void initState() {
    super.initState();
    bool traktLogged =
        Provider.of<UserStore>(context, listen: false).isTraktLogged;
    scrobbleManager = ScrobbleManager(
      playerController: widget.controller,
      item: widget.baseModel!,
      isTraktLogged: traktLogged,
      episode: widget.episode,
      movie: widget.movie,
      season: widget.season,
      show: widget.show,
      id: widget.id,
    );

    playerStore = PlayerStore(
      controller: widget.controller,
      extensionStream: widget.stream,
      progress: widget.progress,
    );
    if (widget.fitIndex != null) playerStore.setFitIndex(widget.fitIndex!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBack,
        child: Observer(builder: (_) {
          playerStore.buffering;
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              playerStore.showControls
                  ? _hideControls()
                  : _cancelAndRestartTimer();
            },
            child: Observer(
              builder: (context) {
                if (playerStore.showControls) {
                  if (playerStore.locked) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: _buildControlButton(
                          icon: Icons.lock_outline_rounded,
                          onTap: () {
                            setState(() {
                              playerStore.setLocked(false);
                            });
                          },
                          size: 25,
                          overlay: true,
                        ),
                      ),
                    );
                  }
                  return Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.black54,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopPanel(),
                          _buildMainControls(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildProgressBar(),
                              _buildBottomControls(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          );
        }));
  }

  Future<bool> _onBack() async {
    scrobbleManager?.exit();
    widget.controller.exitFullScreen();
    return true;
  }

  @override
  void dispose() {
    hideTimer?.cancel();
    super.dispose();
  }

  void _cancelAndRestartTimer() {
    hideTimer?.cancel();
    playerStore.setShowControls(true);
    hideTimer = Timer(hideDuration, () => _hideControls());
  }

  void _hideControls() {
    playerStore.setShowControls(false);
  }

  Widget _buildTopPanel() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildControlButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.maybePop(context),
                size: 30,
              ),
              _buildTitle(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Observer(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: ScreenSize.getPercentOfHeight(context, 0.05),
        ),
        child: ProgressBar(
          progress: playerStore.position,
          total: playerStore.controller.videoPlayerController!.value.duration ??
              Duration(),
          barHeight: 3,
          timeLabelLocation: TimeLabelLocation.sides,
          buffered: playerStore.buffered,
          onSeek: (value) {
            widget.controller.seekTo(value);
          },
          baseBarColor: Colors.white24,
          bufferedBarColor: Colors.grey,
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          widget.baseModel!.title!,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(
            icon: Icons.restore_rounded,
            onTap: () {
              widget.controller.seekTo(Duration());
            },
            size: 25,
            overlay: true,
          ),
          Style.getVerticalHorizontalSpacing(context: context),
          _buildControlButton(
            icon: Icons.lock_open_rounded,
            onTap: () {
              playerStore.setLocked(!playerStore.locked);
            },
            size: 25,
            overlay: true,
          ),
          Style.getVerticalHorizontalSpacing(context: context),
          _buildControlButton(
            icon: Icons.closed_caption_off,
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.noHeader,
                width: ScreenSize.getPercentOfWidth(context, 0.7),
                title: Strings.settings,
                body: _buildSubtitlePopup(),
                showCloseIcon: true,
                padding: EdgeInsets.all(8),
                animType: AnimType.bottomSlide,
              ).show();
            },
            size: 25,
            overlay: true,
          ),
          Style.getVerticalHorizontalSpacing(context: context),
          _buildControlButton(
            icon: Icons.settings,
            onTap: () {
              AwesomeDialog(
                context: context,
                width: ScreenSize.getPercentOfWidth(context, 0.7),
                dialogType: DialogType.noHeader,
                title: Strings.settings,
                body: _buildSettingsPopup(),
                showCloseIcon: true,
                padding: EdgeInsets.all(8),
                animType: AnimType.bottomSlide,
              ).show();
            },
            size: 25,
            overlay: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitlePopup() {
    int selected = 0;
    if (widget.stream.subtitles != null &&
        playerStore.selectedSubtitle != null &&
        playerStore.selectedSubtitle! >= 0 &&
        playerStore.selectedSubtitle! <= widget.stream.subtitles!.length) {
      selected = playerStore.selectedSubtitle! + 1;
    }

    List<String> allSubtitles = [
      Strings.none,
    ];

    if (widget.stream.subtitles != null) {
      allSubtitles.addAll(
          widget.stream.subtitles!.map((e) => e.title.toString()).toList());
    }

    return CustomCheckBoxList(
      children: allSubtitles,
      selectedItems: [selected],
      type: CheckBoxListType.grid,
      alwaysEnabled: true,
      singleSelect: true,
      delegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 35,
      ),
      onSelectionAdded: (values) {
        if (values.first == Strings.none) {
          playerStore.changeSubtitle(-1);
          return;
        }
        int selectedIndex = widget.stream.subtitles!
            .indexWhere((element) => element.title == values.first);

        playerStore.changeSubtitle(selectedIndex);

        Navigator.pop(context);
      },
    );
  }

  Widget _buildSettingsPopup() {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(Strings.playBackSpeed),
            Style.getVerticalSpacing(context: context),
            CustomCheckBoxList(
              children: Strings.playbackSpeeds,
              type: CheckBoxListType.grid,
              singleSelect: true,
              delegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisExtent: 35,
              ),
              selectedItems: [playerStore.speedIndex],
              alwaysEnabled: true,
              onSelectionAdded: (values) => _speedChanged(values.first),
            ),
          ],
        ),
        Style.getVerticalSpacing(context: context, percent: 0.1),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(Strings.fit),
            Style.getVerticalSpacing(context: context),
            CustomCheckBoxList(
              children: Strings.fitTypes,
              type: CheckBoxListType.grid,
              delegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 35,
              ),
              singleSelect: true,
              selectedItems: [playerStore.fitIndex],
              alwaysEnabled: true,
              onSelectionAdded: (values) => _fitChanged(values.first),
            ),
          ],
        ),
      ],
    );
  }

  void _fitChanged(String value) {
    BoxFit boxFit = BoxFit.contain;
    if (value == Strings.fitTypes[0]) {
      boxFit = BoxFit.contain;
      playerStore.setFitIndex(0);
    } else if (value == Strings.fitTypes[1]) {
      boxFit = BoxFit.fill;
      playerStore.setFitIndex(1);
    } else if (value == Strings.fitTypes[2]) {
      boxFit = BoxFit.cover;
      playerStore.setFitIndex(2);
    }
    widget.controller.pause();
    widget.controller.setOverriddenFit(boxFit);
    widget.controller.play();
  }

  void _speedChanged(String value) {
    double speed = 1;
    if (value == Strings.playbackSpeeds[1]) {
      speed = 0.25;
      playerStore.setSpeedIndex(1);
    } else if (value == Strings.playbackSpeeds[2]) {
      speed = 0.5;
      playerStore.setSpeedIndex(2);
    } else if (value == Strings.playbackSpeeds[3]) {
      speed = 0.75;
      playerStore.setSpeedIndex(3);
    } else if (value == Strings.playbackSpeeds[4]) {
      speed = 1.25;
      playerStore.setSpeedIndex(4);
    } else if (value == Strings.playbackSpeeds[5]) {
      speed = 1.5;
      playerStore.setSpeedIndex(5);
    } else if (value == Strings.playbackSpeeds[6]) {
      speed = 2;
      playerStore.setSpeedIndex(6);
    } else if (value == Strings.playbackSpeeds[0]) {
      speed = 1;
      playerStore.setSpeedIndex(7);
    } else if (value == Strings.playbackSpeeds[7]) {
      speed = 1.75;
      playerStore.setSpeedIndex(8);
    }
    widget.controller.setSpeed(speed);
  }

  Widget _buildMainControls() {
    return Align(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildControlButton(
            icon: playerStore.seekDuration == 30
                ? Icons.replay_30_rounded
                : Icons.replay_10_rounded,
            onTap: () {
              Duration rewind = Duration(
                seconds: playerStore.position.inSeconds -
                    (playerStore.seekDuration == 30 ? 30 : 10),
              );

              widget.controller.seekTo(rewind);
            },
          ),
          _buildControlButton(
            icon: widget.controller.isPlaying()!
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
            onTap: () {
              setState(() {
                widget.controller.isPlaying()!
                    ? widget.controller.pause()
                    : widget.controller.play();
              });
            },
          ),
          _buildControlButton(
            icon: playerStore.seekDuration == 30
                ? Icons.forward_30_rounded
                : Icons.forward_10_rounded,
            onTap: () {
              Duration forward = Duration(
                seconds: playerStore.position.inSeconds +
                    (playerStore.seekDuration == 30 ? 30 : 10),
              );

              if (forward >
                  widget.controller.videoPlayerController!.value.duration!) {
                widget.controller.seekTo(Duration(seconds: 0));
              } else {
                widget.controller.seekTo(forward);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
      {required IconData icon,
      required Function() onTap,
      double? size,
      bool overlay = false}) {
    return ClipOval(
      child: Material(
        color: overlay ? Colors.white.withOpacity(0.1) : Colors.transparent,
        child: InkWell(
          splashColor: Colors.white30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              size: size ?? iconSize,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
