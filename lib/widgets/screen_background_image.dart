import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cinenexa/utils/screen_size.dart';

class ScreenBackgroundImage extends StatelessWidget {
  final Widget child;
  final String image;
  final String? placeHolder;
  final double heightPercent;
  const ScreenBackgroundImage({
    Key? key,
    required this.child,
    required this.image,
    this.placeHolder,
    this.heightPercent = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, value, child) {
        bool isDarkMode = value == AdaptiveThemeMode.dark;

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
                Colors.white.withOpacity(0.6),
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
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    height: ScreenSize.getPercentOfHeight(context, 1),
                    width: ScreenSize.getPercentOfWidth(context, 1),
                    fadeInDuration: Duration(microseconds: 1),
                    placeholder: placeHolder != null
                        ? (context, url) => CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: placeHolder!,
                            )
                        : null,
                  ),
                ),
              ),
              this.child,
            ],
          ),
        );
      },
    );
  }
}
