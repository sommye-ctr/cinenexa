import 'package:flutter/material.dart';

import '../resources/style.dart';
import '../utils/screen_size.dart';

class UserStatCard extends StatelessWidget {
  final int title;
  final String heading;
  const UserStatCard({required this.title, required this.heading, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          right: ScreenSize.getPercentOfWidth(context, 0.1),
          left: ScreenSize.getPercentOfWidth(context, 0.1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toString(),
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
