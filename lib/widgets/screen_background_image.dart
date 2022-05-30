import 'package:flutter/material.dart';
import 'package:watrix/utils/screen_size.dart';

class ScreenBackgroundImage extends StatelessWidget {
  final Widget child;
  final ImageProvider image;
  final double heightPercent;
  const ScreenBackgroundImage({
    Key? key,
    required this.child,
    required this.image,
    this.heightPercent = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.getPercentOfHeight(context, heightPercent),
      child: Stack(
        children: [
          ShaderMask(
            blendMode: BlendMode.darken,
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  Colors.black12,
                  Colors.black54,
                  Colors.black87,
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
