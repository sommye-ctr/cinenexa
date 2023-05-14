import 'package:flutter/material.dart';

class TvOnScreenKeyboardKey extends StatelessWidget {
  final Widget child;
  final bool isFocused;

  final double? height, width;
  const TvOnScreenKeyboardKey(
      {required this.child,
      this.isFocused = false,
      this.height,
      this.width,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 48,
      height: height ?? 48,
      child: Card(
        color: isFocused ? Theme.of(context).colorScheme.primary : null,
        child: Center(child: child),
      ),
    );
  }
}
