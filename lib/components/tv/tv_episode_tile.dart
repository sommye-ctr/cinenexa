import 'package:cinenexa/widgets/screen_background_image.dart';
import 'package:flutter/material.dart';

import '../../models/network/tv_episode.dart';
import '../../resources/style.dart';
import '../../services/constants.dart';
import '../../services/network/utils.dart';
import '../../utils/date_time_formatter.dart';
import '../../utils/screen_size.dart';
import '../../widgets/rounded_image.dart';

class TvEpisodeTile extends StatelessWidget {
  final TvEpisode episode;
  final VoidCallback? onTap;
  final bool watched;
  final bool? overlay;
  const TvEpisodeTile({
    Key? key,
    required this.episode,
    this.onTap,
    this.overlay,
    bool? watched,
  })  : this.watched = watched ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        child: ScreenBackgroundImage(
          image: Utils.getStillUrl(episode.stillPath),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(episode.name),
          ),
          stops: [0, 0.3, 0.5, 0.8, 1],
        ),
      ),
    );
  }
}
