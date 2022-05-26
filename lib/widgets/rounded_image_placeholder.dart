import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/screen_size.dart';

class RoundedImagePlaceholder extends StatelessWidget {
  final double width, ratio;
  const RoundedImagePlaceholder({
    Key? key,
    required this.width,
    required this.ratio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
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
