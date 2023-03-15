import 'package:cinenexa/resources/asset.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/rounded_button.dart';
import 'package:cinenexa/widgets/screen_background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:glass/glass.dart';
import '../../models/network/base_model.dart';
import '../../models/network/enums/duration_type.dart';
import '../../models/network/enums/entity_type.dart';
import '../../resources/style.dart';
import '../../services/network/repository.dart';
import '../../services/network/requests.dart';
import '../../store/home/tv_home_store.dart';
import '../../utils/date_time_formatter.dart';
import '../../widgets/custom_progress_indicator.dart';
import '../../widgets/horizontal_list.dart';

class TvHomeFirst extends StatefulWidget {
  const TvHomeFirst({Key? key}) : super(key: key);

  @override
  State<TvHomeFirst> createState() => _TvHomeFirstState();
}

class _TvHomeFirstState extends State<TvHomeFirst> {
  final double NAVIGATION_RAIL_WIDTH = 60;
  final double TILE_WIDTH_PERCENT = 0.25;

  late TvHomeStore store;

  @override
  void initState() {
    store = TvHomeStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Observer(builder: (_) {
                return ScreenBackgroundImage(
                  colors: _getColorStopsBackground(),
                  stops: _getStopsBackground(),
                  child: Container(),
                  image: Utils.getBackdropUrl(
                      store.currentFocused?.backdropPath ?? ""),
                );
              }),
              Row(
                children: [
                  _buildNavigationRail(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: NAVIGATION_RAIL_WIDTH,
                        top: 36,
                        right: 8,
                      ),
                      child: Column(
                        children: [
                          Observer(builder: (context) {
                            store.currentFocused;
                            return _buildCurrentSelectedInfo();
                          }),
                          Style.getVerticalSpacing(
                            context: context,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                HorizontalList<BaseModel>(
                                  future: Repository.getTitles(
                                    Requests.popular(EntityType.movie),
                                    shuffle: true,
                                  ),
                                  heading: Strings.popularMovies,
                                  buildPlaceHolder: () =>
                                      Style.getMovieTileBackdropPlaceHolder(
                                    context: context,
                                    widthPercent: TILE_WIDTH_PERCENT,
                                  ),
                                  buildWidgetWithIndex: (item, index) =>
                                      Style.getTvMovieTile(
                                    item: item,
                                    widhtPercent: TILE_WIDTH_PERCENT,
                                    showTitle: false,
                                    context: context,
                                    onClick: (baseModel) {},
                                    onFocusChange: (hasFocus) {
                                      store.changeCurrentFocused(item);
                                    },
                                  ),
                                  height: Style.getMovieTileBackdropHeight(
                                    context: context,
                                    widthPercent: TILE_WIDTH_PERCENT,
                                  ),
                                ),
                                Style.getVerticalSpacing(context: context),
                                HorizontalList<BaseModel>(
                                  future: Repository.getTitles(
                                    Requests.popular(EntityType.tv),
                                    shuffle: true,
                                  ),
                                  heading: Strings.popularTv,
                                  buildPlaceHolder: () =>
                                      Style.getMovieTileBackdropPlaceHolder(
                                    context: context,
                                    widthPercent: TILE_WIDTH_PERCENT,
                                  ),
                                  buildWidgetWithIndex: (item, index) =>
                                      Style.getTvMovieTile(
                                    item: item,
                                    widhtPercent: TILE_WIDTH_PERCENT,
                                    showTitle: false,
                                    context: context,
                                    onClick: (baseModel) {},
                                    onFocusChange: (hasFocus) {
                                      store.changeCurrentFocused(item);
                                    },
                                  ),
                                  height: Style.getMovieTileBackdropHeight(
                                    context: context,
                                    widthPercent: TILE_WIDTH_PERCENT,
                                  ),
                                ),
                                Style.getVerticalSpacing(context: context),
                                HorizontalList<BaseModel>(
                                  future: Repository.getTitles(
                                    Requests.trending(
                                        EntityType.movie, DurationType.week),
                                    shuffle: true,
                                  ),
                                  heading: Strings.weeklyTrendingMovies,
                                  buildPlaceHolder: () =>
                                      Style.getMovieTileBackdropPlaceHolder(
                                    context: context,
                                    widthPercent: TILE_WIDTH_PERCENT,
                                  ),
                                  buildWidgetWithIndex: (item, index) =>
                                      Style.getTvMovieTile(
                                    item: item,
                                    widhtPercent: TILE_WIDTH_PERCENT,
                                    showTitle: false,
                                    context: context,
                                    onClick: (baseModel) {},
                                    onFocusChange: (hasFocus) {
                                      store.changeCurrentFocused(item);
                                    },
                                  ),
                                  height: Style.getMovieTileBackdropHeight(
                                    context: context,
                                    widthPercent: TILE_WIDTH_PERCENT,
                                  ),
                                ),
                                Style.getVerticalSpacing(context: context),
                                HorizontalList<BaseModel>(
                                  future: Repository.getTitles(
                                    Requests.trending(
                                        EntityType.tv, DurationType.week),
                                    shuffle: true,
                                  ),
                                  heading: Strings.weeklyTrendingTv,
                                  buildPlaceHolder: () =>
                                      Style.getMovieTileBackdropPlaceHolder(
                                    context: context,
                                    widthPercent: TILE_WIDTH_PERCENT,
                                  ),
                                  buildWidgetWithIndex: (item, index) =>
                                      Style.getTvMovieTile(
                                    item: item,
                                    widhtPercent: TILE_WIDTH_PERCENT,
                                    showTitle: false,
                                    context: context,
                                    onClick: (baseModel) {},
                                    onFocusChange: (hasFocus) {
                                      store.changeCurrentFocused(item);
                                    },
                                  ),
                                  height: Style.getMovieTileBackdropHeight(
                                    context: context,
                                    widthPercent: TILE_WIDTH_PERCENT,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationRail() {
    return Observer(builder: (_) {
      return Focus(
        skipTraversal: true,
        onFocusChange: (value) {
          store.changeRailFocus(value);
        },
        child: NavigationRail(
          groupAlignment: 0,
          minWidth: NAVIGATION_RAIL_WIDTH,
          backgroundColor: Colors.transparent,
          extended: store.railHasFocus,
          minExtendedWidth: ScreenSize.getPercentOfWidth(context, 0.15),
          onDestinationSelected: (value) {
            store.changeIndex(value);
          },
          leading: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: store.railHasFocus
                ? ScreenSize.getPercentOfWidth(context, 0.15) * 0.4
                : 40,
            child: Image.asset(Asset.icon),
          ),
          destinations: _getNavigationTrails(),
          selectedIndex: store.tabIndex,
        ).asGlass(
          clipBorderRadius: BorderRadius.only(
            bottomRight: Radius.circular(Style.largeRoundEdgeRadius),
            topRight: Radius.circular(Style.largeRoundEdgeRadius),
          ),
        ),
      );
    });
  }

  Widget _buildCurrentSelectedInfo() {
    String year = "";
    if (store.currentFocused != null) {
      year =
          "(${DateTimeFormatter.getYearFromString(store.currentFocused!.releaseDate!)})";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "${store.currentFocused?.title} $year",
            style: Style.largeHeadingStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Style.getVerticalSpacing(context: context),
        Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getPercentOfWidth(context, 0.5),
          ),
          child: Text(
            store.currentFocused?.overview ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white70),
          ),
        ),
        Style.getVerticalSpacing(context: context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(
              child: Text(Strings.play),
              onPressed: () {},
              type: RoundedButtonType.outlined,
            ),
            Container(
              width: 200,
              child: CustomProgressIndicator(
                progress: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Color> _getColorStopsBackground() {
    return [
      Colors.black.withOpacity(0.45),
      Colors.black.withOpacity(0.65),
      Colors.black.withOpacity(0.85),
      Colors.black.withOpacity(0.9),
    ];
  }

  List<double> _getStopsBackground() {
    return [
      0.2,
      0.45,
      0.5,
      0.95,
    ];
  }

  List<NavigationRailDestination> _getNavigationTrails() {
    return [
      NavigationRailDestination(
        icon: Icon(Icons.search_rounded),
        label: Text(Strings.search),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.home_rounded),
        label: Text(Strings.home),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.movie_rounded),
        label: Text(Strings.movies),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.tv_rounded),
        label: Text(Strings.shows),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.person_rounded),
        label: Text(Strings.profile),
      ),
    ];
  }
}
