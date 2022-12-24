import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:watrix/store/user/user_store.dart';
import 'package:watrix/widgets/custom_progress_indicator.dart';
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

  bool isDialogShowing = false;

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
        Observer(
          builder: (context) {
            return AnimatedCrossFade(
              duration: Duration(milliseconds: 500),
              secondCurve: Curves.decelerate,
              crossFadeState:
                  detailsStore.movie == null && detailsStore.tv == null
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
              firstChild: Container(),
              secondChild: Stack(
                key: UniqueKey(),
                children: [
                  _buildFading(
                    ScreenBackgroundImage(
                      image: Utils.getBackdropUrl(
                          detailsStore.baseModel.backdropPath ?? ""),
                      child: Container(),
                    ),
                    shrinkOffset,
                    reverse: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).viewPadding.top),
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
                              _buildFading(_buildGenres(context), shrinkOffset),
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
              ),
            );
          },
        ),
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
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
          Observer(
            builder: (_) {
              detailsStore.progress;
              return _buildProgressBar(context);
            },
          )
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
          top: minExtent / 2.2,
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

  Widget _buildGenres(context) {
    if (detailsStore.genres != null) {
      List<Widget> widgets = [];
      for (var item in detailsStore.genres!) {
        widgets.add(Style.getChip(context, item.name!));
      }

      return Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: ScreenSize.getPercentOfWidth(context, 0.01),
          children: widgets,
        ),
      );
    }
    return Container();
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

  Widget _buildProgressBar(context) {
    if (detailsStore.progress == null) {
      return Container();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomProgressIndicator(
          progress: detailsStore.progress!.progress! / 100,
        ),
        Style.getVerticalSpacing(context: context),
        if (detailsStore.baseModel.type == BaseModelType.movie)
          Text(_getDurationLeft()),
      ],
    );
  }

  Widget _buildButtons(context) {
    return Observer(builder: (_) {
      if (isDialogShowing) {
        Navigator.pop(context);
        isDialogShowing = false;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedButton(
            onPressed: _onPlayPressed,
            child: Row(
              children: [
                _getPlayButton(),
                Icon(Icons.play_arrow_sharp),
              ],
            ),
            type: RoundedButtonType.filled,
          ),
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
          AnimatedCrossFade(
            duration: Duration(milliseconds: 500),
            sizeCurve: Curves.decelerate,
            firstChild: RoundedButton(
              onPressed: () => _onAddRemFavoritesClicked(context),
              type: RoundedButtonType.filled,
              child: Row(
                children: [
                  Text(Strings.addToFav),
                  Icon(Icons.favorite, size: 20),
                ],
              ),
            ),
            secondChild: RoundedButton(
              onPressed: () => _onAddRemFavoritesClicked(
                context,
                remove: true,
              ),
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
        ],
      );
    });
  }

  void _onAddRemFavoritesClicked(context, {bool remove = false}) {
    if (remove) {
      detailsStore.removeFromListCLicked(
        Provider.of<FavoritesStore>(context, listen: false),
        Provider.of<UserStore>(context, listen: false),
      );
      _showLoadingDialog(context);
      return;
    }
    detailsStore.addToListClicked(
      Provider.of<FavoritesStore>(context, listen: false),
      Provider.of<UserStore>(context, listen: false),
    );
    _showLoadingDialog(context);
  }

  void _showLoadingDialog(context) {
    Style.showLoadingDialog(context: context);
    isDialogShowing = true;
  }

  void _onPlayPressed() {
    scrollController.animateTo(
      maxExtent - minExtent,
      duration: duration,
      curve: Curves.easeIn,
    );
  }

  Text _getPlayButton() {
    if (detailsStore.progress != null) {
      return Text(_getResumeText());
    }
    if (detailsStore.showHistory != null) {
      return Text(
          "${Strings.play} S${detailsStore.showHistory!.lastWatchedSeason!} EP${detailsStore.showHistory!.lastWatched!.number}");
    }
    return Text(Strings.play);
  }

  String _getResumeText() {
    String text = Strings.resume;
    if (detailsStore.baseModel.type == BaseModelType.tv) {
      text +=
          " S${detailsStore.progress!.seasonNo!} EP${detailsStore.progress!.episodeNo!}";
    }
    return text;
  }

  String _getDurationLeft() {
    int durationPlayed = (detailsStore.movie!.runtime! *
            (detailsStore.progress!.progress! / 100))
        .toInt();
    return "${DateTimeFormatter.getTimeFromMin(detailsStore.movie!.runtime! - durationPlayed)} left";
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
