import 'package:cinenexa/utils/keycode.dart';
import 'package:flutter/material.dart';
import 'package:cinenexa/widgets/custom_back_button.dart';
import 'package:flutter/services.dart';
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
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.ytId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.toggleFullScreenMode();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (event) {
        if (!(event is RawKeyDownEvent)) {
          return;
        }
        RawKeyEventDataAndroid rawKeyEventData =
            event.data as RawKeyEventDataAndroid;

        if (rawKeyEventData.keyCode == KEY_CENTER) {
          if (controller.value.isPlaying) {
            controller.pause();
          } else {
            controller.play();
          }
        } else if (rawKeyEventData.keyCode == KEY_BACKSPACE) {
          Navigator.pop(context);
        }
      },
      child: YoutubePlayerBuilder(
        onExitFullScreen: () => Navigator.pop(context),
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
      ),
    );
  }
}
