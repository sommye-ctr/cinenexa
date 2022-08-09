import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';

import '../models/network/base_model.dart';
import '../models/network/enums/duration_type.dart';
import '../models/network/enums/entity_type.dart';
import '../resources/style.dart';
import '../services/network/requests.dart';
import '../utils/screen_size.dart';
import '../widgets/horizontal_list.dart';

class HomeMovies extends StatefulWidget {
  final Function(BaseModel data) onItemClicked;
  final Function(String future, List<BaseModel> items, String heading)?
      onSeeMoreClicked;

  const HomeMovies({
    Key? key,
    required this.onItemClicked,
    this.onSeeMoreClicked,
  }) : super(key: key);

  @override
  State<HomeMovies> createState() => _HomeMoviesState();
}

class _HomeMoviesState extends State<HomeMovies>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        HorizontalList(
          future: Requests.titlesFuture(
              Requests.trending(EntityType.movie, DurationType.day)),
          heading: Strings.trendingToday,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.trending(EntityType.movie, DurationType.day),
                items,
                Strings.trendingToday,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList(
          future: Requests.titlesFuture(Requests.topRated(EntityType.movie)),
          heading: Strings.topRated,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.topRated(EntityType.movie),
                items,
                Strings.topRated,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.movie)),
          heading: Strings.popular,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.popular(EntityType.movie),
                items,
                Strings.popular,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList(
          future: Requests.titlesFuture(
            Requests.trending(EntityType.movie, DurationType.week),
            shuffle: true,
          ),
          heading: Strings.trendingThisWeek,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.trending(EntityType.movie, DurationType.week),
                items,
                Strings.trendingThisWeek,
              );
            }
          },
        ),
        Style.getVerticalSpacing(
          context: context,
          percent: 0.08,
        ),
      ],
    );
  }
}
