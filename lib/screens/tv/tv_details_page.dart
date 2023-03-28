import 'package:cinenexa/models/network/tv_episode.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/constants.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/store/details/details_store.dart';
import 'package:cinenexa/store/tv_list/tv_list_store.dart';
import 'package:cinenexa/utils/date_time_formatter.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/rounded_button.dart';
import 'package:cinenexa/widgets/screen_background_image.dart';
import 'package:cinenexa/widgets/tv_horizontal_list.dart';
import 'package:cinenexa/widgets/vote_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:glass/glass.dart';

import '../../components/tv/tv_episode_tile.dart';
import '../../models/network/base_model.dart';

class TvDetailsPage extends StatefulWidget {
  final DetailsStore detailsStore;
  const TvDetailsPage({
    required this.detailsStore,
    Key? key,
  }) : super(key: key);

  @override
  State<TvDetailsPage> createState() => _TvDetailsPageState();
}

class _TvDetailsPageState extends State<TvDetailsPage> {
  FocusNode homefocus = FocusNode();

  int yFocus = -1;
  List<TvListStore<TvEpisode>> controllers = [];
  FocusNode playFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(homefocus);
      playFocusNode.requestFocus();
      FocusScope.of(context).requestFocus(homefocus);
    });
  }

  @override
  void didChangeDependencies() {
    controllers.add(
      TvListStore(
        focusChange: (item) {},
        items: widget.detailsStore.episodes,
        isListFocused: true,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackgroundImage(
        image: Utils.getBackdropUrl(widget.detailsStore.baseModel.backdropPath!,
            hq: true),
        placeHolder:
            Utils.getBackdropUrl(widget.detailsStore.baseModel.backdropPath!),
        child: Container(
          height: ScreenSize.getPercentOfHeight(context, 1),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.black87,
                  Colors.black45,
                  Colors.black38,
                  Colors.transparent,
                  Colors.transparent
                ],
                stops: [
                  0,
                  0.3,
                  0.65,
                  0.75,
                  1
                ]),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              right: 8,
              left: 8,
              top: ScreenSize.getPercentOfHeight(context, 0.05),
              bottom: 8,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment(-0.85, -0.75),
                  child: _buildHeadingInfo(),
                ),
                _buildStreams(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleKeyBoard(RawKeyEvent event) {
    if (!(event is RawKeyDownEvent)) {
      return;
    }
    RawKeyEventDataAndroid rawKeyEventData =
        event.data as RawKeyEventDataAndroid;

    print("yfocus is $yFocus ");
    switch (rawKeyEventData.keyCode) {
      case KEY_DOWN:
        if (yFocus == -1) {
          yFocus++;
          print("changing focus $yFocus");
          controllers[yFocus].changeFocus(true);
        }
        break;
      case KEY_RIGHT:
        break;
      default:
    }
  }

  Widget _buildStreams() {
    if (widget.detailsStore.baseModel.type != BaseModelType.movie) {
      return Container();
    }
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: ScreenSize.getPercentOfHeight(context, 1),
        width: ScreenSize.getPercentOfWidth(context, 0.35),
        child: Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
          ),
          child: ListView(
            children: [],
          ),
        ).asGlass(
          clipBorderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
          frosted: false,
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        RoundedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(Strings.play),
              Icon(Icons.play_arrow_sharp),
            ],
          ),
          onPressed: () {},
          type: RoundedButtonType.filled,
          focusNode: playFocusNode,
        ),
        Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
        RoundedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(Strings.addToFav),
              Icon(Icons.favorite),
            ],
          ),
          onPressed: () {},
          type: RoundedButtonType.outlined,
        ),
        Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
        RoundedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(Strings.watchTrailer),
              Icon(Icons.movie_filter_rounded),
            ],
          ),
          onPressed: () {},
          type: RoundedButtonType.outlined,
        ),
      ],
    );
  }

  Widget _buildHeadingInfo() {
    String year = "";
    if (widget.detailsStore.baseModel.releaseDate != null)
      year =
          "(${DateTimeFormatter.getYearFromString(widget.detailsStore.baseModel.releaseDate!)})";

    return ListView(
      children: [
        UnconstrainedBox(
          alignment: Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: ScreenSize.getPercentOfWidth(context, 0.55),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Hero(
                      tag: 'tag-title',
                      child: Text(
                        "${widget.detailsStore.baseModel.title ?? ""} $year",
                        style: Style.largeHeadingStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Style.getVerticalHorizontalSpacing(context: context),
                    VoteIndicator(
                      vote: widget.detailsStore.baseModel.voteAverage ?? 0,
                    ),
                  ],
                ),
                Style.getVerticalSpacing(context: context),
                Observer(builder: (_) {
                  if (widget.detailsStore.genres == null ||
                      (widget.detailsStore.genres?.isEmpty ?? false)) {
                    return Style.getVerticalSpacing(context: context);
                  }
                  return Wrap(
                    children: List.generate(
                      widget.detailsStore.genres?.length ?? 0,
                      (index) => Style.getChip(
                        context,
                        widget.detailsStore.genres![index].name!,
                      ),
                    ),
                  );
                }),
                Style.getVerticalSpacing(context: context),
                Text(
                  widget.detailsStore.baseModel.overview ?? "",
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                Style.getVerticalSpacing(context: context),
                _buildButtons(),
              ],
            ),
          ),
        ),
        RawKeyboardListener(
          focusNode: homefocus,
          onKey: _handleKeyBoard,
          child: Column(
            children: [
              Style.getVerticalSpacing(context: context, percent: 0.04),
              if (widget.detailsStore.baseModel.type == BaseModelType.tv)
                _buildSeasonHeading(context),
              if (widget.detailsStore.baseModel.type == BaseModelType.movie)
                _buildCast(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCast() {
    return Observer(builder: (_) {
      if (widget.detailsStore.credits.isEmpty) {
        return Container();
      }
      return TvHorizontalList<BaseModel>(
        heading: "",
        height: ScreenSize.getPercentOfWidth(context, 0.05) /
            Constants.profileAspectRatio,
        widthPercentItem: 0.025,
        tvListStore: TvListStore(
          focusChange: (item) {},
          items: widget.detailsStore.credits,
        ),
        onWidgetBuild: (item) {
          return Style.getActorTile(
            context: context,
            poster: item.posterPath,
            title: item.title,
            widthPercent: 0.025,
            callback: () {},
          );
        },
      );
    });
  }

  Widget _buildSeasonHeading(context) {
    return Observer(builder: (_) {
      widget.detailsStore.chosenSeason;
      if (widget.detailsStore.tv == null) {
        return Container();
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: ScreenSize.getPercentOfHeight(context, 0.1),
            child: ListView.builder(
              itemCount: widget.detailsStore.tv!.seasons!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                bool isCurrent = widget.detailsStore.chosenSeason == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: UnconstrainedBox(
                    child: TextButton(
                      onPressed: () {
                        widget.detailsStore.onSeasonChanged(index);
                      },
                      child: Text(
                        widget.detailsStore.tv!.seasons![index].name ?? "",
                        style: TextStyle(
                          color:
                              isCurrent ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildEpisodes(),
        ],
      );
    });
  }

  Widget _buildEpisodes() {
    return Observer(builder: (_) {
      if (widget.detailsStore.episodes.isEmpty) {
        return Container();
      }
      controllers[0] = TvListStore(
        focusChange: (item) {},
        items: widget.detailsStore.episodes,
        isListFocused: true,
      );

      return TvHorizontalList<TvEpisode>(
        heading: "",
        height: ScreenSize.getPercentOfWidth(context, 0.28) /
            Constants.backdropAspectRatio,
        widthPercentItem: 0.28,
        tvListStore: controllers[0],
        onWidgetBuild: (item) {
          return Container(
            width: ScreenSize.getPercentOfWidth(context, 0.28),
            child: TvEpisodeTile(episode: item),
          );
        },
      );
    });
  }
}
