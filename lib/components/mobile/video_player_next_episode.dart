import 'package:cinenexa/models/network/tv_episode.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class VideoPlayerNextEpisode extends StatelessWidget {
  final TvEpisode episode;
  final int season;
  final VoidCallback onCancel;
  final Function(TvEpisode episode, int season) onNext;
  const VideoPlayerNextEpisode({
    Key? key,
    required this.season,
    required this.episode,
    required this.onCancel,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "S${season} EP ${episode.episodeNumber}",
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundedButton(
              child: Text("Cancel"),
              onPressed: () => onCancel(),
              type: RoundedButtonType.outlined,
            ),
            Style.getVerticalHorizontalSpacing(context: context),
            RoundedButton(
              child: Text("Next"),
              onPressed: () => onNext(episode, season),
              type: RoundedButtonType.outlined,
            )
          ],
        ),
      ],
    );
  }
}
