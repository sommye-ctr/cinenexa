import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watrix/models/home.dart';
import 'package:watrix/models/home_movie.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_image.dart';

class ImageCarousel extends StatefulWidget {
  final Future<List<HomeMovie>> future;
  final Function(int page, Home data)? onPageChanged;
  const ImageCarousel(this.future, {Key? key, this.onPageChanged})
      : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0, _length = 0;
  late Timer _timer;
  late PageController _pageController;
  List<Home> _list = [];

  Widget handleListBuilder(
      BuildContext context, AsyncSnapshot<List<HomeMovie>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      _length = snapshot.data!.length;
      _list = snapshot.data!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: (ScreenSize.getPercentOfWidth(context, 1) /
                    Constants.backdropAspectRatio) +
                ScreenSize.getPercentOfHeight(context, 0.02),
            child: PageView.builder(
              itemCount: snapshot.data!.length,
              pageSnapping: true,
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: onChanged,
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < snapshot.data!.length; i++)
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(
                        seconds: 1,
                      ),
                      curve: Curves.decelerate,
                      height: ScreenSize.getPercentOfWidth(context, 0.025),
                      width: ScreenSize.getPercentOfWidth(context, 0.025),
                      decoration: BoxDecoration(
                        color: i == _currentIndex ? Colors.black : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(
                      width: ScreenSize.getPercentOfWidth(context, 0.008),
                    ),
                  ],
                )
            ],
          ),
        ],
      );
    }
    return CircularProgressIndicator();
  }

  void onChanged(int page) {
    print("hello there");
    setState(() {
      _currentIndex = page;
      print("hello!");
      if (widget.onPageChanged != null) {
        widget.onPageChanged!(page, _list[page]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
    _timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        if (_currentIndex < _length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }

        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeIn,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HomeMovie>>(
      future: widget.future,
      builder: handleListBuilder,
    );
  }
}
