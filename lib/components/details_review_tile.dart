import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinenexa/models/network/review.dart';
import 'package:cinenexa/utils/date_time_formatter.dart';
import 'package:cinenexa/utils/screen_size.dart';

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
              Container(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            color: Theme.of(context).colorScheme.primary,
                            child: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenSize.getPercentOfWidth(context, 0.01),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.user ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
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
        if (review.comment?.isNotEmpty ?? true)
          showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  content: Text(review.comment ?? ""),
                );
              });
      },
      child: Text(
        review.comment ?? "",
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildRating(context) {
    if (review.rating == null) {
      return Container();
    }
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
