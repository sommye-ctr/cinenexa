import 'package:flutter/material.dart';
import 'package:watrix/services/network/utils.dart';
import 'package:watrix/utils/date_time_formatter.dart';

import '../models/network/tv_episode.dart';
import '../resources/style.dart';
import '../services/constants.dart';
import '../utils/screen_size.dart';
import '../widgets/rounded_image.dart';

class EpisodeTile extends StatelessWidget {
  final TvEpisode episode;
  final VoidCallback? onTap;
  final bool watched;
  const EpisodeTile({
    Key? key,
    required this.episode,
    this.onTap,
    bool? watched,
  })  : this.watched = watched ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScreenSize.getPercentOfWidth(context, 0.99),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
          ),
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateTimeFormatter.getDateMonthYearFromString(
                                    episode.airDate,
                                  )}",
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor),
                                ),
                                Text(
                                  "${episode.runtime} minutes",
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor),
                                ),
                              ],
                            ),
                            if (watched)
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScreenSize.getPercentOfWidth(
                                        context, 0.01)),
                                child: Icon(
                                  Icons.check_box_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                          ],
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
                style: TextStyle(color: Theme.of(context).hintColor),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
