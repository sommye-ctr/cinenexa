import 'package:flutter/material.dart';
import 'package:cinenexa/utils/screen_size.dart';

class UserProfileView extends StatelessWidget {
  final String _heading, _subheading;
  final double _widthPercent;
  const UserProfileView(
    this._heading,
    this._subheading,
    this._widthPercent, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              "https://blogs.umb.edu/cinemastudies/files/2018/04/robert-downey-jr-gty-bio-223yxhg.jpg",
            ),
            radius: ScreenSize.getPercentOfWidth(
              context,
              _widthPercent,
            ),
          ),
          SizedBox(
            width: ScreenSize.getPercentOfWidth(context, 0.025),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                _heading,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(_subheading),
            ],
          )
        ],
      ),
    );
  }
}
