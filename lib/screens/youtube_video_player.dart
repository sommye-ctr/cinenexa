import 'package:flutter/material.dart';
import 'package:watrix/widgets/custom_back_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  static const String routeName = "/youtube-player";
  final String ytId;
  const YoutubeVideoPlayer({
    Key? key,
    required this.ytId,
  }) : super(key: key);

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.ytId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.toggleFullScreenMode();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        topActions: [
          CustomBackButton(),
        ],
        bottomActions: [
          const SizedBox(width: 14.0),
          CurrentPosition(
            controller: controller,
          ),
          const SizedBox(width: 8.0),
          ProgressBar(
            controller: controller,
            isExpanded: true,
            colors: ProgressBarColors(
              bufferedColor: Colors.grey,
              backgroundColor: Colors.white24,
              playedColor: Theme.of(context).colorScheme.primary,
              handleColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          RemainingDuration(
            controller: controller,
          ),
          PlaybackSpeedButton(
            controller: controller,
          ),
        ],
      ),
      builder: (context, player) {
        return Container(
          child: player,
        );
      },
    );
  }
}
