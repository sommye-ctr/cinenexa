import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watrix/resources/my_theme.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/user_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool value = false;
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
          Style.getVerticalSpacing(context: context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.darkMode,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              CupertinoSwitch(
                value: value,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: (changeValue) {
                  Provider.of<MyTheme>(context, listen: false)
                      .changeTheme(changeValue);
                  setState(() {
                    value = changeValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
