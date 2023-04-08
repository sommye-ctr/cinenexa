import 'package:cinenexa/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class StackedImages extends StatelessWidget {
  final List<String> urls;
  final double width;
  final double ratio;
  const StackedImages({
    required this.urls,
    required this.width,
    required this.ratio,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width / ratio,
      child: Stack(
        children: [
          if (urls.length > 0)
            RoundedImage(
              image: urls[0],
              width: width,
              ratio: ratio,
            ),
          if (urls.length > 1)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: RoundedImage(
                image: urls[1],
                width: width,
                ratio: ratio,
              ),
            ),
          if (urls.length > 2)
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: RoundedImage(
                image: urls[2],
                width: width,
                ratio: ratio,
              ),
            ),
        ],
      ),
    );
  }
}
