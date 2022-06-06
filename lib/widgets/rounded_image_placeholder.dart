import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/style.dart';
import '../utils/screen_size.dart';

class RoundedImagePlaceholder extends StatelessWidget {
  final double width, ratio;
  final double? radius;

  const RoundedImagePlaceholder({
    Key? key,
    required this.width,
    required this.ratio,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? Style.largeRoundEdgeRadius),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        period: Duration(
          seconds: 2,
        ),
        child: Container(
          width: width,
          height:
              (width / ratio) - ScreenSize.getPercentOfHeight(context, 0.02),
          color: Colors.grey,
        ),
      ),
    );
  }
}
