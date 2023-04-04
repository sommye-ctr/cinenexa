import 'package:flutter/material.dart';
import 'package:cinenexa/widgets/vote_indicator.dart';
import 'package:cinenexa/services/constants.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/rounded_image.dart';

import '../resources/strings.dart';
import '../resources/style.dart';
import '../utils/date_time_formatter.dart';

class SearchResultTile extends StatelessWidget {
  final String image, year, overview, title, type;
  final double vote;
  final Color? typeColor;
  final Function()? onClick;
  const SearchResultTile({
    Key? key,
    required this.image,
    required this.year,
    required this.overview,
    required this.title,
    required this.vote,
    required this.type,
    this.onClick,
    this.typeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 6,
        ),
        child: Container(
          height: ScreenSize.getPercentOfWidth(context, 0.22) /
              Constants.posterAspectRatio,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedImage(
                image: Utils.getPosterUrl(image),
                width: ScreenSize.getPercentOfWidth(context, 0.22),
                ratio: Constants.posterAspectRatio,
                radius: Style.smallRoundEdgeRadius,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    type == Strings.movie
                                        ? Icons.movie_creation_outlined
                                        : Icons.live_tv_rounded,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "${DateTimeFormatter.getYearFromString(year)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "$overview",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (vote != 0)
                          Padding(
                            padding: EdgeInsets.only(
                              top: ScreenSize.getPercentOfWidth(context, 0.01),
                              right:
                                  ScreenSize.getPercentOfWidth(context, 0.01),
                            ),
                            child: VoteIndicator(
                              vote: vote,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
