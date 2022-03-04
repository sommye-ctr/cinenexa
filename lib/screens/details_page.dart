import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watrix/components/vote_indicator.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/models/movie.dart';
import 'package:watrix/models/tv.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/entity_type.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/date_time_formatter.dart';
import 'package:watrix/widgets/bubble_page_indicator.dart';
import 'package:watrix/widgets/rounded_button.dart';
import 'package:watrix/widgets/screen_background_image.dart';

import 'package:http/http.dart' as http;

import '../utils/screen_size.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = "/details";

  final BaseModel baseModel;
  const DetailsPage({
    Key? key,
    required this.baseModel,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _currentIndex = 0;
  Movie? movie;
  Tv? tv;

  @override
  void initState() {
    fetch();
    super.initState();
  }

  void fetch() async {
    if (widget.baseModel.type == BaseModelType.movie) {
      movie = await Requests.findMovie(id: widget.baseModel.id!);
    } else if (widget.baseModel.type == BaseModelType.tv) {
      tv = await Requests.findTv(id: widget.baseModel.id!);
    }
    setState(() {});
  }

  List<String>? getGenres() {
    if (widget.baseModel.type == BaseModelType.movie) {
      return movie?.genres?.map((e) => e.name).toList();
    } else if (widget.baseModel.type == BaseModelType.tv) {
      return tv?.genres?.map((e) => e.name).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            pageSnapping: true,
            physics: BouncingScrollPhysics(),
            onPageChanged: onPageChanged,
            children: [
              _Page1(
                baseModel: widget.baseModel,
                genres: getGenres(),
                tvShowEndTime: tv?.lastAirDate,
                runtime: movie?.runtime != null
                    ? DateTimeFormatter.getTimeFromMin(movie!.runtime!)
                    : null,
              ),
              Center(child: Text("Hello!")),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: ScreenSize.getPercentOfWidth(context, 0.03),
              bottom: ScreenSize.getPercentOfHeight(context, 0.05),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: BubblePageIndicator(
                length: 5,
                currentPage: _currentIndex,
                selectedColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    setState(() {});
  }
}

class _Page1 extends StatelessWidget {
  final BaseModel baseModel;
  final List<String>? genres;
  final String? runtime;
  final String? tvShowEndTime;

  const _Page1({
    Key? key,
    required this.baseModel,
    this.genres,
    this.runtime,
    this.tvShowEndTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> genreWidgets = [];
    for (String str in genres ?? []) {
      genreWidgets.add(
        Padding(
          padding: EdgeInsets.only(
            right: ScreenSize.getPercentOfWidth(context, 0.01),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                "$str",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      );
    }

    String date =
        " (${DateTimeFormatter.getYearFromString(baseModel.releaseDate!)})";
    if (tvShowEndTime != null) {
      date = date.substring(0, date.length - 1);
      date =
          date + " - ${DateTimeFormatter.getYearFromString(tvShowEndTime!)})";
    }

    return ScreenBackgroundImage(
      image: CachedNetworkImageProvider(
        Utils.getPosterUrl(
          baseModel.posterPath!,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenSize.getPercentOfWidth(context, 0.025),
            right: ScreenSize.getPercentOfWidth(context, 0.025),
            bottom: ScreenSize.getPercentOfHeight(context, 0.1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Utils.getColorByEntity(baseModel.type!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    "${Utils.getEntityTypeBy(baseModel.type!)}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: baseModel.title!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: date,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      if (runtime != null)
                        TextSpan(
                          text: " - ${runtime}",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.01),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    VoteIndicator(
                      vote: baseModel.voteAverage!,
                    ),
                    SizedBox(
                      width: ScreenSize.getPercentOfWidth(context, 0.01),
                    ),
                    Row(
                      children: genreWidgets,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.01),
              ),
              Text(
                baseModel.overview!,
                maxLines: 15,
              ),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.01),
              ),
              Row(
                children: [
                  RoundedButton(
                    onPressed: () {},
                    child: Text("Add to List"),
                    type: RoundedButtonType.filled,
                  ),
                  SizedBox(
                    width: ScreenSize.getPercentOfWidth(context, 0.01),
                  ),
                  RoundedButton(
                    onPressed: () {},
                    child: Text("View Info"),
                    type: RoundedButtonType.outlined,
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
