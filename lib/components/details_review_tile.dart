import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watrix/models/network/review.dart';
import 'package:watrix/resources/asset.dart';
import 'package:watrix/services/network/utils.dart';
import 'package:watrix/utils/date_time_formatter.dart';
import 'package:watrix/utils/screen_size.dart';

import '../resources/style.dart';

class DetailsReviewTile extends StatelessWidget {
  final Review review;
  const DetailsReviewTile({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 0.95),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          Utils.getProfileUrl(review.avatar ?? ""),
                        ),
                      ),
                      SizedBox(
                        width: ScreenSize.getPercentOfWidth(context, 0.01),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.author ?? "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateTimeFormatter.getDateMonthYearFromString(
                                review.createdAt ?? ""),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _buildRating(context),
                ],
              ),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.02),
              ),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(context) {
    return GestureDetector(
      onTap: () {
        if (review.content?.isNotEmpty ?? true)
          showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  content: Text(review.content ?? ""),
                );
              });
      },
      child: Text(
        review.content ?? "",
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildRating(context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_rate_rounded,
              color: Colors.amber,
            ),
            Text(review.rating?.toString() ?? ""),
          ],
        ),
      ),
    );
  }
}
