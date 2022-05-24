import 'package:flutter/material.dart';

import '../models/base_model.dart';
import '../services/duration_type.dart';
import '../services/entity_type.dart';
import '../services/requests.dart';
import '../utils/screen_size.dart';
import '../widgets/horizontal_list.dart';
import '../widgets/image_carousel.dart';

class HomeFeatured extends StatefulWidget {
  final Function(BaseModel data) onItemClicked;

  const HomeFeatured({Key? key, required this.onItemClicked}) : super(key: key);

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
          onPageChanged: (page, home) {},
        ),
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.movie)),
          heading: "Popular Movies",
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
        ),
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.tv)),
          heading: "Popular TV Shows",
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
        ),
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.people)),
          heading: "Popular Actors",
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
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
          heading: "Weekly Trending Movies",
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
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
          heading: "Weekly Trending TV Shows",
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: false,
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
