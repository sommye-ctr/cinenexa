import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:watrix/models/network/trakt/trakt_progress.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/store/user/user_store.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/network/base_model.dart';
import '../models/network/enums/duration_type.dart';
import '../models/network/enums/entity_type.dart';
import '../resources/style.dart';
import '../services/network/repository.dart';
import '../services/network/requests.dart';
import '../services/network/utils.dart';
import '../widgets/horizontal_list.dart';
import 'movie_tile.dart';

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
        HorizontalList<BaseModel>(
          future: Repository.getTitles(
              Requests.trending(EntityType.movie, DurationType.day)),
          heading: Strings.trendingToday,
          buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
              context: context, widthPercent: 0.3),
          buildWidget: (item) => Style.getMovieTile(
            item: item,
            widhtPercent: 0.3,
            showTitle: false,
            context: context,
            onClick: widget.onItemClicked,
          ),
          height: Style.getMovieTileHeight(context: context, widthPercent: 0.3),
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
        HorizontalList<BaseModel>(
          future: Repository.getTitles(Requests.topRated(EntityType.movie)),
          heading: Strings.topRated,
          buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
              context: context, widthPercent: 0.3),
          buildWidget: (item) => Style.getMovieTile(
            item: item,
            widhtPercent: 0.3,
            showTitle: false,
            context: context,
            onClick: widget.onItemClicked,
          ),
          height: Style.getMovieTileHeight(context: context, widthPercent: 0.3),
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
        HorizontalList<BaseModel>(
          future: Repository.getTitles(Requests.popular(EntityType.movie)),
          heading: Strings.popular,
          buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
              context: context, widthPercent: 0.3),
          buildWidget: (item) => Style.getMovieTile(
            item: item,
            widhtPercent: 0.3,
            showTitle: false,
            context: context,
            onClick: widget.onItemClicked,
          ),
          height: Style.getMovieTileHeight(context: context, widthPercent: 0.3),
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
        HorizontalList<BaseModel>(
          future: Repository.getTitles(
            Requests.trending(EntityType.movie, DurationType.week),
            shuffle: true,
          ),
          heading: Strings.trendingThisWeek,
          buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
              context: context, widthPercent: 0.3),
          buildWidget: (item) => Style.getMovieTile(
            item: item,
            widhtPercent: 0.3,
            showTitle: false,
            context: context,
            onClick: widget.onItemClicked,
          ),
          height: Style.getMovieTileHeight(context: context, widthPercent: 0.3),
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
