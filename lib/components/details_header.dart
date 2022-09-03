import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:watrix/widgets/vote_indicator.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/store/details/details_store.dart';
import 'package:watrix/store/favorites/favorites_store.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/custom_back_button.dart';

import '../models/network/base_model.dart';
import '../resources/strings.dart';
import '../services/network/utils.dart';
import '../utils/date_time_formatter.dart';
import '../widgets/rounded_button.dart';
import '../widgets/screen_background_image.dart';

class DetailsHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight, minHeight;
  final DetailsStore detailsStore;
  final ScrollController scrollController;

  late double progress;
  late Duration duration;

  DetailsHeader({
    required this.maxHeight,
    required this.minHeight,
    required this.detailsStore,
    required this.scrollController,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    progress = shrinkOffset / (maxExtent - minExtent);
    duration = Duration(
      milliseconds: 200,
    );

    return Stack(
      children: [
        _buildFading(
          ScreenBackgroundImage(
            image: Utils.getPosterUrl(
              detailsStore.baseModel.posterPath!,
              posterSize: Constants.hdPosterSize,
            ),
            placeHolder: Utils.getPosterUrl(
              detailsStore.baseModel.posterPath!,
            ),
            child: Container(),
          ),
          shrinkOffset,
        ),
        _buildFading(
          ScreenBackgroundImage(
            image: Utils.getBackdropUrl(detailsStore.baseModel.backdropPath!),
            child: Container(),
          ),
          shrinkOffset,
          reverse: true,
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.getPercentOfWidth(context, 0.025),
          ),
          child: Align(
            alignment: Alignment(0, 0.6),
            child: Wrap(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildNonFadingContent(context, shrinkOffset),
                    _buildFadingContent(context, shrinkOffset),
                  ],
                ),
              ],
            ),
          ),
        ),
        _buildDownArrow(shrinkOffset),
      ],
    );
  }

  Widget _buildDownArrow(shrinkOffset) {
    return _buildFading(
      Align(
        alignment: Alignment(0, 0.9),
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
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
          _buildOverView(context),
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
          _buildButtons(context),
        ],
      ),
      shrinkOffset,
    );
  }

  Widget _buildFading(Widget child, shrinkOffset, {bool reverse = false}) {
    return AnimatedOpacity(
      duration: duration,
      opacity: reverse ? (progress).clamp(0, 1) : (1 - progress).clamp(0, 1),
      child: child,
    );
  }

  Widget _buildNonFadingContent(context, offset) {
    return Column(
      children: [
        _buildTitle(context),
        AnimatedCrossFade(
          duration: duration,
          crossFadeState: progress <= 0.9
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Row(
            key: UniqueKey(),
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildReleaseInfo(context),
              Style.getVerticalHorizontalSpacing(
                  context: context, percent: 0.01),
              VoteIndicator(
                vote: detailsStore.baseModel.voteAverage!,
              ),
              Style.getVerticalHorizontalSpacing(
                  context: context, percent: 0.01),
              Observer(builder: (context) => _buildRuntime(context)),
            ],
          ),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              key: UniqueKey(),
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildReleaseInfo(context),
                Observer(builder: (context) => _buildRuntime(context)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(context) {
    return AnimatedContainer(
      duration: duration,
      padding: EdgeInsets.lerp(
        null,
        EdgeInsets.only(
          top: minExtent / 1.8,
        ),
        progress,
      ),
      child: Text(
        detailsStore.baseModel.title!,
        textAlign: TextAlign.center,
        overflow: progress >= 0.9 ? TextOverflow.ellipsis : null,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildReleaseInfo(context) {
    return Text(
      "${_getReleaseInfo()} ",
      style: TextStyle(
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }

  Widget _buildRuntime(context) {
    if (detailsStore.baseModel.type == BaseModelType.movie) {
      return AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: detailsStore.movie?.runtime != null
            ? Text(
                " ${DateTimeFormatter.getTimeFromMin(detailsStore.movie!.runtime!)}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              )
            : Visibility(
                visible: false,
                child: Text("abcdefghi"),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
              ),
      );
    }
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: detailsStore.tv?.noOfSeasons != null
          ? Text(" ${detailsStore.tv!.noOfSeasons!} ${Strings.seasons}")
          : Visibility(
              visible: false,
              child: Text("abcdefghi"),
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
            ),
    );
  }

  Widget _buildOverView(context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: Text(detailsStore.baseModel.overview!),
              );
            });
      },
      child: Text(
        detailsStore.baseModel.overview!,
        maxLines: 10,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildButtons(context) {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedCrossFade(
            duration: Duration(milliseconds: 500),
            sizeCurve: Curves.decelerate,
            firstChild: RoundedButton(
              onPressed: () => detailsStore.addToListClicked(
                  Provider.of<FavoritesStore>(context, listen: false)),
              type: RoundedButtonType.filled,
              child: Row(
                children: [
                  Text(Strings.addToFav),
                  Icon(Icons.favorite_outline_rounded),
                ],
              ),
            ),
            secondChild: RoundedButton(
              onPressed: () => detailsStore.removeFromListCLicked(
                  Provider.of<FavoritesStore>(context, listen: false)),
              type: RoundedButtonType.outlined,
              child: Row(
                children: [
                  Text(Strings.removeFromFav),
                  Icon(Icons.favorite),
                ],
              ),
            ),
            layoutBuilder: (topChild, topKey, bottomChild, bottomKey) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    child: bottomChild,
                    key: bottomKey,
                  ),
                  Positioned(
                    child: topChild,
                    key: topKey,
                  ),
                ],
              );
            },
            crossFadeState: detailsStore.isAddedToFav
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
          RoundedButton(
            onPressed: _onViewInfoPressed,
            child: Text(Strings.viewInfo),
            type: RoundedButtonType.outlined,
          ),
        ],
      );
    });
  }

  void _onViewInfoPressed() {
    scrollController.animateTo(
      maxExtent - minExtent,
      duration: duration,
      curve: Curves.easeIn,
    );
  }

  String _getReleaseInfo() {
    int startYear = DateTimeFormatter.getYearFromString(
        detailsStore.baseModel.releaseDate!);
    String date = " ($startYear)";
    if (detailsStore.tv?.lastAirDate != null) {
      int endYear =
          DateTimeFormatter.getYearFromString(detailsStore.tv!.lastAirDate!);
      if (startYear != endYear) {
        date = date.substring(0, date.length - 1);
        date = date + " - $endYear)";
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
