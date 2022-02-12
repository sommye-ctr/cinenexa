import 'package:flutter/material.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_image.dart';

class SearchResultTile extends StatelessWidget {
  final String image, year, overview, title;
  final double vote;
  const SearchResultTile({
    Key? key,
    required this.image,
    required this.year,
    required this.overview,
    required this.title,
    required this.vote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 0.8),
      height: ScreenSize.getPercentOfWidth(context, 0.2) /
          Constants.posterAspectRatio,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedImage(
              Utils.getPosterUrl(image),
              ScreenSize.getPercentOfWidth(context, 0.25),
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenSize.getPercentOfWidth(context, 0.01),
                          right: ScreenSize.getPercentOfWidth(context, 0.01),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: vote / 10,
                              strokeWidth: 2,
                              backgroundColor: Colors.grey,
                            ),
                            Text("${vote}")
                          ],
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
    );
  }
}
