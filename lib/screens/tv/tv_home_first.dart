import 'package:cinenexa/resources/asset.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/store/tv_list/tv_list_store.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/rounded_button.dart';
import 'package:cinenexa/widgets/screen_background_image.dart';
import 'package:cinenexa/widgets/tv_horizontal_list.dart';
import 'package:cinenexa/widgets/vote_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:glass/glass.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../models/network/base_model.dart';
import '../../models/network/enums/duration_type.dart';
import '../../models/network/enums/entity_type.dart';
import '../../resources/custom_scroll_behavior.dart';
import '../../resources/style.dart';
import '../../services/network/repository.dart';
import '../../services/network/requests.dart';
import '../../store/home/tv_home_store.dart';
import '../../utils/date_time_formatter.dart';
import '../../utils/keycode.dart';
import '../../widgets/custom_progress_indicator.dart';

class TvHomeFirst extends StatefulWidget {
  const TvHomeFirst({Key? key}) : super(key: key);

  @override
  State<TvHomeFirst> createState() => _TvHomeFirstState();
}

class _TvHomeFirstState extends State<TvHomeFirst> {
  final double NAVIGATION_RAIL_WIDTH = 60;
  final double TILE_WIDTH_PERCENT = 0.145;
  final int TOTAL_LIST_COUNT = 4;
  final Duration animationDuration = Duration(milliseconds: 500);

  final FocusNode homeFocus = FocusNode();
  final FocusNode railFocus = FocusNode();
  final ItemScrollController homeScrollController = ItemScrollController();

  late TvHomeStore store;
  final List<TvListStore> controllers = [];
  final List<Widget> listWidgets = [];
  int yFocus = 0;

  @override
  void initState() {
    store = TvHomeStore();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(homeFocus);
      controllers[0].changeFocus(true);
      FocusScope.of(context).requestFocus(homeFocus);
    });
  }

  @override
  void didChangeDependencies() {
    _init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: RawKeyboardListener(
            focusNode: homeFocus,
            onKey: _handleKeyboardEvents,
            child: Stack(
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
                Container(
                  height: ScreenSize.getPercentOfHeight(context, 1),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.black87,
                        Colors.black45,
                        Colors.transparent,
                        Colors.transparent
                      ],
                    ),
                  ),
                ),
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
                              return AnimatedSwitcher(
                                child: _buildCurrentSelectedInfo(),
                                duration: animationDuration,
                              );
                            }),
                            Style.getVerticalSpacing(
                              context: context,
                            ),
                            ScrollConfiguration(
                              behavior: CustomScrollBehavior(),
                              child: Expanded(
                                child: ScrollablePositionedList.separated(
                                  itemBuilder: (context, index) =>
                                      listWidgets[index],
                                  separatorBuilder: (context, index) =>
                                      Style.getVerticalSpacing(
                                          context: context),
                                  itemCount: TOTAL_LIST_COUNT,
                                  itemScrollController: homeScrollController,
                                ),
                              ),
                            ),
                            Style.getVerticalSpacing(context: context),
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
      ),
    );
  }

  void _handleKeyboardEvents(RawKeyEvent event) {
    if (!(event is RawKeyDownEvent)) {
      return;
    }
    RawKeyEventDataAndroid rawKeyEventData =
        event.data as RawKeyEventDataAndroid;

    switch (rawKeyEventData.keyCode) {
      case KEY_UP:
        if (yFocus > 0) {
          controllers[yFocus].changeFocus(false);
          yFocus--;
          controllers[yFocus].changeFocus(true);
          homeScrollController.scrollTo(
            index: yFocus,
            duration: animationDuration,
          );
        }
        break;
      case KEY_DOWN:
        if (yFocus < (TOTAL_LIST_COUNT - 1)) {
          controllers[yFocus].changeFocus(false);
          yFocus++;
          controllers[yFocus].changeFocus(true);
          homeScrollController.scrollTo(
            index: yFocus,
            duration: animationDuration,
          );
        }
        break;
      case KEY_LEFT:
        if (controllers[yFocus].focusedIndex == 0) {
          railFocus.requestFocus();
          break;
        }
        controllers[yFocus].changeIndex(KEY_LEFT);
        break;
      case KEY_RIGHT:
        /* if (controllers[yFocus].focusedIndex == 0) {
          break;
        } */
        controllers[yFocus].changeIndex(KEY_RIGHT);
        break;
      default:
    }
    SystemSound.play(SystemSoundType.click);
  }

  void _init() {
    controllers.addAll([
      _createController(
        Repository.getTitles(
          Requests.popular(EntityType.movie),
          shuffle: true,
        ),
        initialFocus: true,
      ),
      _createController(
        Repository.getTitles(
          Requests.popular(EntityType.tv),
          shuffle: true,
        ),
      ),
      _createController(
        Repository.getTitles(
          Requests.trending(EntityType.movie, DurationType.week),
          shuffle: true,
        ),
      ),
      _createController(
        Repository.getTitles(
          Requests.trending(EntityType.tv, DurationType.week),
          shuffle: true,
        ),
      ),
    ]);

    listWidgets.addAll([
      TvHorizontalList(
        heading: Strings.popularMovies,
        height: Style.getMovieTileHeight(
          context: context,
          widthPercent: TILE_WIDTH_PERCENT,
        ),
        widthPercentItem: TILE_WIDTH_PERCENT,
        tvListStore: controllers[0],
      ),
      TvHorizontalList(
        heading: Strings.popularTv,
        height: Style.getMovieTileHeight(
          context: context,
          widthPercent: TILE_WIDTH_PERCENT,
        ),
        widthPercentItem: TILE_WIDTH_PERCENT,
        tvListStore: controllers[1],
      ),
      TvHorizontalList(
        heading: Strings.weeklyTrendingMovies,
        height: Style.getMovieTileHeight(
          context: context,
          widthPercent: TILE_WIDTH_PERCENT,
        ),
        widthPercentItem: TILE_WIDTH_PERCENT,
        tvListStore: controllers[2],
      ),
      TvHorizontalList(
        heading: Strings.weeklyTrendingTv,
        height: Style.getMovieTileHeight(
          context: context,
          widthPercent: TILE_WIDTH_PERCENT,
        ),
        widthPercentItem: TILE_WIDTH_PERCENT,
        tvListStore: controllers[3],
      )
    ]);
  }

  TvListStore _createController(Future<List<BaseModel>> future,
      {bool initialFocus = false}) {
    return TvListStore<BaseModel>(
      future: future,
      focusChange: (item) {
        store.changeCurrentFocused(item);
      },
    );
  }

  Widget _buildNavigationRail() {
    return Focus(
      onFocusChange: (value) {
        print(value);
      },
      focusNode: railFocus,
      skipTraversal: true,
      child: NavigationRail(
        groupAlignment: 0,
        minWidth: NAVIGATION_RAIL_WIDTH,
        backgroundColor: Colors.transparent,
        minExtendedWidth: ScreenSize.getPercentOfWidth(context, 0.15),
        onDestinationSelected: (value) {
          store.changeIndex(value);
        },
        leading: Container(
          width: 40,
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
  }

  Widget _buildCurrentSelectedInfo() {
    if (store.currentFocused == null) {
      return Container();
    }
    String year =
        "(${DateTimeFormatter.getYearFromString(store.currentFocused!.releaseDate!)})";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "${store.currentFocused?.title} $year",
                style: Style.largeHeadingStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Style.getVerticalHorizontalSpacing(context: context),
            VoteIndicator(vote: store.currentFocused?.voteAverage ?? 0),
          ],
        ),
        Style.getVerticalSpacing(context: context),
        Container(
          constraints: BoxConstraints(
            maxWidth: ScreenSize.getPercentOfWidth(context, 0.5),
          ),
          child: LayoutBuilder(
            builder: (p0, p1) {
              final span = TextSpan(
                  text: store.currentFocused?.overview,
                  style: TextStyle(color: Colors.white70));
              final tp =
                  TextPainter(text: span, textDirection: TextDirection.ltr);
              tp.layout(maxWidth: p1.maxWidth);
              final numLines = tp.computeLineMetrics().length;

              String string;

              if (numLines == 0) {
                string = "\n \n \n";
              } else if (numLines == 1) {
                string = "${span.text} \n \n";
              } else if (numLines == 2) {
                string = "${span.text} \n";
              } else {
                string = span.text ?? "\n \n \n";
              }

              return Text(
                string,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white70),
              );
            },
          ),
        ),
        Style.getVerticalSpacing(context: context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RoundedButton(
                  child: Text(Strings.play),
                  onPressed: () {},
                  type: RoundedButtonType.filled,
                ),
                Style.getVerticalHorizontalSpacing(context: context),
                RoundedButton(
                  child: Text(Strings.moreInfo),
                  onPressed: () {},
                  type: RoundedButtonType.outlined,
                ),
              ],
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
