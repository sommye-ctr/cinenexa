import 'dart:ui';

import 'package:flutter/material.dart';

import '../../resources/style.dart';

class TvInfoCard extends StatelessWidget {
  final Widget text;
  const TvInfoCard({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Material(
        elevation: Style.cardElevation,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: text,
          ),
        ),
      ),
    );
  }
}
