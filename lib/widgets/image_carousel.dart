import 'package:flutter/material.dart';
import 'package:watrix/models/home_movie.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_image.dart';

class ImageCarousel extends StatefulWidget {
  final Future<List<HomeMovie>> future;
  const ImageCarousel(this.future, {Key? key}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  Widget handleListBuilder(
      BuildContext context, AsyncSnapshot<List<HomeMovie>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return Container(
        height: (ScreenSize.getPercentOfWidth(context, 1) /
                Constants.backdropAspectRatio) +
            ScreenSize.getPercentOfHeight(context, 0.02),
        child: PageView.builder(
          itemCount: snapshot.data!.length,
          pageSnapping: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedImage(
                    "${Constants.imageBaseUrl}${Constants.backdropSize}${snapshot.data![index].backdropPath}",
                    ScreenSize.getPercentOfWidth(
                      context,
                      1,
                    ),
                  ),
                  Text(snapshot.data![index].title),
                ],
              ),
            );
          },
        ),
      );
    }
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HomeMovie>>(
      future: widget.future,
      builder: handleListBuilder,
    );
  }
}
