import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Opacity(
          opacity: 0.5,
          child: ElevatedButton(
            onPressed: () {},
            child: Icon(Icons.arrow_back_rounded),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
