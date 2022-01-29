import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/user_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getPercentOfWidth(
          context,
          0.02,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.profile,
            style: Style.headingStyle,
          ),
          SizedBox(
            height: ScreenSize.getPercentOfHeight(
              context,
              0.02,
            ),
          ),
          UserProfileView(
            "Somye",
            "anyone.mahajan@gmail.com",
            0.12,
          ),
          SizedBox(
            height: ScreenSize.getPercentOfHeight(
              context,
              0.05,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.timelapse,
                    color: Colors.blue,
                  ),
                  label: Text(
                    "History",
                  ),
                ),
              ),
              SizedBox(
                width: ScreenSize.getPercentOfWidth(
                  context,
                  0.02,
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Favorite",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
