import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';

import '../models/network/base_model.dart';
import '../models/network/enums/duration_type.dart';
import '../models/network/enums/entity_type.dart';
import '../services/network/requests.dart';
import '../widgets/horizontal_list.dart';
import '../widgets/image_carousel.dart';

class HomeFeatured extends StatefulWidget {
  final Function(BaseModel data) onItemClicked;
  final Function(String future, List<BaseModel> items, String heading)?
      onSeeMoreClicked;

  const HomeFeatured({
    Key? key,
    required this.onItemClicked,
    this.onSeeMoreClicked,
  }) : super(key: key);

  @override
  State<HomeFeatured> createState() => _HomeFeaturedState();
}

class _HomeFeaturedState extends State<HomeFeatured>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        ImageCarousel(
          Requests.titlesFuture(
            Requests.trending(EntityType.all, DurationType.day),
            limit: 5,
            shuffle: true,
          ),
          onClick: widget.onItemClicked,
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList(
          future: Requests.titlesFuture(
            Requests.popular(EntityType.movie),
            shuffle: true,
          ),
          heading: Strings.popularMovies,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.popular(EntityType.movie),
                items,
                Strings.popularMovies,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList(
          future: Requests.titlesFuture(
            Requests.popular(EntityType.tv),
            shuffle: true,
          ),
          heading: Strings.popularTv,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.popular(EntityType.tv),
                items,
                Strings.popularTv,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.people)),
          heading: Strings.popularActors,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.popular(EntityType.people),
                items,
                Strings.popularActors,
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
          heading: Strings.weeklyTrendingMovies,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.trending(EntityType.movie, DurationType.week),
                items,
                Strings.weeklyTrendingMovies,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList(
          future: Requests.titlesFuture(
            Requests.trending(EntityType.tv, DurationType.week),
            shuffle: true,
          ),
          heading: Strings.weeklyTrendingTv,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.trending(EntityType.tv, DurationType.week),
                items,
                Strings.weeklyTrendingTv,
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
