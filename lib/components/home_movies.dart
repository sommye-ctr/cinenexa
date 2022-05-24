import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';

import '../services/duration_type.dart';
import '../services/entity_type.dart';
import '../services/requests.dart';
import '../utils/screen_size.dart';
import '../widgets/horizontal_list.dart';

class HomeMovies extends StatefulWidget {
  final Function(BaseModel data) onItemClicked;
  const HomeMovies({Key? key, required this.onItemClicked}) : super(key: key);

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
      children: [
        HorizontalList(
          future: Requests.titlesFuture(
              Requests.trending(EntityType.movie, DurationType.day)),
          heading: "Trending Today",
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: true,
        ),
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(Requests.topRated(EntityType.movie)),
          heading: "Top Rated",
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: true,
        ),
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.movie)),
          heading: "Popular",
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: true,
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
          heading: "Trending this Week",
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: true,
        ),
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
      ],
    );
  }
}
