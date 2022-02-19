import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watrix/utils/screen_size.dart';

class RoundedImage extends StatelessWidget {
  final String image;
  final double width;
  final double ratio;
  const RoundedImage({
    Key? key,
    required this.image,
    required this.width,
    required this.ratio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: image,
        width: width,
        fit: BoxFit.contain,
        placeholder: (context, url) {
          return Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            period: Duration(
              seconds: 2,
            ),
            child: Container(
              width: width,
              height: (width / ratio) -
                  ScreenSize.getPercentOfHeight(context, 0.02),
              color: Colors.grey,
            ),
          );
        },
        errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded),
      ),
    );
  }
}
