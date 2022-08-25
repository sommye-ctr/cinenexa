import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watrix/store/details/details_store.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/network/base_model.dart';
import '../models/network/tv_season.dart';
import '../resources/strings.dart';
import '../resources/style.dart';
import '../screens/actor_details_page.dart';
import '../screens/details_page.dart';
import '../screens/see_more_page.dart';
import '../utils/screen_size.dart';
import '../widgets/horizontal_list.dart';
import 'episode_tile.dart';

class MoreDetails extends StatefulWidget {
  final DetailsStore detailsStore;
  final double height;
  const MoreDetails({
    Key? key,
    required this.detailsStore,
    required this.height,
  }) : super(key: key);

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  YoutubePlayerController? videoController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      height: widget.height,
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _buildGenres(context),
          Style.getVerticalSpacing(context: context),
          Observer(
            builder: (_) => _buildList(
              Strings.cast,
              context,
              widget.detailsStore.credits,
              ActorDetailsPage.routeName,
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
          Observer(builder: (_) => _buildSeasonsHeading()),
          Style.getVerticalSpacing(context: context),
          Observer(
            builder: (context1) => ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: widget.detailsStore.episodes.length,
              itemBuilder: (context, index) {
                return EpisodeTile(
                  episode: widget.detailsStore.episodes[index],
                );
              },
            ),
          ),
          Style.getVerticalSpacing(context: context),
        ],
      ),
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

  Widget _buildGenres(context) {
    return Observer(
      builder: (context) {
        if (widget.detailsStore.genres != null) {
          List<Widget> widgets = [];
          for (var item in widget.detailsStore.genres!) {
            widgets.add(Padding(
              padding: EdgeInsets.only(
                right: ScreenSize.getPercentOfWidth(context, 0.01),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Style.smallRoundEdgeRadius),
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
      },
    );
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
            videoController?.pause();
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
    if (widget.detailsStore.baseModel.type == BaseModelType.tv &&
        widget.detailsStore.tv != null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.episodes,
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
                  value: widget.detailsStore.chosenSeason,
                  menuMaxHeight: ScreenSize.getPercentOfHeight(context, 0.25),
                  items: widget.detailsStore.tv!.seasons!.map((e) {
                    return DropdownMenuItem(
                      child: Text(
                        e.name,
                      ),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (value) {
                    widget.detailsStore.onSeasonChanged(value!);
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
