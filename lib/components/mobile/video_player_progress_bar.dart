import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../store/player/player_store.dart';
import '../../utils/screen_size.dart';

class VideoPlayerProgressBar extends StatelessWidget {
  final PlayerStore playerStore;
  final BetterPlayerController controller;
  const VideoPlayerProgressBar({
    Key? key,
    required this.playerStore,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      Duration? duration =
          playerStore.controller.videoPlayerController!.value.duration;

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: ScreenSize.getPercentOfHeight(context, 0.05),
        ),
        child: ProgressBar(
          progress: playerStore.position,
          total: duration ?? Duration(),
          barHeight: 3,
          timeLabelLocation: TimeLabelLocation.sides,
          buffered: playerStore.buffered,
          onSeek: (value) {
            controller.seekTo(value);
          },
          baseBarColor: Colors.white24,
          bufferedBarColor: Colors.grey,
        ),
      );
    });
  }
}
