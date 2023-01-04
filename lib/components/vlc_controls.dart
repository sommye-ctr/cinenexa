import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:provider/provider.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/movie.dart';
import 'package:watrix/models/network/tv.dart';
import 'package:watrix/services/local/scrobble_manager.dart';
import 'package:watrix/store/player/player_store.dart';
import 'package:watrix/store/user/user_store.dart';
import 'package:watrix/widgets/rounded_button.dart';

import '../models/network/extensions/extension_stream.dart';
import '../resources/strings.dart';
import '../resources/style.dart';
import '../utils/screen_size.dart';
import '../widgets/custom_checkbox_list.dart';

class VlcControls extends StatefulWidget {
  final VlcPlayerController controller;
  final int? id;
  final BaseModel? baseModel;
  final Movie? movie;
  final Tv? show;
  final int? season, episode;
  final double? progress;

  final ExtensionStream stream;

  const VlcControls({
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
  }) : super(key: key);

  @override
  State<VlcControls> createState() => _VlcControlsState();
}

class _VlcControlsState extends State<VlcControls> {
  static const double iconSize = 60;
  static const Duration hideDuration = Duration(seconds: 5);
  Timer? hideTimer;

  ScrobbleManager? scrobbleManager;
  late PlayerStore playerStore;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    });

    playerStore = PlayerStore(
      controller: widget.controller,
      extensionStream: widget.stream,
      progress: widget.progress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBack,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              playerStore.showControls
                  ? _hideControls()
                  : _cancelAndRestartTimer();
            },
            child: Observer(
              builder: (_) {
                if (playerStore.buffering) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (playerStore.casting) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Theme.of(context).backgroundColor,
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.cast_connected_rounded,
                            size: ScreenSize.getPercentOfWidth(context, 0.25),
                            color: Colors.blue,
                          ),
                          Style.getVerticalSpacing(context: context),
                          Text("Casting to ${playerStore.castingDevice}"),
                          Style.getVerticalSpacing(context: context),
                          RoundedButton(
                            child: Text(Strings.disconnect),
                            onPressed: () async {
                              await widget.controller.stopRendererScanning();
                              playerStore.setCasting(false);
                            },
                            type: RoundedButtonType.filled,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (playerStore.showControls) {
                  if (playerStore.locked) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildControlButton(
                        icon: Icons.lock_outline_rounded,
                        onTap: () => playerStore.setLocked(false),
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
            )));
  }

  Future<bool> _onBack() async {
    scrobbleManager?.paused();
    await Future.wait([
      widget.controller.stopRendererScanning(),
      widget.controller.stop(),
      widget.controller.dispose()
    ]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: ScreenSize.getPercentOfHeight(context, 0.05),
      ),
      child: Observer(builder: (_) {
        return ProgressBar(
          progress: playerStore.position,
          total: Duration(milliseconds: playerStore.duration),
          barHeight: 3,
          timeLabelLocation: TimeLabelLocation.sides,
          buffered: playerStore.buffered,
          onSeek: (value) {
            widget.controller.seekTo(value);
          },
          baseBarColor: Colors.white24,
          bufferedBarColor: Colors.grey,
        );
      }),
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
        children: [
          _buildControlButton(
            icon: Icons.lock_open_rounded,
            onTap: () => playerStore.setLocked(!playerStore.locked),
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
            icon: Icons.cast_rounded,
            onTap: () {
              _cast();
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
    );
  }

  void _cast() async {
    var castDevices = await widget.controller.getRendererDevices();

    if (castDevices.isEmpty) {
      Style.showToast(text: Strings.noDeviceFound);
      return;
    }

    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      showCloseIcon: true,
      padding: EdgeInsets.all(8),
      animType: AnimType.bottomSlide,
      title: Strings.castDevices,
      body: _buildCastDevices(castDevices),
    ).show();
  }

  Widget _buildCastDevices(Map devices) {
    return Container(
      child: ListView.builder(
        itemCount: devices.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Style.getListTile(
            context: context,
            title: devices.values.elementAt(index).toString(),
            onTap: () async {
              await widget.controller
                  .castToRenderer(devices.values.elementAt(index).toString());
              Navigator.pop(context);
              playerStore.setCasting(true);
              playerStore
                  .setCastingDevice(devices.values.elementAt(index).toString());
            },
          );
        },
      ),
    );
  }

  Widget _buildTracksPopup() {
    int selected = 0;
    if (playerStore.selectedTrack != null) {
      var key = playerStore.tracks!.keys
          .where((element) => element == playerStore.selectedTrack!);
      if (key.isNotEmpty) {
        selected = playerStore.tracks!.keys.toList().indexOf(key.first) + 1;
      }
    }

    List<String> allTracks = [
      Strings.none,
      ...playerStore.tracks!.values.toList()
    ];

    return CustomCheckBoxList(
      children: allTracks,
      selectedItems: [selected],
      type: CheckBoxListType.grid,
      singleSelect: true,
      alwaysEnabled: true,
      delegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 35,
      ),
      onSelectionAdded: (values) {
        if (values.first == Strings.none) {
          playerStore.setSelectedTrack(null);
          widget.controller.setAudioTrack(-1);
          return;
        }
        int selectedT = playerStore.tracks!.keys
            .where((element) => playerStore.tracks![element] == values.first)
            .first;
        playerStore.setSelectedTrack(selectedT);
        widget.controller.setAudioTrack(selectedT);
      },
    );
  }

  Widget _buildSubtitlePopup() {
    int selected = 0;
    if (playerStore.selectedSubtitle != null) {
      int index = playerStore.subs
          .indexWhere((element) => element.id == playerStore.selectedSubtitle);
      if (index >= 0) {
        selected = index + 1;
      }
    }

    List<String> allSubtitles = [
      Strings.none,
      ...playerStore.subs.map((element) => element.name.toString()).toList(),
    ];

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
        int selectedIndex = playerStore.subs
            .indexWhere((element) => element.name == values.first);

        playerStore.changeSubtitle(selectedIndex);

        Navigator.pop(context);
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
        Style.getVerticalSpacing(context: context, percent: 0.1),
        Observer(builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Strings.subtitleDelay),
              Style.getVerticalSpacing(context: context),
              Slider(
                value: playerStore.subtitleDelay.toDouble(),
                divisions: 120,
                max: 60,
                min: -60,
                onChanged: (value) {
                  int seconds = (value).toInt();
                  widget.controller.setSpuDelay(seconds);
                  playerStore.setSubtitleDelay(seconds);
                },
              ),
              Observer(builder: (_) => Text("${playerStore.subtitleDelay}s")),
            ],
          );
        }),
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
    /*  widget.controller.pause();
    widget.controller.setOverriddenFit(boxFit);
    widget.controller.play(); */
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
      playerStore.setSpeedIndex(0);
    } else if (value == Strings.playbackSpeeds[7]) {
      speed = 1.75;
      playerStore.setSpeedIndex(7);
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
            icon: playerStore.seekDuration == 30
                ? Icons.replay_30_rounded
                : Icons.replay_10_rounded,
            onTap: () {
              Duration rewind = Duration(
                seconds:
                    playerStore.position.inSeconds - playerStore.seekDuration,
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
            icon: playerStore.seekDuration == 30
                ? Icons.forward_30_rounded
                : Icons.forward_10_rounded,
            onTap: () {
              Duration forward = Duration(
                seconds:
                    playerStore.position.inSeconds + playerStore.seekDuration,
              );

              if (forward > Duration(milliseconds: playerStore.duration)) {
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
