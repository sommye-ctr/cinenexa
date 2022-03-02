import 'package:flutter/material.dart';

import '../utils/screen_size.dart';

class BubblePageIndicator extends StatefulWidget {
  final int length;
  final PageController pageController;
  int currentPage;
  BubblePageIndicator({
    Key? key,
    required this.length,
    required this.pageController,
    required this.currentPage,
  }) : super(key: key);

  @override
  State<BubblePageIndicator> createState() => _BubblePageIndicatorState();
}

class _BubblePageIndicatorState extends State<BubblePageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.length; i++)
          Row(
            children: [
              AnimatedContainer(
                duration: Duration(
                  seconds: 1,
                ),
                curve: Curves.decelerate,
                height: ScreenSize.getPercentOfWidth(context, 0.025),
                width: ScreenSize.getPercentOfWidth(context, 0.025),
                decoration: BoxDecoration(
                  color: i == widget.currentPage ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
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
