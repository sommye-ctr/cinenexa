import 'package:cinenexa/models/network/trakt/trakt_list.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:flutter/material.dart';

import '../utils/screen_size.dart';

class TraktListTile extends StatelessWidget {
  final TraktList list;
  final VoidCallback? onClick;
  const TraktListTile({
    required this.list,
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: ScreenSize.getPercentOfHeight(context, 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "By ${list.userName}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Style.getVerticalSpacing(context: context),
                    Text("${list.itemCount} items"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${list.likes}"),
                    SizedBox(height: 4),
                    Icon(
                      Icons.thumb_up_alt_rounded,
                      color: Colors.blue,
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
}
