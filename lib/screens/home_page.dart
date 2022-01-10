import 'package:flutter/material.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/user_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenSize.getPercentOfWidth(context, 0.025),
          ),
          child: UserProfileView(),
        ),
      ),
    );
  }
}
