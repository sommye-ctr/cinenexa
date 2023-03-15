import 'package:flutter/material.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/widgets/rounded_image.dart';

import '../services/constants.dart';

class MovieTile extends StatelessWidget {
  final String image, text;
  final double width;
  final bool showTitle;
  final bool darken;

  final VoidCallback? onClick;
  final VoidCallback? onLongClick;

  MovieTile({
    required this.image,
    this.text = "",
    required this.width,
    this.showTitle = false,
    this.onClick,
    this.onLongClick,
    this.darken = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = (width / Constants.posterAspectRatio);

    return GestureDetector(
      onTap: onClick,
      onLongPress: onLongClick,
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: height,
                  child: RoundedImage(
                    image: image,
                    width: width,
                    ratio: Constants.posterAspectRatio,
                  ),
                ),
                if (darken)
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(
                        Style.largeRoundEdgeRadius,
                      ),
                    ),
                  ),
              ],
            ),
            ...getConditionedWidgets(context),
          ],
        ),
      ),
    );
  }

  List<Widget> getConditionedWidgets(context) {
    if (showTitle) {
      return [
        Style.getVerticalSpacing(context: context, percent: 0.01),
        Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ];
    }
    return [];
  }
}
