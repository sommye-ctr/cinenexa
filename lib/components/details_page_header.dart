import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watrix/components/vote_indicator.dart';
import 'package:watrix/utils/screen_size.dart';

import '../resources/strings.dart';
import '../services/utils.dart';
import '../store/details/details_page1_store.dart';
import '../utils/date_time_formatter.dart';
import '../widgets/rounded_button.dart';
import '../widgets/screen_background_image.dart';

class DetailsPageHeader extends SliverPersistentHeaderDelegate {
  final DetailsPage1Store page1store;
  final String title, poster, overview;
  final double voteAverage;
  final double maxHeight, minHeight;

  late double progress;
  late Duration duration;

  DetailsPageHeader({
    required this.page1store,
    required this.overview,
    required this.voteAverage,
    required this.title,
    required this.poster,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    progress = shrinkOffset / (maxExtent - minExtent);
    duration = Duration(
      milliseconds: 200,
    );

    return ScreenBackgroundImage(
      image: CachedNetworkImageProvider(
        Utils.getPosterUrl(
          poster,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.getPercentOfWidth(context, 0.025),
            ),
            child: Align(
              alignment: Alignment(0, 0.5),
              child: Wrap(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildMainDetails(context),
                      _buildFadingContent(context, shrinkOffset),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildDownArrow(shrinkOffset),
        ],
      ),
    );
  }

  Widget _buildDownArrow(shrinkOffset) {
    return _buildFading(
      Align(
        alignment: Alignment(0, 0.85),
        child: Icon(Icons.keyboard_arrow_down),
      ),
      shrinkOffset,
    );
  }

  Widget _buildFadingContent(context, shrinkOffset) {
    return _buildFading(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSpacing(context),
          _buildOverView(),
          _buildSpacing(context),
          _buildButtons(context),
        ],
      ),
      shrinkOffset,
    );
  }

  Widget _buildFading(Widget child, shrinkOffset) {
    return Visibility(
      visible: shrinkOffset != minExtent,
      child: AnimatedOpacity(
        duration: duration,
        opacity: 1 - progress,
        child: child,
      ),
    );
  }

  Widget _buildMainDetails(context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            _buildTitle(),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: ScreenSize.getPercentOfWidth(context, 0.01),
              children: [
                _buildReleaseInfo(),
                VoteIndicator(
                  vote: voteAverage,
                ),
                if (page1store.runtime != null) _buildRuntime(),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildReleaseInfo() {
    return Text(
      "${_getReleaseInfo()} - ",
      style: TextStyle(
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildRuntime() {
    return Text(
      " - ${DateTimeFormatter.getTimeFromMin(page1store.runtime!)}",
      style: TextStyle(
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildOverView() {
    return Text(
      overview,
      maxLines: 10,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildButtons(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedButton(
          onPressed: () {},
          child: Text(Strings.addToList),
          type: RoundedButtonType.filled,
        ),
        _buildSpacing(context),
        RoundedButton(
          onPressed: () {},
          child: Text(Strings.viewInfo),
          type: RoundedButtonType.outlined,
        ),
      ],
    );
  }

  Widget _buildSpacing(context) {
    return SizedBox(
      height: ScreenSize.getPercentOfHeight(context, 0.01),
      width: ScreenSize.getPercentOfHeight(context, 0.01),
    );
  }

  String _getReleaseInfo() {
    int startYear =
        DateTimeFormatter.getYearFromString(page1store.releaseDate!);
    String date = " ($startYear)";
    if (page1store.tvShowEndTime != null) {
      int endYear =
          DateTimeFormatter.getYearFromString(page1store.tvShowEndTime!);
      if (startYear != endYear) {
        date = date.substring(0, date.length - 1);
        date = date +
            " - ${DateTimeFormatter.getYearFromString(page1store.tvShowEndTime!)})";
      }
    }
    return date;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
