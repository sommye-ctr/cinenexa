import 'package:flutter/material.dart';
import 'package:watrix/utils/screen_size.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://blogs.umb.edu/cinemastudies/files/2018/04/robert-downey-jr-gty-bio-223yxhg.jpg",
              ),
              radius: ScreenSize.getPercentOfWidth(context, 0.08),
            ),
            SizedBox(
              width: ScreenSize.getPercentOfWidth(context, 0.025),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello RDJ"),
                Text("Enjoy your favourites movies!"),
              ],
            )
          ],
        ),
      ],
    );
  }
}
