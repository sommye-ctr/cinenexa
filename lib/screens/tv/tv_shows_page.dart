import 'package:flutter/material.dart';

import '../../components/tv/tv_feed.dart';
import '../../models/network/enums/duration_type.dart';
import '../../models/network/enums/entity_type.dart';
import '../../resources/strings.dart';
import '../../services/network/repository.dart';
import '../../services/network/requests.dart';
import '../../store/home/tv_home_store.dart';

class TvShowsPage extends StatelessWidget {
  final TvHomeStore store;
  final Stream<int> clickEvents;
  const TvShowsPage({required this.store, required this.clickEvents, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TvFeed(
      clickEvents: clickEvents,
      store: store,
      count: 4,
      headings: [
        Strings.trendingToday,
        Strings.topRated,
        Strings.popular,
        Strings.trendingThisWeek,
      ],
      items: [
        Repository.getTitles(
          Requests.trending(EntityType.tv, DurationType.day),
        ),
        Repository.getTitles(Requests.topRated(EntityType.tv)),
        Repository.getTitles(Requests.popular(EntityType.tv)),
        Repository.getTitles(
          Requests.trending(EntityType.tv, DurationType.week),
          shuffle: true,
        ),
      ],
    );
  }
}
