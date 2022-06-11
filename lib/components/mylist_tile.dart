import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/screen_background_image.dart';

class MyListTile extends StatelessWidget {
  final Function() onClick;
  final String title;
  final String backdropUrl;
  final int noOfItems;
  final double? heightPercent;
  const MyListTile({
    Key? key,
    required this.backdropUrl,
    required this.title,
    required this.onClick,
    required this.noOfItems,
    this.heightPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: ScreenSize.getPercentOfWidth(context, 0.9),
        height: ScreenSize.getPercentOfHeight(context, heightPercent ?? 0.1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            Style.largeRoundEdgeRadius,
          ),
          child: Stack(
            children: [
              ScreenBackgroundImage(
                child: Container(),
                image: CachedNetworkImageProvider(backdropUrl),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "$noOfItems items",
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
