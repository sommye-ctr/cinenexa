import 'package:flutter/material.dart';
import 'package:watrix/models/home.dart';
import 'package:watrix/models/home_movie.dart';
import 'package:watrix/models/home_people.dart';
import 'package:watrix/models/home_tv.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_image.dart';

class HorizontalList extends StatelessWidget {
  final Future<List<Home>> future;
  final String heading;
  final Function() onClick;
  final double widthPercent;
  final String type;

  HorizontalList(
    this.future,
    this.heading,
    this.onClick,
    this.widthPercent,
    this.type, {
    Key? key,
  }) : super(key: key);

  Widget handleListBuilder(
      BuildContext context, AsyncSnapshot<List<Home>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      return Container(
        height: ScreenSize.getPercentOfWidth(context, widthPercent) /
            Constants.posterAspectRatio,
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 4,
              );
            },
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              String url = "";
              Home item = snapshot.data![index];
              if (type == Constants.movie) {
                url = (item as HomeMovie).posterPath;
              } else if (type == Constants.tv) {
                url = (item as HomeTv).posterPath;
              } else {
                url = (item as HomePeople).profilePath;
              }
              return RoundedImage(
                "${Constants.imageBaseUrl}${Constants.posterSize}${url}",
                ScreenSize.getPercentOfWidth(context, widthPercent),
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
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        FutureBuilder<List<Home>>(
          future: future,
          builder: handleListBuilder,
        ),
      ],
    );
  }
}
