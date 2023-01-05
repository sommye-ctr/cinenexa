import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cinenexa/store/actor_details/actor_details_store.dart';

import '../resources/strings.dart';
import '../resources/style.dart';
import '../services/network/utils.dart';
import '../utils/date_time_formatter.dart';
import '../utils/screen_size.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/screen_background_image.dart';

class ActorDetailsHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight, minHeight;
  final ActorDetailsStore actorDetailsStore;

  late double progress;
  final Duration duration = const Duration(milliseconds: 200);

  ActorDetailsHeader({
    required this.maxHeight,
    required this.minHeight,
    required this.actorDetailsStore,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    progress = shrinkOffset / (maxExtent - minExtent);

    return Stack(
      children: [
        ScreenBackgroundImage(
          image: Utils.getPosterUrl(
            actorDetailsStore.baseModel.posterPath!,
          ),
          heightPercent: 0.65,
          child: Container(),
        ),
        Observer(
          builder: (context) {
            return AnimatedCrossFade(
              duration: Duration(milliseconds: 500),
              crossFadeState: actorDetailsStore.actor == null
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(),
              secondChild: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CustomBackButton(),
                  ),
                ),
                _buildTitle(),
                _buildMainDetailsRow(context),
                Visibility(
                  visible: progress >= 0.98 ? false : true,
                  child: _buildFading(
                    _buildBiography(context),
                    shrinkOffset,
                  ),
                ),
                _buildDownArrow(shrinkOffset),
              ]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDownArrow(shrinkOffset) {
    return _buildFading(
      Align(
        alignment: Alignment(0, 0.98),
        child: Icon(Icons.keyboard_arrow_down),
      ),
      shrinkOffset,
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: AnimatedContainer(
        duration: duration,
        alignment: AlignmentGeometry.lerp(
          Alignment(0, 0),
          Alignment(0, 0.25),
          progress,
        ),
        child: Text(
          actorDetailsStore.baseModel.title!,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMainDetailsRow(context) {
    return AnimatedContainer(
      duration: duration,
      alignment: AlignmentGeometry.lerp(
        Alignment(0, 0.16),
        Alignment(0, 0.45),
        progress,
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(Style.largeRoundEdgeRadius)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Opacity(
            opacity: 0.5,
            child: Container(
              color: Theme.of(context).cardColor,
              width: ScreenSize.getPercentOfWidth(context, 0.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMainDetailColumn(
                    Text(
                      _getPlaceOfBirth(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Strings.birthPlace,
                    context,
                  ),
                  _buildMainDetailColumn(
                    Text(
                      actorDetailsStore.baseModel.voteAverage!
                          .toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Strings.popularity,
                    context,
                  ),
                  _buildMainDetailColumn(
                    Text(
                      _getBirthday(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Strings.birthday,
                    context,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainDetailColumn(Widget top, String text, context) {
    return Container(
      height: ScreenSize.getPercentOfHeight(context, 0.08),
      padding: EdgeInsets.only(top: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          top,
          Text(text),
        ],
      ),
    );
  }

  Widget _buildBiography(context) {
    if (actorDetailsStore.actor?.biography != null) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
            vertical: ScreenSize.getPercentOfWidth(context, 0.18),
          ),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      content: Text(actorDetailsStore.actor!.biography!),
                    );
                  });
            },
            child: Text(
              actorDetailsStore.actor!.biography!,
              maxLines: 10,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildFading(Widget child, shrinkOffset) {
    return AnimatedOpacity(
      duration: duration,
      opacity: (1 - progress).clamp(0, 1),
      child: child,
    );
  }

  String _getPlaceOfBirth() {
    if (actorDetailsStore.actor == null) {
      return "";
    }
    String string = actorDetailsStore.actor!.placeOfBirth!;
    return string.substring(string.lastIndexOf(',') + 2);
  }

  String _getBirthday() {
    return (actorDetailsStore.actor == null
        ? ""
        : DateTimeFormatter.getMonthYearFromString(
            actorDetailsStore.actor!.birthday!));
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
