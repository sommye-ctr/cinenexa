import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cinenexa/models/local/progress.dart';
import 'package:cinenexa/models/local/show_history.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/store/details/details_store.dart';
import 'package:cinenexa/utils/settings_indexer.dart';
import 'package:cinenexa/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import '../components/video_player_controls.dart';
import '../models/network/base_model.dart';
import '../models/network/extensions/extension_stream.dart';
import '../models/network/movie.dart';
import '../models/network/tv.dart';
import '../resources/style.dart';
import '../services/local/torrent_streamer.dart';

class VideoPlayerPage extends StatefulWidget {
  static const Duration hideDuration = Duration(seconds: 4);
  static const routeName = "/videoPlayer";

  final int? id;
  final BaseModel? baseModel;
  final Movie? movie;
  final Tv? show;
  final int? season, episode;
  final Progress? progress;
  final ExtensionStream extensionStream;
  final DetailsStore? detailsStore;
  final ShowHistory? showHistory;

  const VideoPlayerPage({
    Key? key,
    required this.extensionStream,
    this.baseModel,
    this.showHistory,
    this.id,
    this.movie,
    this.show,
    this.episode,
    this.season,
    this.progress,
    this.detailsStore,
  }) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool loading = true;

  late MeeduPlayerController controller;

  int? fitIndex, maxCacheIndex;
  bool? autoSubtitle;
  bool? initalDark;
  bool? subBackground;
  int? subFontSize;
  int? subPosition;

  TorrentStreamer? torrentStreamer;
  int? progress;
  late String streamUrl;

  StreamController<int> keyController = StreamController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _getDefaultValues();
  }

  Future _getDefaultValues() async {
    Database database = Database();
    fitIndex = await database.getDefaultFit();
    maxCacheIndex = await database.getMaxCache();
    autoSubtitle = await database.getAutoSelectSubtitle();
    subBackground = await database.getSubBg();
    subFontSize = await database.getSubFontSize();
    subPosition = await database.getSubPosition();

    initalDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    AdaptiveTheme.of(context).setDark();

    _getUrl();
  }

  void _getUrl() {
    if (widget.extensionStream.magnet != null) {
      torrentStreamer = TorrentStreamer(
        magnetLink: widget.extensionStream.magnet!,
        fileIndex: widget.extensionStream.fileIndex,
        onError: (error) {
          Style.showToast(context: context, text: "Error: ${error.toString()}");
        },
        onProgress: (progress) {
          setState(() {
            this.progress = progress;
          });
        },
        onServerReady: (url) {
          streamUrl = url;
          _setController(url);
          setState(() {
            loading = false;
          });
        },
      );
      torrentStreamer?.startStream();
      return;
    }
    streamUrl = widget.extensionStream.url!;
    _setController(widget.extensionStream.url!);
    setState(() {
      loading = false;
    });
  }

  void _setController(String url) {
    controller = MeeduPlayerController(
      controlsStyle: ControlsStyle.custom,
      loadingWidget: Container(),
      autoHideControls: false,
      errorText: "The player encountered an error",
      initialFit: SettingsIndexer.getFit(fitIndex!),
      excludeFocus: false,
      screenManager: ScreenManager(
        forceLandScapeInFullscreen: true,
      ),
      responsive: Responsive(
        subtitleBg: subBackground ?? false,
        subtitleSize: subFontSize?.toDouble() ?? 14,
        subtitlePadding: subPosition?.toDouble() ?? 40,
      ),
    );
    controller.onFullscreenChanged.listen((event) {
      if (!event) Navigator.pop(context);
    });
    controller.launchAsFullscreen(
      context,
      dataSource: DataSource(
        type: DataSourceType.network,
        source: url,
      ),
      autoplay: true,
      looping: false,
    );
    controller.onClosedCaptionEnabled(true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (loading) {
      return Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text("Progress ${progress != null ? progress : ""}"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: CustomBackButton(
              onClick: () {
                torrentStreamer?.stopStream();
              },
            ),
          ),
        ],
      );
    }

    return MeeduVideoPlayer(
      controller: controller,
      customControls: (context, controller, responsive) {
        return VideoPlayerControls(
          controller: controller,
          streamUrl: streamUrl,
          stream: widget.extensionStream,
          baseModel: widget.baseModel,
          episode: widget.episode,
          season: widget.season,
          movie: widget.movie,
          show: widget.show,
          progress: widget.progress,
          id: widget.id,
          fitIndex: fitIndex,
          autoSubtitle: autoSubtitle,
          detailsStore: widget.detailsStore,
          initialDark: initalDark,
          showHistory: widget.showHistory,
          torrentStreamer: torrentStreamer,
        );
      },
    );
  }
}
