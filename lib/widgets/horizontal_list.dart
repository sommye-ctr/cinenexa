import 'package:flutter/material.dart';
import 'package:watrix/models/home.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_image.dart';

class HorizontalList extends StatelessWidget {
  final Future<List<Home>> future;
  final String heading;
  final Function() onClick;
  final double widthPercent;
  const HorizontalList(
      this.future, this.heading, this.onClick, this.widthPercent,
      {Key? key})
      : super(key: key);

  Widget handleListBuilder(
      BuildContext context, AsyncSnapshot<List<Home>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      return Container(
        height: ScreenSize.getPercentOfWidth(context, widthPercent) /
            Constants.posterAspectRatio,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 16,
            );
          },
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) => RoundedImage(
            "https://image.tmdb.org/t/p/w342${snapshot.data![index].posterPath}",
            ScreenSize.getPercentOfWidth(context, widthPercent),
          ),
        ),
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
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FutureBuilder<List<Home>>(
          future: future,
          builder: handleListBuilder,
        ),
      ],
    );
  }
}
