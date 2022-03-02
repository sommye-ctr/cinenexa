import 'dart:async';
import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/bubble_page_indicator.dart';
import 'package:watrix/widgets/rounded_image.dart';

class ImageCarousel extends StatefulWidget {
  final Future<List<BaseModel>> future;
  final Function(int page, BaseModel data)? onPageChanged;
  const ImageCarousel(this.future, {Key? key, this.onPageChanged})
      : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0, _length = 0;
  late Timer _timer;
  late PageController _pageController;
  List<BaseModel> _list = [];

  Widget handleListBuilder(
      BuildContext context, AsyncSnapshot<List<BaseModel>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      _length = snapshot.data!.length;
      _list = snapshot.data!;

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: (ScreenSize.getPercentOfWidth(context, 1) /
                    Constants.backdropAspectRatio) +
                ScreenSize.getPercentOfHeight(
                  context,
                  0.03,
                ),
            child: PageView.builder(
              itemCount: _length,
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
                        image: Utils.getBackdropUrl(
                            snapshot.data![index].backdropPath!),
                        width: ScreenSize.getPercentOfWidth(context, 1),
                        ratio: Constants.backdropAspectRatio,
                      ),
                      Text(
                        snapshot.data![index].title!,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          BubblePageIndicator(
            length: snapshot.data!.length,
            currentPage: _currentIndex,
          ),
        ],
      );
    }
    return CircularProgressIndicator();
  }

  void onChanged(int page) {
    setState(() {
      _currentIndex = page;
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
    return FutureBuilder<List<BaseModel>>(
      future: widget.future,
      builder: handleListBuilder,
    );
  }
}
