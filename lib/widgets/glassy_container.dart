import 'dart:ui';
import 'package:flutter/material.dart';

import '../resources/style.dart';

class GlassyContainer extends StatefulWidget {
  final Widget child;
  final double? borderRadius;

  final GlassyController? controller;
  const GlassyContainer(
      {required this.child, this.borderRadius, this.controller, Key? key})
      : super(key: key);

  @override
  State<GlassyContainer> createState() => _GlassyContainerState();
}

class _GlassyContainerState extends State<GlassyContainer> {
  @override
  void initState() {
    widget.controller?.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
          widget.borderRadius ?? Style.smallRoundEdgeRadius),
      child: Material(
        color: widget.controller?.color ?? Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class GlassyController extends ChangeNotifier {
  Color? color;
  GlassyController({
    this.color,
  });

  void changeColor(Color? newType) {
    color = newType;
    notifyListeners();
  }
}
