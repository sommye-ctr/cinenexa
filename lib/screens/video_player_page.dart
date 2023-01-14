import 'package:better_player/better_player.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/utils/settings_indexer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cinenexa/components/video_player_controls.dart';

import '../models/network/base_model.dart';
import '../models/network/extensions/extension_stream.dart';
import '../models/network/movie.dart';
import '../models/network/tv.dart';
import '../resources/style.dart';

class VideoPlayerPage extends StatefulWidget {
  static const routeName = "/videoPlayer";

  final int? id;
  final BaseModel? baseModel;
  final Movie? movie;
  final Tv? show;
  final int? season, episode;
  final double? progress;
  final ExtensionStream extensionStream;

  const VideoPlayerPage({
    Key? key,
    required this.extensionStream,
    this.baseModel,
    this.id,
    this.movie,
    this.show,
    this.episode,
    this.season,
    this.progress,
  }) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  static const String TORRENT_STREAM_EVENT_NAME = "cinenexa/torrentStream";
  static const EventChannel channel = EventChannel(TORRENT_STREAM_EVENT_NAME);

  bool loading = true;

  late BetterPlayerConfiguration configuration;
  late BetterPlayerController controller;

  int? fitIndex, maxCacheIndex;

  final GlobalKey betterPlayerKey = GlobalKey();

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

    configuration = BetterPlayerConfiguration(
        allowedScreenSleep: false,
        autoPlay: true,
        autoDispose: true,
        fullScreenByDefault: true,
        expandToFill: true,
        useRootNavigator: true,
        handleLifecycle: false,
        fit: SettingsIndexer.getFit(fitIndex!),
        looping: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(errorMessage ?? "The player encountered an error"),
          );
        },
        placeholder: Center(
          child: CircularProgressIndicator(),
        ),
        deviceOrientationsOnFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ],
        eventListener: (p0) {
          if (p0.betterPlayerEventType ==
              BetterPlayerEventType.hideFullscreen) {
            Navigator.pop(context);
          }
        },
        controlsConfiguration: BetterPlayerControlsConfiguration(
          playerTheme: BetterPlayerTheme.custom,
          customControlsBuilder: (controller, onPlayerVisibilityChanged) =>
              VideoPlayerControls(
            controller: controller,
            stream: widget.extensionStream,
            baseModel: widget.baseModel,
            episode: widget.episode,
            season: widget.season,
            movie: widget.movie,
            show: widget.show,
            progress: widget.progress,
            id: widget.id,
            fitIndex: fitIndex,
          ),
        ));

    _getUrl();
  }

  void _getUrl() {
    if (widget.extensionStream.magnet != null) {
      channel.receiveBroadcastStream({
        "url": widget.extensionStream.magnet,
        "index": widget.extensionStream.fileIndex,
      }).handleError((error) {
        Style.showToast(context: context, text: "Error: ${error}");
      }).listen((event) {
        if (event is String) {
          _setController(event);
          setState(() {
            loading = false;
          });
        }
      });
      return;
    }
    _setController(widget.extensionStream.url!);
    setState(() {
      loading = false;
    });
  }

  void _setController(String url) {
    controller = BetterPlayerController(
      configuration,
      betterPlayerDataSource: BetterPlayerDataSource.network(
        url,
        cacheConfiguration: BetterPlayerCacheConfiguration(
          useCache: true,
          maxCacheSize:
              SettingsIndexer.getMaxCache(maxCacheIndex!) * 1024 * 1024,
        ),
        notificationConfiguration: BetterPlayerNotificationConfiguration(
          showNotification: true,
          title: widget.baseModel!.title!,
          author: Strings.appName,
          imageUrl: Utils.getPosterUrl(widget.baseModel!.posterPath!),
          activityName: "MainActivity",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
      return Center(child: CircularProgressIndicator());
    }
    return BetterPlayer(
      key: betterPlayerKey,
      controller: controller,
    );
  }
}
