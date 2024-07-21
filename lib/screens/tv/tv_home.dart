import 'package:cinenexa/models/network/trakt/trakt_progress.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../components/tv/tv_feed.dart';
import '../../models/network/enums/duration_type.dart';
import '../../models/network/enums/entity_type.dart';
import '../../services/network/repository.dart';
import '../../services/network/requests.dart';
import '../../store/home/tv_home_store.dart';
import '../../store/user/user_store.dart';

class TvHome extends StatefulWidget {
  final TvHomeStore store;
  final Stream<int> clickEvents;
  const TvHome({required this.store, required this.clickEvents, Key? key})
      : super(key: key);

  @override
  State<TvHome> createState() => _TvHomeState();
}

class _TvHomeState extends State<TvHome> {
  final int TOTAL_LIST_COUNT = 4;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return TvFeed(
        clickEvents: widget.clickEvents,
        store: widget.store,
        count: TOTAL_LIST_COUNT,
        headings: [
          Strings.popularMovies,
          Strings.popularTv,
          Strings.weeklyTrendingMovies,
          Strings.weeklyTrendingTv,
        ],
        items: [
          Repository.getTitles(
            Requests.popular(EntityType.movie),
            shuffle: true,
          ),
          Repository.getTitles(
            Requests.popular(EntityType.tv),
            shuffle: true,
          ),
          Repository.getTitles(
            Requests.trending(EntityType.movie, DurationType.week),
            shuffle: true,
          ),
          Repository.getTitles(
            Requests.trending(EntityType.tv, DurationType.week),
            shuffle: true,
          ),
        ],
        progressItems: Provider.of<UserStore>(context)
            .progress
            .map((element) => element.getProgress())
            .toList(),
      );
    });
  }
}
