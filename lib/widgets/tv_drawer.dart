import 'dart:ui';

import 'package:flutter/material.dart';

class TvDrawer extends StatelessWidget {
  final Widget leftChild, rightChild;
  final bool blurBg;
  const TvDrawer({
    required this.leftChild,
    required this.rightChild,
    this.blurBg = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: blurBg
          ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
          : ImageFilter.blur(),
      child: Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 3, child: Center(child: leftChild)),
            Flexible(flex: 5, child: Center(child: rightChild))
          ],
        ),
      ),
    );
  }
}
