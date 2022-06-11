import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:watrix/utils/screen_size.dart';

import '../resources/style.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkResponse(
          onTap: () => Navigator.maybePop(context),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 50,
              sigmaY: 50,
            ),
            child: Container(
              height: ScreenSize.getPercentOfHeight(context, 0.06),
              width: ScreenSize.getPercentOfHeight(context, 0.06),
              child: Icon(Icons.arrow_back_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
