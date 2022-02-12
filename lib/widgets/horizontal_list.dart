import 'package:flutter/material.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/movie_tile.dart';

class HorizontalList<T> extends StatelessWidget {
  final Future<List<T>> future;
  final String heading;
  final Function() onClick;
  final double itemWidthPercent;
  final bool showTitle;

  HorizontalList({
    Key? key,
    required this.future,
    required this.heading,
    required this.onClick,
    required this.itemWidthPercent,
    required this.showTitle,
  }) : super(key: key);

  Widget handleListBuilder(
      BuildContext context, AsyncSnapshot<List<T>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      return Container(
        height: ScreenSize.getPercentOfWidth(context, itemWidthPercent) /
                Constants.posterAspectRatio +
            ScreenSize.getPercentOfHeight(
              context,
              0.03,
            ),
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 5,
              );
            },
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              T item = snapshot.data![index];
              String url = Utils.getItemPoster(item);
              String name = Utils.getItemName(item);

              return MovieTile(
                image: Utils.getPosterUrl(url),
                text: name,
                width: ScreenSize.getPercentOfWidth(context, itemWidthPercent),
                showTitle: showTitle,
              );
            }),
      );
    }
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: Style.headingStyle,
        ),
        SizedBox(
          height: 4,
        ),
        FutureBuilder<List<T>>(
          future: future,
          builder: handleListBuilder,
        ),
      ],
    );
  }
}
