import 'package:flutter/material.dart';
import 'package:watrix/models/tv_episode.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/date_time_formatter.dart';

import '../resources/style.dart';
import '../services/constants.dart';
import '../utils/screen_size.dart';
import '../widgets/rounded_image.dart';

class EpisodeTile extends StatelessWidget {
  final TvEpisode episode;
  const EpisodeTile({
    Key? key,
    required this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 0.8),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).highlightColor,
          ),
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        color: Colors.black,
        child: Column(
          children: [
            Row(
              children: [
                RoundedImage(
                  image: Utils.getStillUrl(episode.stillPath),
                  width: ScreenSize.getPercentOfWidth(context, 0.3),
                  ratio: Constants.stillAspectRatio,
                  radius: Style.smallRoundEdgeRadius,
                ),
                SizedBox(
                  width: ScreenSize.getPercentOfWidth(context, 0.01),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${episode.episodeNumber}. ${episode.name}",
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${DateTimeFormatter.getDateMonthYearFromString(
                          episode.airDate,
                        )}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "${episode.runtime} minutes",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenSize.getPercentOfHeight(context, 0.01),
            ),
            Text(
              episode.overview,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
