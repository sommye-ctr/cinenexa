import 'package:flutter/material.dart';
import 'package:watrix/widgets/rounded_image.dart';

import '../services/constants.dart';

class MovieTile extends StatelessWidget {
  final String image, text;
  final double width;
  final bool showTitle;

  MovieTile(
      {required this.image,
      this.text = "",
      required this.width,
      this.showTitle = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: width / Constants.posterAspectRatio,
            child: RoundedImage(image, width),
          ),
          if (showTitle == true)
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
