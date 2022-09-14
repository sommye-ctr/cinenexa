import 'package:flutter/material.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/widgets/rounded_image.dart';

import '../services/constants.dart';

class MovieTile extends StatelessWidget {
  final String image, text;
  final double width;
  final bool showTitle;

  final void Function()? onClick;

  MovieTile({
    required this.image,
    this.text = "",
    required this.width,
    this.showTitle = false,
    this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: width / Constants.posterAspectRatio,
                child: RoundedImage(
                  image: image,
                  width: width,
                  ratio: Constants.posterAspectRatio,
                )),
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
