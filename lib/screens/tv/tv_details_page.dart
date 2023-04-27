import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/store/details/details_store.dart';
import 'package:cinenexa/utils/date_time_formatter.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/custom_back_button.dart';
import 'package:cinenexa/widgets/rounded_button.dart';
import 'package:cinenexa/widgets/screen_background_image.dart';
import 'package:cinenexa/widgets/vote_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:glass/glass.dart';

import '../../components/tv/tv_info_card.dart';
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
  static const int BACK_BUTTON = -1;
  static const int PLAY_BUTTON = 0;
  static const int ADD_BUTTON = 1;
  static const int SEASON_TRAILER_BUTTON = 2;

  static const double widthPercent = 0.6;

  FocusNode homefocus = FocusNode();
  FocusNode backFocus = FocusNode();

  int xFocus = PLAY_BUTTON;
  List<RoundedButtonController> controllers = [
    RoundedButtonController(type: RoundedButtonType.filled),
    RoundedButtonController(type: RoundedButtonType.outlined),
    RoundedButtonController(type: RoundedButtonType.outlined)
  ];

  @override
  void initState() {
    super.initState();
    /*  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(homefocus);
      FocusScope.of(context).requestFocus(homefocus);
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      onKey: _handleKeyBoard,
      focusNode: homefocus,
      child: Scaffold(
        body: ScreenBackgroundImage(
          image: Utils.getBackdropUrl(
              widget.detailsStore.baseModel.backdropPath ?? "",
              hq: true),
          placeHolder: Utils.getBackdropUrl(
              widget.detailsStore.baseModel.backdropPath ?? ""),
          stops: [0, 0.35, 0.6, 0.75, 1],
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
                    0.5,
                    0.75,
                    1
                  ]),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: ScreenSize.getPercentOfHeight(context, 0.05),
                bottom: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(focusNode: backFocus),
                  SizedBox(width: 6),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          _buildHeadingInfo(),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: _buildBottomInfo(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

    switch (rawKeyEventData.keyCode) {
      case KEY_RIGHT:
        if (xFocus == SEASON_TRAILER_BUTTON) {
          return;
        }
        if (xFocus == BACK_BUTTON) {
          backFocus.unfocus();
          xFocus++;
          controllers[xFocus].changeType(RoundedButtonType.filled);
          return;
        }
        controllers[xFocus].changeType(RoundedButtonType.outlined);
        xFocus++;
        controllers[xFocus].changeType(RoundedButtonType.filled);
        break;
      case KEY_LEFT:
        if (xFocus == BACK_BUTTON) {
          return;
        }
        if (xFocus == PLAY_BUTTON) {
          backFocus.requestFocus();
          controllers[xFocus].changeType(RoundedButtonType.outlined);
          xFocus--;
          return;
        }
        controllers[xFocus].changeType(RoundedButtonType.outlined);
        xFocus--;
        controllers[xFocus].changeType(RoundedButtonType.filled);
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
        RoundedButton.controller(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(Strings.play),
              Icon(Icons.play_arrow_sharp),
            ],
          ),
          onPressed: () {},
          controller: controllers[PLAY_BUTTON],
        ),
        Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
        RoundedButton.controller(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(Strings.addToFav),
              Icon(Icons.favorite),
            ],
          ),
          onPressed: () {},
          controller: controllers[ADD_BUTTON],
        ),
        Style.getVerticalHorizontalSpacing(context: context, percent: 0.01),
        if (widget.detailsStore.baseModel.type == BaseModelType.movie)
          RoundedButton.controller(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(Strings.watchTrailer),
                Icon(Icons.movie_filter_rounded),
              ],
            ),
            onPressed: () {},
            controller: controllers[SEASON_TRAILER_BUTTON],
          ),
        if (widget.detailsStore.baseModel.type == BaseModelType.tv)
          RoundedButton.controller(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(Strings.seasons),
                SizedBox(
                  width: 2,
                ),
                Icon(Icons.tv_rounded),
              ],
            ),
            onPressed: () {},
            controller: controllers[SEASON_TRAILER_BUTTON],
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
              maxWidth: ScreenSize.getPercentOfWidth(context, widthPercent),
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
                    return SizedBox(
                      height: 20,
                    );
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
      ],
    );
  }

  Widget _buildBottomInfo() {
    return Observer(builder: (_) {
      return AnimatedCrossFade(
        firstCurve: Curves.easeIn,
        crossFadeState: widget.detailsStore.credits.isEmpty ||
                widget.detailsStore.reviewList.isEmpty
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 200),
        firstChild: Container(),
        secondChild: Container(
          height: ScreenSize.getPercentOfHeight(context, 0.3),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              _buildBottomInfoCard(
                title: Strings.cast,
                child: Text(
                  widget.detailsStore.credits
                      .map((element) => element.title)
                      .join(", "),
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              _buildBottomInfoCard(
                title: Strings.review,
                child: Text(
                  widget.detailsStore.reviewList.isEmpty
                      ? Strings.noResultsFound
                      : widget.detailsStore.reviewList.first.comment ?? "",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              if (widget.detailsStore.watchProviders.isNotEmpty)
                _buildBottomInfoCard(
                  title: Strings.availableAt,
                  child: Text(
                    widget.detailsStore.watchProviders
                        .map((element) => element.name)
                        .join(", "),
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBottomInfoCard({required String title, required Text child}) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: TvInfoCard(
                  text: Padding(
                    padding: const EdgeInsets.all(4),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
/* 
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

 */
}
