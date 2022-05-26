import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watrix/widgets/rounded_image_placeholder.dart';

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
          return RoundedImagePlaceholder(width: width, ratio: ratio);
        },
        errorWidget: (context, url, error) => Icon(Icons.error_outline_rounded),
      ),
    );
  }
}
