import 'package:cinenexa/models/network/tv_episode.dart';
import 'package:cinenexa/services/constants.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class VideoPlayerNextEpisode extends StatelessWidget {
  final TvEpisode episode;
  const VideoPlayerNextEpisode({
    Key? key,
    required this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          RoundedImage(
            image: Utils.getStillUrl(episode.stillPath),
            width: ScreenSize.getPercentOfWidth(context, 0.1),
            ratio: Constants.stillAspectRatio,
          ),
        ],
      ),
    );
  }
}
