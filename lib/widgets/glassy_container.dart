import 'dart:ui';
import 'package:flutter/material.dart';

import '../resources/style.dart';

class GlassyContainer extends StatelessWidget {
  final Widget child;
  const GlassyContainer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
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
