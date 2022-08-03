import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watrix/components/details_page_header.dart';
import 'package:watrix/components/episode_tile.dart';

import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/actor_details_page.dart';
import 'package:watrix/screens/see_more_page.dart';
import 'package:watrix/store/details/details_store.dart';
import 'package:watrix/widgets/horizontal_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/network/base_model.dart';
import '../models/network/tv_season.dart';
import '../utils/screen_size.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = "/details";

  final BaseModel baseModel;

  DetailsPage({
    Key? key,
    required this.baseModel,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final DetailsStore detailsStore;
  final _controller = ScrollController();
  double get maxHeight => ScreenSize.getPercentOfHeight(context, 1);

  double get minHeight => MediaQuery.of(context).padding.top + kToolbarHeight;

  @override
  void initState() {
    detailsStore = DetailsStore(baseModel: widget.baseModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          _snapBehaviour();
          return false;
        },
        child: CustomScrollView(
          controller: _controller,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: DetailsPageHeader(
                maxHeight: maxHeight,
                minHeight: minHeight,
                detailsStore: detailsStore,
                scrollController: _controller,
              ),
            ),
            SliverToBoxAdapter(
                child: Style.getVerticalSpacing(context: context)),
            SliverToBoxAdapter(
              child: Observer(builder: (_) => _buildGenres(context)),
            ),
            SliverToBoxAdapter(
                child: Style.getVerticalSpacing(context: context)),
            SliverToBoxAdapter(
              child: Observer(
                builder: (_) => _buildList(
                  Strings.cast,
                  context,
                  detailsStore.credits,
                  ActorDetailsPage.routeName,
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Style.getVerticalSpacing(context: context)),
            SliverToBoxAdapter(
              child: Observer(
                builder: (_) => _buildList(
                  detailsStore.baseModel.type == BaseModelType.movie
                      ? Strings.recommendedMovies
                      : Strings.recommendedTv,
                  context,
                  detailsStore.recommended,
                  DetailsPage.routeName,
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Style.getVerticalSpacing(context: context)),
            SliverToBoxAdapter(
              child: _buildTrailer(),
            ),
            SliverToBoxAdapter(
                child: Style.getVerticalSpacing(context: context)),
            SliverToBoxAdapter(
              child: Observer(builder: (_) => _buildSeasonsHeading()),
            ),
            SliverToBoxAdapter(
                child: Style.getVerticalSpacing(context: context)),
            Observer(
              builder: (_) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return EpisodeTile(
                      episode: detailsStore.episodes[index],
                    );
                  },
                  childCount: detailsStore.episodes.length,
                ),
              ),
            ),
            if (detailsStore.baseModel.type == BaseModelType.movie)
              SliverFillRemaining(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailer() {
    return Observer(builder: (_) {
      if (detailsStore.video != null) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trailer",
                style: Style.headingStyle,
              ),
              Container(
                height: 4,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
                child: YoutubePlayer(
                    controller: YoutubePlayerController(
                  initialVideoId: detailsStore.video!.key,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                  ),
                )),
              ),
            ],
          ),
        );
      }
      return Container();
    });
  }

  Widget _buildGenres(context) {
    if (detailsStore.genres != null) {
      List<Widget> widgets = [];
      for (var item in detailsStore.genres!) {
        widgets.add(Padding(
          padding: EdgeInsets.only(
            right: ScreenSize.getPercentOfWidth(context, 0.01),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
              color: Colors.grey.withOpacity(0.4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                "${item.name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ));
      }

      return Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: ScreenSize.getPercentOfWidth(context, 0.01),
          children: widgets,
        ),
      );
    }
    return Container();
  }

  Widget _buildList(
      String heading, context, List<BaseModel> items, String route) {
    if (items.isNotEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: HorizontalList.fromInititalValues(
          items: items,
          heading: heading,
          onClick: (item) {
            Navigator.pushNamed(
              context,
              route,
              arguments: item,
            );
          },
          itemWidthPercent: 0.3,
          showTitle: true,
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
    return Container();
  }

  Widget _buildSeasonsHeading() {
    if (detailsStore.baseModel.type == BaseModelType.tv &&
        detailsStore.tv != null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Episodes",
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
                  value: detailsStore.chosenSeason,
                  menuMaxHeight: ScreenSize.getPercentOfHeight(context, 0.25),
                  items: detailsStore.tv!.seasons!.map((e) {
                    return DropdownMenuItem(
                      child: Text(
                        e.name,
                      ),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (value) {
                    detailsStore.onSeasonChanged(value!);
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

  void _snapBehaviour() {
    final double distance = maxHeight - minHeight;
    if (_controller.offset > 0 && _controller.offset < distance) {
      final double snapOffset =
          _controller.offset / distance > 0.4 ? distance : 0;

      Future.microtask(() => _controller.animateTo(snapOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    }
  }
}
