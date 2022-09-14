import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/network/repository.dart';

import '../models/network/base_model.dart';
import '../models/network/enums/duration_type.dart';
import '../models/network/enums/entity_type.dart';
import '../models/network/trakt/trakt_progress.dart';
import '../services/constants.dart';
import '../services/network/requests.dart';
import '../services/network/utils.dart';
import '../store/user/user_store.dart';
import '../utils/screen_size.dart';
import '../widgets/horizontal_list.dart';
import '../widgets/image_carousel.dart';
import 'movie_tile.dart';

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
          Repository.getTitles(
            Requests.trending(EntityType.all, DurationType.day),
            limit: 5,
            shuffle: true,
          ),
          onClick: widget.onItemClicked,
        ),
        Style.getVerticalSpacing(context: context),
        Observer(builder: (_) {
          UserStore userStore = Provider.of<UserStore>(context);
          userStore.progress.length;
          return HorizontalList<TraktProgress>.fromInititalValues(
            items: userStore.progress,
            heading: Strings.pickupLeft,
            buildWidget: (item) {
              bool isMovie = item.type == "movie";

              return Stack(
                children: [
                  Positioned(
                    top: ScreenSize.getPercentOfWidth(context, 0.3) /
                        Constants.posterAspectRatio,
                    child: Container(
                      width: ScreenSize.getPercentOfWidth(context, 0.3),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Style.largeRoundEdgeRadius),
                        child: LinearProgressIndicator(
                          value: item.progress! / 100,
                        ),
                      ),
                    ),
                  ),
                  MovieTile(
                    image: Utils.getPosterUrl(isMovie
                        ? (item.movie?.posterPath ?? "")
                        : (item.show?.posterPath ?? "")),
                    text: isMovie
                        ? item.movie?.title ?? ""
                        : item.show?.name ?? "",
                    width: ScreenSize.getPercentOfWidth(context, 0.3),
                    showTitle: true,
                    onClick: () {
                      widget.onItemClicked(isMovie
                          ? BaseModel.fromMovie(item.movie!)
                          : BaseModel.fromTv(item.show!));
                    },
                  ),
                ],
              );
            },
            buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
                context: context, widthPercent: 0.3),
            height:
                Style.getMovieTileHeight(context: context, widthPercent: 0.3) +
                    ScreenSize.getPercentOfHeight(context, 0.05),
          );
        }),
        Style.getVerticalSpacing(context: context),
        HorizontalList<BaseModel>(
          future: Repository.getTitles(
            Requests.popular(EntityType.movie),
            shuffle: true,
          ),
          heading: Strings.popularMovies,
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
                Strings.popularMovies,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList<BaseModel>(
          future: Repository.getTitles(
            Requests.popular(EntityType.tv),
            shuffle: true,
          ),
          heading: Strings.popularTv,
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
                Requests.popular(EntityType.tv),
                items,
                Strings.popularTv,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList<BaseModel>(
          future: Repository.getTitles(Requests.popular(EntityType.people)),
          heading: Strings.popularActors,
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
                Requests.popular(EntityType.people),
                items,
                Strings.popularActors,
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
          heading: Strings.weeklyTrendingMovies,
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
                Strings.weeklyTrendingMovies,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList<BaseModel>(
          future: Repository.getTitles(
            Requests.trending(EntityType.tv, DurationType.week),
            shuffle: true,
          ),
          heading: Strings.weeklyTrendingTv,
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
