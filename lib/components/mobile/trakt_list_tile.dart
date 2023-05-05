import 'package:cinenexa/models/network/trakt/trakt_list.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/constants.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/widgets/rounded_image.dart';
import 'package:cinenexa/widgets/stacked_images.dart';
import 'package:flutter/material.dart';

import '../../utils/screen_size.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 16,
        ),
        child: Container(
          height: list.items.isNotEmpty
              ? ScreenSize.getPercentOfWidth(context, 0.25) /
                  Constants.posterAspectRatio
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (list.items.isNotEmpty)
                StackedImages(
                  urls: [
                    Utils.getPosterUrl(list.items[0].posterPath!),
                    if (list.items.length > 1)
                      Utils.getPosterUrl(list.items[1].posterPath!),
                    if (list.items.length > 2)
                      Utils.getPosterUrl(list.items[2].posterPath!)
                  ],
                  width: ScreenSize.getPercentOfWidth(context, 0.25),
                  ratio: Constants.posterAspectRatio,
                ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                      ],
                    ),
                    Style.getVerticalSpacing(context: context),
                    Text("${list.itemCount} items"),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${list.likes}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Icon(
                    Icons.thumb_up_alt_rounded,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
