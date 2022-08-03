import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watrix/widgets/rounded_image_placeholder.dart';

import '../resources/style.dart';
import '../utils/screen_size.dart';

class RoundedImage extends StatelessWidget {
  final String image;
  final double width;
  final double ratio;
  final double? radius;
  RoundedImage({
    Key? key,
    required this.image,
    required this.width,
    required this.ratio,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? Style.largeRoundEdgeRadius),
      child: CachedNetworkImage(
        imageUrl: image,
        width: width,
        fit: BoxFit.fill,
        placeholder: (context, url) {
          return RoundedImagePlaceholder(
            width: width,
            ratio: ratio,
            radius: radius,
          );
        },
        errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded),
      ),
    );
  }
}
