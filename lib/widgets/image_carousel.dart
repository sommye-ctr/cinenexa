import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/network/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/bubble_page_indicator.dart';
import 'package:watrix/widgets/rounded_image.dart';

import '../models/network/base_model.dart';

class ImageCarousel extends StatefulWidget {
  final Future<List<BaseModel>> future;
  final Function(int page, BaseModel data)? onPageChanged;
  final Function(BaseModel data)? onClick;
  const ImageCarousel(
    this.future, {
    Key? key,
    this.onPageChanged,
    this.onClick,
  }) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;
  List<BaseModel> _list = [];

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future _fetch() async {
    _list.addAll(await widget.future);
    setState(() {});
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    _currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (ScreenSize.getPercentOfWidth(context, 0.6) /
              Constants.posterAspectRatio) +
          BubblePageIndicator.height +
          ScreenSize.getPercentOfHeight(context, 0.08),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: ScreenSize.getPercentOfWidth(context, 0.6) /
                  Constants.posterAspectRatio,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              initialPage: 0,
              scrollPhysics: BouncingScrollPhysics(),
              onPageChanged: onPageChanged,
              enlargeCenterPage: true,
              viewportFraction: 0.6,
            ),
            items: _list.map((e) {
              return GestureDetector(
                onTap: () {
                  if (widget.onClick != null) widget.onClick!(e);
                },
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Style.largeRoundEdgeRadius),
                    child: RoundedImage(
                      image: Utils.getPosterUrl(
                        e.posterPath!,
                      ),
                      ratio: Constants.posterAspectRatio,
                      width: ScreenSize.getPercentOfWidth(context, 0.6),
                    )),
              );
            }).toList(),
          ),
          Text(
            _list.isEmpty ? "" : _list[_currentIndex].title!,
          ),
          BubblePageIndicator(
            length: _list.length,
            currentPage: _currentIndex,
          ),
        ],
      ),
    );
  }

  /* Widget _buildPageView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_list.isNotEmpty) {
          return Container(
            height: ScreenSize.getPercentOfWidth(context, 1) /
                Constants.backdropAspectRatio,
            child: PageView.builder(
              itemCount: _list.length,
              pageSnapping: true,
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: onChanged,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (widget.onClick != null) widget.onClick!(_list[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    child: RoundedImage(
                      image: Utils.getBackdropUrl(_list[index].backdropPath!),
                      width: ScreenSize.getPercentOfWidth(context, 1),
                      ratio: Constants.backdropAspectRatio,
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.all(4),
          child: RoundedImagePlaceholder(
            width: ScreenSize.getPercentOfWidth(context, 1),
            ratio: Constants.backdropAspectRatio,
          ),
        );
      },
    );
  } */
}
