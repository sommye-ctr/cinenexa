import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:glass/glass.dart';
import 'package:provider/provider.dart';
import 'package:video_cast/chrome_cast_media_type.dart';
import 'package:video_cast/chrome_cast_subtitle.dart';
import 'package:video_cast/video_cast.dart';

import 'package:cinenexa/components/mobile/video_player_progress_bar.dart';
import 'package:cinenexa/models/local/show_history.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/local/torrent_streamer.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/store/details/details_store.dart';
import 'package:cinenexa/utils/settings_indexer.dart';
import 'package:cinenexa/widgets/custom_checkbox_list.dart';

import '../../models/local/progress.dart';
import '../../models/network/base_model.dart';
import '../../models/network/extensions/extension_stream.dart';
import '../../models/network/extensions/subtitle.dart';
import '../../models/network/movie.dart';
import '../../models/network/trakt/trakt_show_history_season.dart';
import '../../models/network/trakt/trakt_show_history_season_ep.dart';
import '../../models/network/tv.dart';
import '../../screens/video_player_page.dart';
import '../../services/local/scrobble_manager.dart';
import '../../store/player/player_store.dart';
import '../../store/user/user_store.dart';
import '../../utils/file_opener.dart';
import '../../widgets/rounded_button.dart';
import 'details_episode_tile.dart';

class VideoPlayerControls extends StatefulWidget {
  final MeeduPlayerController controller;

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
  final String streamUrl;

  final ExtensionStream stream;
  const VideoPlayerControls({
    Key? key,
    required this.controller,
    required this.stream,
    required this.streamUrl,
    this.baseModel,
    this.id,
    this.movie,
    this.show,
    this.episode,
    this.season,
    this.progress,
    this.fitIndex,
    this.autoSubtitle,
    this.detailsStore,
    this.initialDark,
    this.showHistory,
    this.torrentStreamer,
  }) : super(key: key);

  @override
  State<VideoPlayerControls> createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Timer? hideTimer;
  ScrobbleManager? scrobbleManager;
  late PlayerStore playerStore;
  ChromeCastController? chromeCastController;
  Widget drawerWidget = Container();
  FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
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
      _cancelAndRestartTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: Drawer(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: drawerWidget,
          ),
        ).asGlass(
          blurX: 20,
          blurY: 20,
          clipBorderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        backgroundColor: Colors.transparent,
        body: Observer(
          builder: (_) {
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
                            text: Strings.locked,
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
                        LayoutBuilder(
                          builder: (p0, p1) {
                            if (playerStore.casting) {
                              return Stack(
                                children: [
                                  Center(
                                    child: Text("Casting on another device..."),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildTopPanel(),
                                      _castingControls(),
                                    ],
                                  ),
                                ],
                              );
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildTopPanel(),
                                _buildMainControls(),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    VideoPlayerProgressBar(
                                      controller: widget.controller,
                                      playerStore: playerStore,
                                    ),
                                    _buildBottomControls(),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onBack() async {
    scrobbleManager?.exit();
    if (widget.initialDark != null && !widget.initialDark!)
      AdaptiveTheme.of(context).setLight();
    if (playerStore.casting) chromeCastController?.endSession();

    widget.torrentStreamer?.stopStream();
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
    hideTimer = Timer(VideoPlayerPage.hideDuration, () => _hideControls());
  }

  void _hideControls() {
    playerStore.setShowControls(false);
  }

  Widget _castingControls() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildControlButton(
        icon: Icons.closed_caption_off,
        onTap: () {
          drawerWidget = _buildSubtitlePopup();
          openDrawer();
        },
        size: 25,
        overlay: true,
      ),
    );
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.baseModel?.type == BaseModelType.tv)
                IconButton(
                  onPressed: () => _showEpisodes(),
                  iconSize: 30,
                  icon: Icon(Icons.list_rounded),
                ),
              SizedBox(
                width: 8,
              ),
              ChromeCastButton(
                onButtonCreated: (controller) {
                  chromeCastController = controller;
                  chromeCastController?.addSessionListener();
                },
                onSessionStarted: () {
                  playerStore.setCasting(true);
                  widget.controller.pause();
                  chromeCastController?.loadMedia(
                    type: widget.baseModel!.type == BaseModelType.movie
                        ? ChromeCastMediaType.movie
                        : ChromeCastMediaType.show,
                    url: widget.streamUrl,
                    title: widget.baseModel!.title!,
                    autoplay: true,
                    image: Utils.getPosterUrl(widget.baseModel!.posterPath!),
                    position: playerStore.position.inMilliseconds.toDouble(),
                    showEpisode: widget.episode,
                    showSeason: widget.season,
                    subtitles: _getCastSubtitles(),
                  );
                  playerStore.setShowControls(false);

                  if (playerStore.selectedSubtitle != null) {
                    chromeCastController?.setTrack(
                        subId: playerStore.selectedSubtitle!.toDouble());
                  }
                },
                onSessionEnding: (position) {
                  playerStore.setCasting(false);
                  scrobbleManager?.paused();
                  if (position != null)
                    widget.controller.seekTo(Duration(milliseconds: position));

                  widget.controller.play();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEpisodes() {
    drawerWidget = ListView.builder(
      shrinkWrap: true,
      itemCount: widget.detailsStore?.episodes.length,
      itemBuilder: (context, index) {
        bool? watched = false;

        Iterable<TraktShowHistorySeason>? iterable =
            widget.detailsStore!.showHistory?.seasons?.where(
          (element) =>
              element.number ==
              widget.detailsStore!.tv!
                  .seasons![widget.detailsStore!.chosenSeason!].seasonNumber,
        );
        if (iterable != null && iterable.isNotEmpty) {
          TraktShowHistorySeason? historySeason = iterable.elementAt(0);
          Iterable<TraktShowHistorySeasonEp>? list = historySeason.episodes
              ?.where((element) =>
                  element.number ==
                  widget.detailsStore!.episodes[index].episodeNumber);
          watched = list != null && list.isNotEmpty;
        }

        return EpisodeTile(
          episode: widget.detailsStore!.episodes[index],
          watched: watched,
          widthPercent: 0.1,
          showMoreInfo: false,
          onTap: () async {
            widget.detailsStore!.onEpBackClicked();
            widget.detailsStore!.onEpiodeClicked(index);
            widget.detailsStore!.fetchStreams();

            Navigator.pop(context);
            Navigator.maybePop(context);
          },
        );
      },
    );
    openDrawer();
  }

  List<ChromeCastSubtitle> _getCastSubtitles() {
    List<ChromeCastSubtitle> subs = [];
    if (widget.stream.subtitles != null) {
      for (int i = 0; i < widget.stream.subtitles!.length; i++) {
        var element = widget.stream.subtitles![i];
        subs.add(
          ChromeCastSubtitle(
            id: i.toDouble(),
            name: element.title ?? "",
            source: element.url ?? "",
            language: "en-US",
          ),
        );
      }
    }
    return subs;
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
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(
            icon: Icons.restore_rounded,
            onTap: () {
              widget.controller.seekTo(Duration());
            },
            size: 25,
            text: Strings.restart,
          ),
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
          _buildControlButton(
            icon: Icons.lock_open_rounded,
            onTap: () {
              playerStore.setLocked(!playerStore.locked);
            },
            size: 25,
            text: Strings.lock,
          ),
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
          _buildControlButton(
            icon: Icons.closed_caption_off,
            onTap: () {
              drawerWidget = _buildSubtitlePopup();
              openDrawer();
            },
            size: 25,
            text: Strings.subtitle,
          ),
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
          _buildControlButton(
            icon: Icons.settings,
            onTap: () {
              drawerWidget = _buildSettingsPopup();
              openDrawer();
            },
            size: 25,
            text: Strings.settings,
          ),
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    if (widget.baseModel?.type == BaseModelType.tv &&
        !(widget.detailsStore!.chosenSeason ==
                widget.detailsStore!.tv!.seasons!.length - 1 &&
            widget.detailsStore!.chosenEpisode ==
                widget.detailsStore!.episodes.length - 1)) {
      return _buildControlButton(
        icon: Icons.skip_next_rounded,
        onTap: () async {
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
        },
        size: 25,
        text: Strings.next,
      );
    }
    return Container();
  }

  void openDrawer() {
    setState(() {});
    scaffoldKey.currentState?.openEndDrawer();
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

    return ListView(
      children: [
        RoundedButton(
          child: Text(Strings.addSubtitle),
          onPressed: () async {
            Map? data = await FileOpener.openSrtFile();

            if (data != null) {
              playerStore.addSubtitle(Subtitle.def(
                title: data['name'],
                path: data['path'],
              ));
              Navigator.pop(context);
            }
          },
          type: RoundedButtonType.outlined,
        ),
        Style.getVerticalSpacing(context: context),
        CustomCheckBoxList(
          children: allSubtitles,
          selectedItems: [selected],
          type: CheckBoxListType.grid,
          alwaysEnabled: true,
          singleSelect: true,
          delegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisExtent: 35,
            mainAxisSpacing: 8,
          ),
          onSelectionAdded: (values) {
            if (values.first == Strings.none) {
              if (playerStore.casting) {
                chromeCastController?.disableTrack();
                playerStore.setSelectedSubtitle(null);
                Navigator.pop(context);
                return;
              }
              playerStore.changeSubtitle(-1);
              return;
            }
            int selectedIndex = widget.stream.subtitles!
                .indexWhere((element) => element.title == values.first);

            if (playerStore.casting) {
              if (selectedIndex < 0) {
                chromeCastController?.disableTrack();
                playerStore.setSelectedSubtitle(null);
              } else {
                chromeCastController?.setTrack(subId: selectedIndex.toDouble());
                playerStore.setSelectedSubtitle(selectedIndex);
              }
            } else {
              playerStore.changeSubtitle(selectedIndex);
            }
            Navigator.pop(context);
          },
        ),
      ],
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
                crossAxisCount: 3,
                mainAxisExtent: 35,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
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
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
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
    Map<int, BoxFit> res = SettingsIndexer.getFitFromValue(value);

    playerStore.setFitIndex(res.keys.first);
    widget.controller.pause();
    widget.controller.onVideoFitChange(res.values.first);
    widget.controller.play();
  }

  void _speedChanged(String value) {
    Map<int, double> result = SettingsIndexer.getSpeedFromValue(value);
    playerStore.setSpeedIndex(result.keys.first);
    widget.controller.setPlaybackSpeed(result.values.first);
  }

  Widget _buildMainControls() {
    return Observer(builder: (_) {
      if (playerStore.buffering) {
        hideTimer?.cancel();
      }

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
                playerStore.seekBackward();
              },
            ),
            if (playerStore.buffering) CircularProgressIndicator(),
            if (!playerStore.buffering)
              _buildControlButton(
                icon: widget.controller.playerStatus.playing
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                onTap: () {
                  setState(() {
                    widget.controller.playerStatus.playing
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
                playerStore.seekFoward();
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildControlButton(
      {required IconData icon,
      required Function() onTap,
      double? size,
      String? text,
      bool overlay = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
      child: Material(
        color: overlay ? Colors.white.withOpacity(0.1) : Colors.transparent,
        child: InkWell(
          splashColor: Colors.white30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: size ?? Style.iconSize,
                ),
                if (text != null)
                  SizedBox(
                    width: 4,
                  ),
                if (text != null) Text(text),
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}