import "dart:async";
import "package:better_player/better_player.dart";
import "package:cinenexa/components/tv/tv_details_drawer.dart";
import "package:cinenexa/components/tv/tv_details_episodes.dart";
import "package:cinenexa/services/constants.dart";
import "package:cinenexa/services/network/utils.dart";
import "package:cinenexa/utils/keycode.dart";
import "package:cinenexa/utils/screen_size.dart";
import "package:cinenexa/utils/settings_indexer.dart";
import "package:cinenexa/widgets/glassy_container.dart";
import "package:cinenexa/widgets/rounded_image.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:provider/provider.dart";
import "../../models/local/progress.dart";
import "../../models/local/show_history.dart";
import "../../models/network/base_model.dart";
import "../../models/network/extensions/extension_stream.dart";
import "../../models/network/extensions/subtitle.dart";
import "../../models/network/movie.dart";
import "../../models/network/tv.dart";
import "../../resources/strings.dart";
import "../../resources/style.dart";
import "../../screens/video_player_page.dart";
import "../../services/local/scrobble_manager.dart";
import "../../services/local/torrent_streamer.dart";
import "../../store/details/details_store.dart";
import "../../store/player/player_store.dart";
import "../../store/user/user_store.dart";
import "../../utils/date_time_formatter.dart";
import "../mobile/video_player_progress_bar.dart";

class TvVideoPlayerControls extends StatefulWidget {
  final BetterPlayerController controller;

  final int? id;
  final BaseModel? baseModel;
  final Movie? movie;
  final Tv? show;
  final int? season, episode;
  final Progress? progress;
  final int? fitIndex;
  final bool? autoSubtitle;
  final DetailsStore? detailsStore;
  final bool? initialDark;
  final ShowHistory? showHistory;
  final TorrentStreamer? torrentStreamer;

  final GlobalKey? playerKey;

  final ExtensionStream stream;
  const TvVideoPlayerControls({
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
    this.autoSubtitle,
    this.detailsStore,
    this.initialDark,
    this.showHistory,
    this.torrentStreamer,
  }) : super(key: key);

  @override
  State<TvVideoPlayerControls> createState() => _TvVideoPlayerControlsState();
}

class _TvVideoPlayerControlsState extends State<TvVideoPlayerControls> {
  static const int SCALE = 0;
  static const int SPEED = 1;
  static const int SUBTITLE = 2;
  static const int BACKWARD = 3;
  static const int PLAY = 4;
  static const int FORWARD = 5;
  static const int EPISODES = 6;
  static const int NEXT_PLAY = 7;
  static const int PROGRESS_BAR = 8;

  Timer? hideTimer;
  ScrobbleManager? scrobbleManager;
  late PlayerStore playerStore;
  VideoProgressBarController progressBarController =
      VideoProgressBarController(showThumb: true);

  FocusNode focusNode = FocusNode();

  int xfocus = PROGRESS_BAR;
  bool isSeeking = false;

  late Map<int, GlassyController> controllers = {
    PLAY: GlassyController(),
    FORWARD: GlassyController(),
    BACKWARD: GlassyController(),
    SUBTITLE: GlassyController(),
    SCALE: GlassyController(),
    SPEED: GlassyController(),
    NEXT_PLAY: GlassyController(),
    EPISODES: GlassyController(),
  };

  @override
  void initState() {
    bool traktLogged =
        Provider.of<UserStore>(context, listen: false).isTraktLogged;

    playerStore = PlayerStore(
      controller: widget.controller,
      extensionStream: widget.stream,
      progress: widget.progress?.progress,
      detailsStore: widget.detailsStore!,
      season: widget.season,
    );

    scrobbleManager = ScrobbleManager(
      playerController: widget.controller,
      item: widget.baseModel!,
      isTraktLogged: traktLogged,
      episode: widget.episode,
      movie: widget.movie,
      season: widget.season,
      show: widget.show,
      id: widget.id,
      playerStore: playerStore,
      showHistory: widget.showHistory,
      episodeId: widget.detailsStore!.chosenEpisode != null
          ? widget
              .detailsStore!.episodes[widget.detailsStore!.chosenEpisode!].id
          : null,
    );

    if (widget.fitIndex != null) playerStore.setFitIndex(widget.fitIndex!);
    if (widget.autoSubtitle != null &&
        widget.progress != null &&
        widget.progress?.subtitle != null) {
      playerStore.changeSubtitle(widget.progress!.subtitle!);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(focusNode);
    });

    _cancelAndRestartTimer();
    super.initState();
  }

  @override
  void dispose() {
    hideTimer?.cancel();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RawKeyboardListener(
        focusNode: focusNode,
        onKey: _onKey,
        child: Observer(
          builder: (context) {
            if (playerStore.showControls) {
              return Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black54,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: _buildHeading(),
                        ),
                        _buildProgressControlsRow(),
                        if (playerStore.buffering)
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildProgressControlsRow() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VideoPlayerProgressBar(
            controller: widget.controller,
            playerStore: playerStore,
            progressBarController: progressBarController,
          ),
          _buildBottomRow(),
        ],
      ),
    );
  }

  Widget _buildBottomRow() {
    return Observer(builder: (_) {
      playerStore;
      playerStore.speedIndex;
      return Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              _buildControls(
                Text(Strings.fitTypes[playerStore.fitIndex]),
                controllers[SCALE]!,
              ),
              SizedBox(
                width: 5,
              ),
              _buildControls(
                  Text(Strings.playbackSpeeds[playerStore.speedIndex]),
                  controllers[SPEED]!),
              SizedBox(
                width: 5,
              ),
              _buildProgressButton(
                  Icons.closed_caption_rounded, controllers[SUBTITLE]!,
                  size: 30),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProgressButton(
                    playerStore.seekDuration == 30
                        ? Icons.replay_30_rounded
                        : Icons.replay_10_rounded,
                    controllers[BACKWARD]!),
                SizedBox(
                  width: 5,
                ),
                _buildProgressButton(
                    widget.controller.isPlaying()!
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    controllers[PLAY]!),
                SizedBox(
                  width: 5,
                ),
                _buildProgressButton(
                  playerStore.seekDuration == 30
                      ? Icons.forward_30_rounded
                      : Icons.forward_10_rounded,
                  controllers[FORWARD]!,
                ),
              ],
            ),
          ),
          if (widget.baseModel?.type == BaseModelType.tv)
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProgressButton(Icons.list, controllers[EPISODES]!,
                      size: 30),
                  SizedBox(
                    width: 5,
                  ),
                  _buildControls(Text("Next Episode"), controllers[NEXT_PLAY]!),
                ],
              ),
            ),
        ],
      );
    });
  }

  Widget _buildHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RoundedImage(
              image: Utils.getBackdropUrl(widget.baseModel?.backdropPath ?? ""),
              width: ScreenSize.getPercentOfWidth(context, 0.1),
              ratio: Constants.backdropAspectRatio,
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.baseModel?.title ?? ""),
                Text(
                    "${DateTimeFormatter.getYearFromString(widget.baseModel?.releaseDate ?? "")}")
              ],
            )
          ],
        ),
        if (widget.baseModel?.type == BaseModelType.tv)
          Text("Season ${widget.season} Episode ${widget.episode}"),
      ],
    );
  }

  Widget _buildProgressButton(IconData data, GlassyController controller,
      {double? size}) {
    return GlassyContainer(
      borderRadius: Style.largeRoundEdgeRadius,
      controller: controller,
      child: IconButton(
        iconSize: 40,
        onPressed: () {},
        style: ButtonStyle(),
        icon: Icon(data, size: size ?? 40),
      ),
    );
  }

  Widget _buildControls(Widget widget, GlassyController controller) {
    return GlassyContainer(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: widget,
      ),
    );
  }

  void _buildSubtitlePopup() {
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

    showDialog(
      context: context,
      builder: (context) {
        return TvDetailsDrawer<Subtitle>(
          leftChildren: allSubtitles,
          rightChildren: [],
          initialyFocusLeft: selected,
          onLeftChildClicked: (index) {
            if (index == 0) {
              playerStore.changeSubtitle(-1);
              return;
            }
            playerStore.changeSubtitle(index + 1);
            Navigator.pop(context);
          },
          onRightWidgetBuild: (item) => Container(),
        );
      },
    );
  }

  void _buildEpisodesPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return TvDetailsEpisodes(
          detailsStore: widget.detailsStore!,
        );
      },
    );
  }

  void _cancelAndRestartTimer({bool restart = true}) {
    hideTimer?.cancel();
    playerStore.setShowControls(true);
    if (restart)
      hideTimer = Timer(VideoPlayerPage.hideDuration, () => _hideControls());
  }

  void _hideControls() {
    if (widget.controller.isPlaying() ?? false) {
      playerStore.setShowControls(false);
      _changeFocus(PROGRESS_BAR);
    }
  }

  Future<bool> _onBack() async {
    scrobbleManager?.exit();

    try {
      widget.controller.exitFullScreen();
    } catch (e) {}

    widget.torrentStreamer?.stopStream();
    Navigator.pop(context);
    return true;
  }

  void _onKey(RawKeyEvent event) {
    if (!(event is RawKeyDownEvent)) {
      return;
    }
    RawKeyEventDataAndroid rawKeyEventData =
        event.data as RawKeyEventDataAndroid;

    _cancelAndRestartTimer();
    switch (rawKeyEventData.keyCode) {
      case KEY_CENTER:
        _onCentre();
        break;
      case KEY_LEFT:
        _onLeft();
        break;
      case KEY_RIGHT:
        _onRight();
        break;
      case KEY_BACKSPACE:
        if (playerStore.showControls) {
          _hideControls();
        } else {
          _onBack();
        }
        break;
      case KEY_UP:
        _onUp();
        break;
      case KEY_DOWN:
        _onDown();
        break;

      default:
    }
  }

  void _onDown() {
    if (!playerStore.showControls) {
      _changeFocus(PROGRESS_BAR);
      return;
    }

    if (xfocus == PROGRESS_BAR) {
      _changeFocus(PLAY);
    }
  }

  void _onUp() {
    if (!playerStore.showControls) {
      _changeFocus(PROGRESS_BAR);
      return;
    }

    _changeFocus(PROGRESS_BAR);
  }

  void _onCentre() async {
    if (!playerStore.showControls) {
      _changeFocus(PROGRESS_BAR);
      return;
    }
    switch (xfocus) {
      case PLAY:
        if (widget.controller.videoPlayerController?.value.isPlaying ?? false) {
          widget.controller.pause();
        } else {
          widget.controller.play();
        }
        break;
      case PROGRESS_BAR:
        if (widget.controller.videoPlayerController?.value.isPlaying ?? false) {
          widget.controller.pause();
          _cancelAndRestartTimer(restart: false);
        } else {
          widget.controller.play();
        }
        break;
      case FORWARD:
        playerStore.seekFoward();
        break;
      case BACKWARD:
        playerStore.seekBackward();
        break;
      case SPEED:
        if (playerStore.speedIndex == Strings.playbackSpeeds.length - 1) {
          playerStore.setSpeedIndex(0);
          widget.controller.setSpeed(1);
          return;
        }
        playerStore.setSpeedIndex(playerStore.speedIndex + 1);
        widget.controller
            .setSpeed(SettingsIndexer.getSpeed(playerStore.speedIndex));
        break;
      case SCALE:
        if (playerStore.fitIndex == Strings.fitTypes.length - 1) {
          playerStore.setFitIndex(0);
          widget.controller.pause();
          widget.controller.setOverriddenFit(BoxFit.contain);
          widget.controller.play();
          return;
        }
        playerStore.setFitIndex(playerStore.fitIndex + 1);
        widget.controller.pause();
        widget.controller
            .setOverriddenFit(SettingsIndexer.getFit(playerStore.fitIndex));
        widget.controller.play();
        break;
      case NEXT_PLAY:
        if (widget.detailsStore!.chosenEpisode ==
            widget.detailsStore!.episodes.length - 1) {
          Style.showLoadingDialog(context: context);
          await playerStore.fetchNewEps();
          Navigator.pop(context);
          Navigator.maybePop(context);
          return;
        }
        playerStore.setEpisode();
        Navigator.maybePop(context);
        break;
      case SUBTITLE:
        _buildSubtitlePopup();
        break;
      case EPISODES:
        _buildEpisodesPopup();
        break;
      default:
    }
  }

  void _onLeft() {
    if (!playerStore.showControls) {
      _changeFocus(PROGRESS_BAR);
      return;
    }
    if (xfocus == PROGRESS_BAR) {
      playerStore.seekBackward();
      return;
    }
    if (xfocus != SCALE) {
      _changeFocus(xfocus - 1);
    }
  }

  void _onRight() {
    if (!playerStore.showControls) {
      _changeFocus(PROGRESS_BAR);
      return;
    }
    if (xfocus == PROGRESS_BAR) {
      playerStore.seekFoward();
      return;
    }

    if (xfocus != NEXT_PLAY) {
      _changeFocus(xfocus + 1);
    }
  }

  void _changeFocus(int index) {
    _changeFocusUi(isNull: true);
    xfocus = index;
    _changeFocusUi();
  }

  void _changeFocusUi({bool isNull = false}) {
    if (xfocus != PROGRESS_BAR) {
      controllers[xfocus]
          ?.changeColor(isNull ? null : Theme.of(context).colorScheme.primary);
    } else {
      progressBarController.changeThumbVisibility(isNull ? false : true);
    }
  }
}
