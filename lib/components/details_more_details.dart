import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:watrix/components/details_review_tile.dart';
import 'package:watrix/components/details_stream_tile.dart';
import 'package:watrix/models/network/trakt/trakt_show_history_season_ep.dart';
import 'package:watrix/models/network/tv_episode.dart';
import 'package:watrix/screens/video_player_page.dart';
import 'package:watrix/store/details/details_store.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/network/base_model.dart';
import '../models/network/trakt/trakt_show_history_season.dart';
import '../models/network/tv_season.dart';
import '../resources/asset.dart';
import '../resources/strings.dart';
import '../resources/style.dart';
import '../screens/actor_details_page.dart';
import '../screens/details_page.dart';
import '../screens/see_more_page.dart';
import '../utils/screen_size.dart';
import '../widgets/horizontal_list.dart';
import 'details_episode_tile.dart';

class DetailsMoreDetails extends StatefulWidget {
  final DetailsStore detailsStore;
  final double height;
  const DetailsMoreDetails({
    Key? key,
    required this.detailsStore,
    required this.height,
  }) : super(key: key);

  @override
  State<DetailsMoreDetails> createState() => _DetailsMoreDetailsState();
}

class _DetailsMoreDetailsState extends State<DetailsMoreDetails>
    with TickerProviderStateMixin {
  YoutubePlayerController? videoController;

  late TabController tabController;
  late ItemScrollController episodeController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    episodeController = ItemScrollController();
    widget.detailsStore.fetchStreams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: tabController,
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(8),
            splashBorderRadius: BorderRadius.circular(40),
            isScrollable: true,
            tabs: [
              Tab(text: "Streams"),
              Tab(text: "Other Info"),
              Tab(text: "Reviews"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _buildStreams(),
                _buildOtherInfo(),
                _buildReviews(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreams() {
    return Observer(
      builder: (context) {
        if (widget.detailsStore.baseModel.type == BaseModelType.movie) {
          // return Text("Streams will show up here...");
          /* return ElevatedButton(
            onPressed: () {
              var ep = widget.detailsStore.chosenEpisode == null
                  ? null
                  : widget
                      .detailsStore
                      .episodes[widget.detailsStore.chosenEpisode!]
                      .episodeNumber;

              navigateToVideoPlayer(
                  ep,
                  null,
                  widget.detailsStore.progress?.progress,
                  widget.detailsStore.baseModel.id!);
            },
            child: Text("Play"),
          ); */

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Observer(builder: (_) {
                if (widget.detailsStore.isStreamLoading)
                  return CircularProgressIndicator();
                return Container();
              }),
              Expanded(
                child: MasonryGridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: widget.detailsStore.loadedStreams.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return UnconstrainedBox(
                      child: DetailsStreamTile(
                        extensionStream:
                            widget.detailsStore.loadedStreams[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            final offset = Tween(
              begin: Offset(1, 0),
              end: Offset(0, 0),
            ).animate(animation);
            return ClipRect(
              child: SlideTransition(
                position: offset,
                child: child,
              ),
            );
          },
          child: widget.detailsStore.chosenEpisode == null
              ? ListView(
                  physics: BouncingScrollPhysics(),
                  children: _buildSeasonDetails(),
                )
              : _buildEpisodeStreams(),
        );
      },
    );
  }

  void navigateToVideoPlayer(ep, int? season, double? progress, int id) async {
    await Navigator.pushNamed(
      context,
      VideoPlayerPage.routeName,
      arguments: {
        "url": "magnet:?xt=urn:btih:f762e22ad23af064979d54182336be9a1848c0cd",
        "movie": widget.detailsStore.movie,
        "tv": widget.detailsStore.tv,
        "episode": ep,
        "season": season,
        "progress": progress,
        "id": id,
        "model": widget.detailsStore.baseModel,
      },
    );
    await widget.detailsStore.fetchProgress();
  }

  Widget _buildReviews() {
    return Observer(builder: (context) {
      DetailsStore detailsStore = widget.detailsStore;
      if (detailsStore.reviewList.isEmpty &&
          detailsStore.reviews.status == FutureStatus.pending) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (detailsStore.reviewList.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${widget.detailsStore.totalReviews} Reviews",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: LazyLoadScrollView(
                onEndOfPage: widget.detailsStore.onReviewEndReached,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.detailsStore.reviewList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return UnconstrainedBox(
                      child: DetailsReviewTile(
                        review: widget.detailsStore.reviewList[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }
      return LottieBuilder.asset(
        Asset.notFound,
        repeat: true,
      );
    });
  }

  List<Widget> _buildSeasonDetails() {
    return [
      Observer(builder: (_) => _buildSeasonsHeading()),
      Style.getVerticalSpacing(context: context),
      Observer(
        builder: (context1) {
          widget.detailsStore.showHistory;

          return ScrollablePositionedList.builder(
            shrinkWrap: true,
            itemCount: widget.detailsStore.episodes.length,
            physics: ClampingScrollPhysics(),
            itemScrollController: episodeController,
            itemBuilder: _buildEpisodeTile,
          );
        },
      ),
      Style.getVerticalSpacing(context: context),
    ];
  }

  Widget _buildEpisodeTile(context, index) {
    bool? watched = false;

    Iterable<TraktShowHistorySeason>? iterable =
        widget.detailsStore.showHistory?.seasons?.where(
      (element) =>
          element.number ==
          widget.detailsStore.tv!.seasons![widget.detailsStore.chosenSeason!]
              .seasonNumber,
    );
    if (iterable != null && iterable.isNotEmpty) {
      TraktShowHistorySeason? historySeason = iterable.elementAt(0);
      Iterable<TraktShowHistorySeasonEp>? list = historySeason.episodes?.where(
          (element) =>
              element.number ==
              widget.detailsStore.episodes[index].episodeNumber);
      watched = list != null && list.isNotEmpty;
    }

    return FocusedMenuHolder(
      menuItems: _buildPopupItems(epWatched: watched, index: index),
      onPressed: () {},
      animateMenuItems: true,
      blurSize: 5,
      child: UnconstrainedBox(
        child: EpisodeTile(
          episode: widget.detailsStore.episodes[index],
          watched: watched,
          onTap: () {
            widget.detailsStore.onEpiodeClicked(index);
          },
        ),
      ),
    );
  }

  List<FocusedMenuItem> _buildPopupItems(
      {required bool epWatched, required int index}) {
    return [
      FocusedMenuItem(
        title: Text(epWatched ? Strings.markUnwatched : Strings.markWatched),
        trailingIcon: Icon(
          epWatched
              ? Icons.playlist_remove_rounded
              : Icons.playlist_add_check_rounded,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        onPressed: () {
          Style.showLoadingDialog(context: context);
          epWatched
              ? widget.detailsStore
                  .markUnwatchedClicked(epIndex: index)
                  .whenComplete(() => Navigator.pop(context))
              : widget.detailsStore
                  .markWatchedClicked(epIndex: index)
                  .whenComplete(() => Navigator.pop(context));
        },
      ),
    ];
  }

  Widget _buildEpisodeStreams() {
    DetailsStore store = widget.detailsStore;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BackButton(
              onPressed: () => store.onEpBackClicked(),
            ),
            Text(
              "${store.tv!.seasons![store.chosenSeason!].name} Episode ${store.episodes[store.chosenEpisode!].episodeNumber}",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              var ep = widget.detailsStore
                  .episodes[widget.detailsStore.chosenEpisode!].episodeNumber;

              double? progress;
              TvEpisode episode = widget
                  .detailsStore.episodes[widget.detailsStore.chosenEpisode!];

              if (widget.detailsStore.progress?.episodeNo ==
                      episode.episodeNumber &&
                  widget.detailsStore.progress?.seasonNo ==
                      widget
                          .detailsStore
                          .tv!
                          .seasons![widget.detailsStore.chosenSeason!]
                          .seasonNumber) {
                progress = widget.detailsStore.progress!.progress!;
              }
              navigateToVideoPlayer(
                  ep,
                  widget.detailsStore.tv!
                      .seasons![widget.detailsStore.chosenSeason!].seasonNumber,
                  progress,
                  episode.id);
            },
            child: Text("Play"),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherInfo() {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Observer(
          builder: (_) => _buildList(
            Strings.cast,
            context,
            widget.detailsStore.credits,
            ActorDetailsPage.routeName,
            isCast: true,
          ),
        ),
        Style.getVerticalSpacing(context: context),
        Observer(
          builder: (_) => _buildList(
            widget.detailsStore.baseModel.type == BaseModelType.movie
                ? Strings.recommendedMovies
                : Strings.recommendedTv,
            context,
            widget.detailsStore.recommended,
            DetailsPage.routeName,
          ),
        ),
        Style.getVerticalSpacing(context: context),
        _buildTrailer(),
        Style.getVerticalSpacing(context: context),
      ],
    );
  }

  Widget _buildTrailer() {
    return Observer(builder: (_) {
      if (widget.detailsStore.video != null) {
        videoController = YoutubePlayerController(
          initialVideoId: widget.detailsStore.video!.key,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            showLiveFullscreenButton: false,
          ),
        );
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.trailer,
                style: Style.headingStyle,
              ),
              Container(
                height: 4,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
                child: YoutubePlayer(
                  controller: videoController!,
                ),
              ),
            ],
          ),
        );
      }
      return Container();
    });
  }

  Widget _buildList(
    String heading,
    context,
    List<BaseModel> items,
    String route, {
    bool isCast = false,
  }) {
    if (items.isEmpty) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: HorizontalList<BaseModel>.fromInititalValues(
        items: items,
        heading: heading,
        buildPlaceHolder: () =>
            Style.getMovieTilePlaceHolder(context: context, widthPercent: 0.3),
        buildWidget: (item) {
          if (isCast) {
            return Style.getActorTile(
              context: context,
              poster: item.posterPath,
              title: item.title,
              callback: () {
                videoController?.pause();
                Navigator.pushNamed(
                  context,
                  route,
                  arguments: item,
                );
              },
            );
          }
          return Style.getMovieTile(
            item: item,
            widhtPercent: 0.3,
            showTitle: true,
            context: context,
            onClick: (item) {
              videoController?.pause();
              Navigator.pushNamed(
                context,
                route,
                arguments: item,
              );
            },
          );
        },
        height: Style.getMovieTileHeight(context: context, widthPercent: 0.3) +
            (isCast ? 0 : ScreenSize.getPercentOfHeight(context, 0.05)),
        limitItems: 10,
        onRightTrailClicked: (list) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
            ),
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.75,
                child: SeeMorePage(
                  initialItems: list,
                  heading: heading,
                  isLazyLoad: false,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSeasonsHeading() {
    if (widget.detailsStore.baseModel.type == BaseModelType.tv &&
        widget.detailsStore.tv != null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.chooseEp,
              style: Style.headingStyle,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
                border: Border.all(
                  color: Theme.of(context).highlightColor,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TvSeason>(
                  alignment: Alignment.centerLeft,
                  borderRadius:
                      BorderRadius.circular(Style.largeRoundEdgeRadius),
                  value: widget.detailsStore.tv!
                      .seasons![widget.detailsStore.chosenSeason!],
                  menuMaxHeight: ScreenSize.getPercentOfHeight(context, 0.25),
                  items: widget.detailsStore.tv!.seasons!.map((e) {
                    return DropdownMenuItem(
                      child: Text(
                        e.name!,
                      ),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (value) {
                    widget.detailsStore.onSeasonChanged(
                        widget.detailsStore.tv!.seasons!.indexOf(value!));
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }

  void disposeVideoController() {
    videoController?.dispose();
  }

  @override
  void dispose() {
    disposeVideoController();
    super.dispose();
  }
}
