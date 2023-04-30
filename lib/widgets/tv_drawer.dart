import 'dart:ui';

import 'package:flutter/material.dart';

class TvDrawer extends StatelessWidget {
  final Widget leftChild, rightChild;
  const TvDrawer({required this.leftChild, required this.rightChild, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(flex: 3, child: leftChild),
            Flexible(flex: 5, child: rightChild)
          ],
        ),
      ),
    );
  }
}
