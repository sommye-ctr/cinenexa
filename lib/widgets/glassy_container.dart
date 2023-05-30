import 'dart:ui';
import 'package:flutter/material.dart';

import '../resources/style.dart';

class GlassyContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? borderRadius;
  const GlassyContainer(
      {required this.child, this.borderRadius, this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.transparent,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(borderRadius ?? Style.smallRoundEdgeRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: child,
        ),
      ),
    );
  }
}
