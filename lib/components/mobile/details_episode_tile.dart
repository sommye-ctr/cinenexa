import 'package:flutter/material.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/utils/date_time_formatter.dart';

import '../../models/network/tv_episode.dart';
import '../../resources/style.dart';
import '../../services/constants.dart';
import '../../utils/screen_size.dart';
import '../../widgets/rounded_image.dart';

class EpisodeTile extends StatelessWidget {
  final TvEpisode episode;
  final VoidCallback? onTap;
  final bool watched;
  final bool? overlay;

  final double? widthPercent;
  final bool showMoreInfo;
  const EpisodeTile({
    Key? key,
    required this.episode,
    this.onTap,
    this.overlay,
    bool? watched,
    this.widthPercent,
    this.showMoreInfo = true,
  })  : this.watched = watched ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScreenSize.getPercentOfWidth(context, widthPercent ?? 0.99),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  if (showMoreInfo)
                    RoundedImage(
                      image: Utils.getStillUrl(episode.stillPath),
                      width: ScreenSize.getPercentOfWidth(context,
                          widthPercent == null ? 0.3 : widthPercent! / 3),
                      ratio: Constants.stillAspectRatio,
                      radius: Style.smallRoundEdgeRadius,
                    ),
                  if (showMoreInfo)
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
                                  right: 8,
                                ),
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
              if (showMoreInfo)
                Text(
                  episode.overview,
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
