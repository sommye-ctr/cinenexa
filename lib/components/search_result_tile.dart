import 'package:flutter/material.dart';
import 'package:watrix/components/vote_indicator.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_image.dart';

import '../resources/style.dart';

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
      child: Container(
        width: ScreenSize.getPercentOfWidth(context, 0.8),
        height: ScreenSize.getPercentOfWidth(context, 0.22) /
            Constants.posterAspectRatio,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
          ),
          elevation: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedImage(
                image: Utils.getPosterUrl(image),
                width: ScreenSize.getPercentOfWidth(context, 0.22),
                ratio: Constants.posterAspectRatio,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "($year)",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Style.smallRoundEdgeRadius),
                                  color: typeColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    "$type",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
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
                    Text(
                      "$overview",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                      ),
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
