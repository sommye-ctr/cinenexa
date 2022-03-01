import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/movie_tile.dart';

class HorizontalList extends StatelessWidget {
  final Future<List<BaseModel>> future;
  final String heading;
  final Function(BaseModel data) onClick;
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
      BuildContext context, AsyncSnapshot<List<BaseModel>> snapshot) {
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
              BaseModel item = snapshot.data![index];

              return MovieTile(
                image: Utils.getPosterUrl(item.posterPath!),
                text: item.title!,
                width: ScreenSize.getPercentOfWidth(context, itemWidthPercent),
                showTitle: showTitle,
                onClick: () {
                  onClick(item);
                },
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
        FutureBuilder<List<BaseModel>>(
          future: future,
          builder: handleListBuilder,
        ),
      ],
    );
  }
}
