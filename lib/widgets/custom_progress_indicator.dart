import 'package:flutter/material.dart';

import '../resources/style.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double progress;
  final bool? transparent;
  const CustomProgressIndicator({
    Key? key,
    required this.progress,
    this.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: transparent != null ? Colors.transparent : null,
      ),
    );
  }
}
