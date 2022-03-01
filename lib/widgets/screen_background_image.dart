import 'package:flutter/material.dart';

class ScreenBackgroundImage extends StatelessWidget {
  final Widget child;
  final ImageProvider image;
  const ScreenBackgroundImage({
    Key? key,
    required this.child,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
