import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../store/player/player_store.dart';
import '../../utils/screen_size.dart';

class VideoPlayerProgressBar extends StatefulWidget {
  final PlayerStore playerStore;
  final BetterPlayerController controller;
  final VideoProgressBarController? progressBarController;

  const VideoPlayerProgressBar({
    Key? key,
    required this.playerStore,
    required this.controller,
    this.progressBarController,
  }) : super(key: key);

  @override
  State<VideoPlayerProgressBar> createState() => _VideoPlayerProgressBarState();
}

class _VideoPlayerProgressBarState extends State<VideoPlayerProgressBar> {
  @override
  void initState() {
    widget.progressBarController?.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      Duration? duration =
          widget.playerStore.controller.videoPlayerController?.value.duration;

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: ScreenSize.getPercentOfHeight(context, 0.05),
        ),
        child: ProgressBar(
          progress: widget.playerStore.position,
          total: duration ?? Duration(),
          barHeight: 3,
          timeLabelLocation: TimeLabelLocation.sides,
          buffered: widget.playerStore.buffered,
          onSeek: (value) {
            widget.controller.seekTo(value);
          },
          thumbColor: widget.progressBarController?.showThumb ?? true
              ? null
              : Colors.transparent,
          baseBarColor: Colors.white24,
          bufferedBarColor: Colors.grey,
        ),
      );
    });
  }
}

class VideoProgressBarController extends ChangeNotifier {
  bool showThumb;
  VideoProgressBarController({
    required this.showThumb,
  });

  void changeThumbVisibility(bool value) {
    showThumb = value;
  }
}
