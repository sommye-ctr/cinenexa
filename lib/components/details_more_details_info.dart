import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cinenexa/screens/youtube_video_player.dart';
import 'package:cinenexa/store/details/details_store.dart';
import 'package:cinenexa/widgets/rounded_image.dart';
import 'package:youtube/youtube.dart';

import '../models/network/base_model.dart';
import '../resources/strings.dart';
import '../resources/style.dart';
import '../screens/actor_details_page.dart';
import '../screens/details_page.dart';
import '../screens/see_more_page.dart';
import '../utils/screen_size.dart';
import '../widgets/horizontal_list.dart';

class DetailsMoreDetailsInfo extends StatefulWidget {
  final DetailsStore detailsStore;
  const DetailsMoreDetailsInfo({
    Key? key,
    required this.detailsStore,
  }) : super(key: key);

  @override
  State<DetailsMoreDetailsInfo> createState() => _DetailsMoreDetailsInfoState();
}

class _DetailsMoreDetailsInfoState extends State<DetailsMoreDetailsInfo> {
  String? thumbnailHd;

  @override
  void initState() {
    super.initState();
    _fetchYtData();
  }

  @override
  Widget build(BuildContext context) {
    return _build();
  }

  void _fetchYtData() async {
    await Youtube.config(videoId: widget.detailsStore.video!.key);
    thumbnailHd = Youtube.thumbnails.hd;
    setState(() {});
  }

  Widget _build() {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildTrailer(),
        Style.getVerticalSpacing(context: context),
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
      ],
    );
  }

  Widget _buildTrailer() {
    return Observer(builder: (_) {
      if (widget.detailsStore.video != null) {
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, YoutubeVideoPlayer.routeName,
                      arguments: widget.detailsStore.video!.key);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: RoundedImage(
                        image: thumbnailHd ?? "",
                        width: ScreenSize.getPercentOfWidth(context, 0.9),
                        ratio: 16 / 9,
                      ),
                    ),
                    Icon(Icons.play_arrow,
                        size: ScreenSize.getPercentOfWidth(context, 0.2)),
                  ],
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
}
