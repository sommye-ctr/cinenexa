import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/screens/details_page.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/store/tv_list/tv_list_store.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/screen_background_image.dart';
import 'package:cinenexa/widgets/tv_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../components/tv/tv_home_rail.dart';
import '../../components/tv/tv_home_selected_title.dart';
import '../../models/network/base_model.dart';
import '../../models/network/enums/duration_type.dart';
import '../../models/network/enums/entity_type.dart';
import '../../resources/custom_scroll_behavior.dart';
import '../../resources/style.dart';
import '../../services/network/repository.dart';
import '../../services/network/requests.dart';
import '../../store/home/tv_home_store.dart';
import '../../utils/keycode.dart';

class TvHomeFirst extends StatefulWidget {
  const TvHomeFirst({Key? key}) : super(key: key);

  @override
  State<TvHomeFirst> createState() => _TvHomeFirstState();
}

class _TvHomeFirstState extends State<TvHomeFirst> {
  final double TILE_WIDTH_PERCENT = 0.145;
  final int TOTAL_LIST_COUNT = 4;
  final int RAIL_COUNT = 6;
  final Duration animationDuration = Duration(milliseconds: 500);

  final FocusNode homeFocus = FocusNode();
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
                      store.currentFocused?.backdropPath ?? "",
                      hq: true,
                    ),
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
                Padding(
                  padding: EdgeInsets.only(
                    left: TvHomeRail.NAVIGATION_RAIL_WIDTH + 16,
                    top: 36,
                    right: 8,
                  ),
                  child: Column(
                    children: [
                      TvHomeSelectedTile(store: store),
                      Style.getVerticalSpacing(
                        context: context,
                        percent: 0.05,
                      ),
                      ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: Expanded(
                          child: ScrollablePositionedList.separated(
                            itemBuilder: (context, index) => listWidgets[index],
                            separatorBuilder: (context, index) =>
                                Style.getVerticalSpacing(context: context),
                            itemCount: TOTAL_LIST_COUNT,
                            itemScrollController: homeScrollController,
                          ),
                        ),
                      ),
                      Style.getVerticalSpacing(context: context),
                    ],
                  ),
                ),
                Positioned.directional(
                  textDirection: TextDirection.ltr,
                  start: 0,
                  height: ScreenSize.getPercentOfHeight(context, 1),
                  child: TvHomeRail(store: store),
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
        if (yFocus > 0 && !store.railFocused) {
          controllers[yFocus].changeFocus(false);
          yFocus--;
          controllers[yFocus].changeFocus(true);
          homeScrollController.scrollTo(
            index: yFocus,
            duration: animationDuration,
          );
        } else if (store.railFocused && store.tabIndex != 0) {
          store.changeIndex(store.tabIndex - 1);
        }
        break;
      case KEY_DOWN:
        if (yFocus < (TOTAL_LIST_COUNT - 1) && !store.railFocused) {
          controllers[yFocus].changeFocus(false);
          yFocus++;
          controllers[yFocus].changeFocus(true);
          homeScrollController.scrollTo(
            index: yFocus,
            duration: animationDuration,
          );
        } else if (store.railFocused && store.tabIndex != RAIL_COUNT - 1) {
          store.changeIndex(store.tabIndex + 1);
        }
        break;
      case KEY_LEFT:
        if (controllers[yFocus].focusedIndex == 0 && !store.railFocused) {
          store.changeRailFocused(true);
          break;
        }
        controllers[yFocus].changeIndex(KEY_LEFT);
        break;
      case KEY_RIGHT:
        if (controllers[yFocus].focusedIndex == 0 && store.railFocused) {
          store.changeRailFocused(false);
          break;
        }
        controllers[yFocus].changeIndex(KEY_RIGHT);
        break;
      case KEY_CENTER:
        if (store.currentFocused != null) {
          Navigator.pushNamed(
            context,
            DetailsPage.routeName,
            arguments: store.currentFocused,
          );
        }
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
}
