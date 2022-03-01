import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/widgets/rounded_button.dart';
import 'package:watrix/widgets/screen_background_image.dart';

import '../utils/screen_size.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = "/details";

  final BaseModel baseModel;
  const DetailsPage({
    Key? key,
    required this.baseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroundImage(
        image: CachedNetworkImageProvider(
          Utils.getPosterUrl(
            baseModel.posterPath!,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              left: ScreenSize.getPercentOfWidth(context, 0.025),
              right: ScreenSize.getPercentOfWidth(context, 0.025),
              bottom: ScreenSize.getPercentOfHeight(context, 0.1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: baseModel.title!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  " (${getYearFromString(baseModel.releaseDate!)})",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenSize.getPercentOfHeight(context, 0.01),
                ),
                Text(
                  baseModel.overview!,
                  maxLines: 15,
                ),
                SizedBox(
                  height: ScreenSize.getPercentOfHeight(context, 0.01),
                ),
                Row(
                  children: [
                    RoundedButton(
                      onPressed: () {},
                      child: Text("Add to List"),
                      type: RoundedButtonType.filled,
                    ),
                    SizedBox(
                      width: ScreenSize.getPercentOfWidth(context, 0.01),
                    ),
                    RoundedButton(
                      onPressed: () {},
                      child: Text("View Info"),
                      type: RoundedButtonType.outlined,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getYearFromString(String string) {
    return DateTime.parse(string).year;
  }
}
