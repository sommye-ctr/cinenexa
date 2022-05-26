import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';

import '../models/base_model.dart';
import '../services/duration_type.dart';
import '../services/entity_type.dart';
import '../services/requests.dart';
import '../utils/screen_size.dart';
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
          ),
          onClick: widget.onItemClicked,
        ),
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.movie)),
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
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.tv)),
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
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
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
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(
            Requests.trending(EntityType.movie, DurationType.week),
            skip: true,
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
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(
            Requests.trending(EntityType.tv, DurationType.week),
            skip: true,
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
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.08,
          ),
        ),
      ],
    );
  }
}
