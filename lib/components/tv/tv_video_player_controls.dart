import "dart:async";

import "package:better_player/better_player.dart";
import "package:cinenexa/services/constants.dart";
import "package:cinenexa/services/network/utils.dart";
import "package:cinenexa/utils/keycode.dart";
import "package:cinenexa/utils/screen_size.dart";
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
  static const int PLAY = 0;
  static const int FORWARD = 1;
  static const int BACKWARD = -1;
  static const int SUBTITLE = -2;
  static const int SCALE = -3;
  static const int SPEED = -4;
  static const int NEXT_PLAY = 2;
  static const int EPISODES = 3;

  Timer? hideTimer;
  ScrobbleManager? scrobbleManager;
  late PlayerStore playerStore;

  FocusNode focusNode = FocusNode();

  int xfocus = PLAY;
  bool isSeeking = false;

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
    super.initState();
  }

  @override
  void dispose() {
    hideTimer?.cancel();
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
          ),
          _buildBottomRow(),
        ],
      ),
    );
  }

  Widget _buildBottomRow() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Observer(builder: (_) {
          return Row(
            children: [
              _buildControls(Text(Strings.fitTypes[playerStore.fitIndex])),
              SizedBox(
                width: 5,
              ),
              _buildControls(
                  Text(Strings.playbackSpeeds[playerStore.speedIndex])),
              SizedBox(
                width: 5,
              ),
              _buildProgressButton(Icons.closed_caption_rounded, size: 30),
            ],
          );
        }),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProgressButton(
                playerStore.seekDuration == 30
                    ? Icons.replay_30_rounded
                    : Icons.replay_10_rounded,
              ),
              SizedBox(
                width: 5,
              ),
              _buildProgressButton(Icons.play_arrow_rounded),
              SizedBox(
                width: 5,
              ),
              _buildProgressButton(
                playerStore.seekDuration == 30
                    ? Icons.forward_30_rounded
                    : Icons.forward_10_rounded,
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
                _buildProgressButton(Icons.list, size: 30),
                SizedBox(
                  width: 5,
                ),
                _buildControls(Text("Next Episode")),
              ],
            ),
          ),
      ],
    );
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

  Widget _buildProgressButton(IconData data, {double? size}) {
    return GlassyContainer(
      borderRadius: Style.largeRoundEdgeRadius,
      child: IconButton(
        iconSize: 40,
        onPressed: () {},
        style: ButtonStyle(),
        icon: Icon(data, size: size ?? 40),
      ),
    );
  }

  Widget _buildControls(Widget widget) {
    return GlassyContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: widget,
      ),
    );
  }

  void _cancelAndRestartTimer() {
    hideTimer?.cancel();
    playerStore.setShowControls(true);
    hideTimer = Timer(VideoPlayerPage.hideDuration, () => _hideControls());
  }

  void _hideControls() {
    // playerStore.setShowControls(false); TODO
  }

  void _onKey(RawKeyEvent event) {
    if (!(event is RawKeyDownEvent)) {
      return;
    }
    RawKeyEventDataAndroid rawKeyEventData =
        event.data as RawKeyEventDataAndroid;

    switch (rawKeyEventData.keyCode) {
      case KEY_CENTER:
        _onCentre();
        break;
      default:
    }
  }

  void _onCentre() {
    playerStore.showControls ? _hideControls() : _cancelAndRestartTimer();

    switch (xfocus) {
      case PLAY:
        if (widget.controller.videoPlayerController?.value.isPlaying ?? false) {
          widget.controller.pause();
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
      default:
    }
  }
}
