import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:lottie/lottie.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/network/utils.dart';
import 'package:watrix/widgets/rounded_image.dart';

import '../resources/asset.dart';
import '../resources/strings.dart';
import '../resources/style.dart';
import '../utils/screen_size.dart';
import '../widgets/custom_checkbox_list.dart';

class VlcControls extends StatefulWidget {
  final VlcPlayerController controller;
  final BaseModel? baseModel;
  const VlcControls({
    Key? key,
    required this.controller,
    this.baseModel,
  }) : super(key: key);

  @override
  State<VlcControls> createState() => _VlcControlsState();
}

class _VlcControlsState extends State<VlcControls> {
  static const double iconSize = 60;
  static const Duration hideDuration = Duration(seconds: 5);

  int forwardSeek = 30;
  int rewindSeek = 30;

  Duration position = Duration();
  Duration buffered = Duration();
  bool buffering = true;
  bool locked = false;

  Timer? hideTimer;
  bool showControls = true;
  int speedIndex = 0, fitIndex = 0;
  int? selectedSubtitle, selectedTrack;
  Map<int, String>? subtitles, tracks;

  @override
  void initState() {
    super.initState();

    widget.controller.addOnInitListener(() async {
      subtitles = (await widget.controller.getSpuTracks());
      selectedSubtitle = (await widget.controller.getSpuTrack());

      tracks = await widget.controller.getAudioTracks();
      selectedTrack = await widget.controller.getAudioTrack();
    });
    widget.controller.addListener(() async {
      if (widget.controller.value.playingState == PlayingState.buffering) {
        buffering = true;
      } else {
        buffering = false;
      }
      if (widget.controller.value.isInitialized) {
        setState(() {
          position = widget.controller.value.position;
          buffered = Duration(
              seconds: (widget.controller.value.bufferPercent *
                      widget.controller.value.duration.inSeconds)
                  .toInt());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBack,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showControls ? _hideControls() : _cancelAndRestartTimer();
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (buffering) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (showControls) {
                if (locked) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildControlButton(
                      icon: Icons.lock_outline_rounded,
                      onTap: () {
                        setState(() {
                          locked = false;
                        });
                      },
                      size: 25,
                      overlay: true,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
        ));
  }

  Future<bool> _onBack() async {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    await widget.controller.stopRendererScanning();
    await widget.controller.dispose();
    return true;
  }

  @override
  void dispose() {
    hideTimer?.cancel();
    super.dispose();
  }

  void _cancelAndRestartTimer() {
    hideTimer?.cancel();
    setState(() {
      showControls = true;
    });
    hideTimer = Timer(hideDuration, () => _hideControls());
  }

  void _hideControls() {
    setState(() {
      showControls = false;
    });
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
          CupertinoSwitch(
            value: false,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (changeValue) {},
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: ScreenSize.getPercentOfHeight(context, 0.05),
      ),
      child: ProgressBar(
        progress: position,
        total: widget.controller.value.duration,
        barHeight: 3,
        timeLabelLocation: TimeLabelLocation.sides,
        buffered: buffered,
        onSeek: (value) {
          widget.controller.seekTo(value);
        },
        baseBarColor: Colors.white24,
        bufferedBarColor: Colors.grey,
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          widget.baseModel?.title ?? "",
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildControlButton(
                icon: Icons.lock_open_rounded,
                onTap: () {
                  setState(() {
                    locked = !locked;
                  });
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
                icon: Icons.audiotrack_outlined,
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.noHeader,
                    width: ScreenSize.getPercentOfWidth(context, 0.7),
                    title: Strings.settings,
                    body: _buildTracksPopup(),
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
                icon: Icons.restore_rounded,
                onTap: () {
                  widget.controller.seekTo(Duration());
                  widget.controller.play();
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
          _buildMoreDetails()
        ],
      ),
    );
  }

  Widget _buildMoreDetails() {
    if (widget.baseModel != null && widget.baseModel!.backdropPath != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text("More Info", textAlign: TextAlign.center),
              Text(
                "Tap to see",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              )
            ],
          ),
          Style.getVerticalHorizontalSpacing(context: context),
          RoundedImage(
            image: Utils.getBackdropUrl(widget.baseModel!.backdropPath!),
            width: ScreenSize.getPercentOfWidth(context, 0.12),
            ratio: Constants.backdropAspectRatio,
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildTracksPopup() {
    int? selected;
    if (selectedTrack != null) {
      var key = tracks!.keys.where((element) => element == selectedTrack!);
      if (key.isNotEmpty) {
        selected = tracks!.keys.toList().indexOf(key.first);
      }
    }

    return CustomCheckBoxList(
      children: tracks!.values.toList(),
      selectedItems: selected == null ? null : [selected],
      type: CheckBoxListType.grid,
      singleSelect: true,
      delegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 35,
      ),
      onSelectionAdded: (values) {
        widget.controller.setAudioTrack(tracks!.keys
            .where((element) => tracks![element] == values.first)
            .first);
      },
      onSelectionRemoved: (values) {
        int key;
        if (values.isEmpty) {
          key = -1;
        } else {
          key = tracks!.keys
              .where((element) => tracks![element] == values.first)
              .first;
        }
        widget.controller.setAudioTrack(key);
      },
    );
  }

  Widget _buildSubtitlePopup() {
    int? selected;
    if (selectedSubtitle != null) {
      var key =
          subtitles!.keys.where((element) => element == selectedSubtitle!);
      if (key.isNotEmpty) {
        selected = subtitles!.keys.toList().indexOf(key.first);
      }
    }

    return CustomCheckBoxList(
      children: subtitles!.values.toList(),
      selectedItems: selected == null ? null : [selected],
      type: CheckBoxListType.grid,
      singleSelect: true,
      delegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 35,
      ),
      onSelectionAdded: (values) {
        widget.controller.setSpuTrack(subtitles!.keys
            .where((element) => subtitles![element] == values.first)
            .first);
      },
      onSelectionRemoved: (values) {
        int key;
        if (values.isEmpty) {
          key = -1;
        } else {
          key = subtitles!.keys
              .where((element) => subtitles![element] == values.first)
              .first;
        }
        widget.controller.setSpuTrack(key);
      },
    );
  }

  Widget _buildSettingsPopup() {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
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
              selectedItems: [speedIndex],
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
              selectedItems: [fitIndex],
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
      fitIndex = 0;
    } else if (value == Strings.fitTypes[1]) {
      boxFit = BoxFit.fill;
      fitIndex = 1;
    } else if (value == Strings.fitTypes[2]) {
      boxFit = BoxFit.cover;
      fitIndex = 2;
    }
    /*  widget.controller.pause();
    widget.controller.setOverriddenFit(boxFit);
    widget.controller.play(); */
  }

  void _speedChanged(String value) {
    double speed = 1;
    if (value == Strings.playbackSpeeds[1]) {
      speed = 0.25;
      speedIndex = 1;
    } else if (value == Strings.playbackSpeeds[2]) {
      speed = 0.5;
      speedIndex = 2;
    } else if (value == Strings.playbackSpeeds[3]) {
      speed = 0.75;
      speedIndex = 3;
    } else if (value == Strings.playbackSpeeds[4]) {
      speed = 1.25;
      speedIndex = 4;
    } else if (value == Strings.playbackSpeeds[5]) {
      speed = 1.5;
      speedIndex = 5;
    } else if (value == Strings.playbackSpeeds[6]) {
      speed = 2;
      speedIndex = 6;
    } else if (value == Strings.playbackSpeeds[0]) {
      speed = 1;
      speedIndex = 0;
    } else if (value == Strings.playbackSpeeds[7]) {
      speed = 1.75;
      speedIndex = 7;
    }
    widget.controller.setPlaybackSpeed(speed);
  }

  Widget _buildMainControls() {
    return Align(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildControlButton(
            icon: rewindSeek == 30
                ? Icons.replay_30_rounded
                : Icons.replay_10_rounded,
            onTap: () {
              Duration rewind = Duration(
                seconds: position.inSeconds - 10,
              );

              widget.controller.seekTo(rewind);
            },
          ),
          _buildControlButton(
            icon: widget.controller.value.isPlaying
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
            onTap: () {
              setState(() {
                widget.controller.value.isPlaying
                    ? widget.controller.pause()
                    : widget.controller.play();
              });
            },
          ),
          _buildControlButton(
            icon: forwardSeek == 30
                ? Icons.forward_30_rounded
                : Icons.forward_10_rounded,
            onTap: () {
              Duration forward = Duration(
                seconds: position.inSeconds + 10,
              );

              if (forward > widget.controller.value.duration) {
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
