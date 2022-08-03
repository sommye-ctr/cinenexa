import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watrix/resources/my_theme.dart';
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
    bool isDarkMode = Provider.of<MyTheme>(context).darkMode;
    List<Color> colors = isDarkMode
        ? [
            Colors.transparent,
            Colors.black.withOpacity(0.26),
            Colors.black.withOpacity(0.38),
            Colors.black.withOpacity(0.45),
            Colors.black
          ]
        : [
            Colors.transparent,
            Colors.white.withOpacity(0.26),
            Colors.white.withOpacity(0.48),
            Colors.white.withOpacity(0.7),
            Colors.white
          ];

    return Container(
      height: ScreenSize.getPercentOfHeight(context, heightPercent),
      child: Stack(
        children: [
          ShaderMask(
            blendMode: isDarkMode ? BlendMode.darken : BlendMode.lighten,
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: colors,
                stops: [
                  0,
                  0.35,
                  0.45,
                  0.5,
                  0.95,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
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
