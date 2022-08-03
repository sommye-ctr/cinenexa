import 'package:flutter/material.dart';

import '../resources/style.dart';
import '../utils/screen_size.dart';

class BubblePageIndicator extends StatelessWidget {
  static const double width = 0.025;
  static const double height = 0.025;

  final int length;
  final int currentPage;

  Color? selectedColor;
  BubblePageIndicator({
    Key? key,
    required this.length,
    required this.currentPage,
    this.selectedColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < length; i++)
          Row(
            children: [
              AnimatedContainer(
                duration: Duration(
                  seconds: 1,
                ),
                curve: Curves.decelerate,
                height: ScreenSize.getPercentOfWidth(context, width),
                width: ScreenSize.getPercentOfWidth(context, height),
                decoration: BoxDecoration(
                  color: i == currentPage ? selectedColor : Colors.grey,
                  borderRadius:
                      BorderRadius.circular(Style.smallRoundEdgeRadius),
                ),
              ),
              SizedBox(
                width: ScreenSize.getPercentOfWidth(context, 0.008),
              ),
            ],
          )
      ],
    );
  }
}
