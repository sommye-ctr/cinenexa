import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watrix/components/video_player_controls.dart';

class VideoPlayerPage extends StatefulWidget {
  static const routeName = "/videoPlayer";

  final String url;
  const VideoPlayerPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late BetterPlayerController controller;
  @override
  void initState() {
    super.initState();

    controller = BetterPlayerController(
      BetterPlayerConfiguration(
        allowedScreenSleep: false,
        autoPlay: true,
        autoDispose: true,
        fullScreenByDefault: true,
        expandToFill: true,
        useRootNavigator: true,
        fit: BoxFit.contain,
        looping: true,
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
          ),
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.url,
        cacheConfiguration: BetterPlayerCacheConfiguration(
          useCache: true,
          maxCacheSize: 2147483648,
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
          child: BetterPlayer(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
