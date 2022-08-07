import 'package:flutter/material.dart';
import 'package:watrix/utils/screen_size.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkResponse(
          splashColor: Theme.of(context).colorScheme.primary,
          highlightColor: Theme.of(context).colorScheme.primary,
          onTap: () => Navigator.maybePop(context),
          child: Container(
            color: Colors.white.withOpacity(0.5),
            height: ScreenSize.getPercentOfHeight(context, 0.06),
            width: ScreenSize.getPercentOfHeight(context, 0.06),
            child: Icon(Icons.arrow_back_rounded),
          ),
        ),
      ),
    );
  }
}
