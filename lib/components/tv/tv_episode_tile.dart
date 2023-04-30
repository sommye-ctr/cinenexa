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
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        child: Row(
          children: [
            RoundedImage(
              image: Utils.getStillUrl(episode.stillPath),
              width: ScreenSize.getPercentOfWidth(context, 0.15),
              ratio: Constants.stillAspectRatio,
              radius: Style.smallRoundEdgeRadius,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${episode.episodeNumber}. ${episode.name}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${episode.runtime} minutes",
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    episode.overview,
                    style: TextStyle(color: Theme.of(context).hintColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (watched)
                    Padding(
                      padding: EdgeInsets.only(
                        right: ScreenSize.getPercentOfWidth(context, 0.01),
                      ),
                      child: Icon(
                        Icons.check_box_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
