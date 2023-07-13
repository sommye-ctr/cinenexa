import 'package:cinenexa/components/tv/tv_home_selected_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../models/network/base_model.dart';
import '../../resources/custom_scroll_behavior.dart';
import '../../resources/style.dart';
import '../../screens/details_page.dart';
import '../../screens/tv/tv_home_first.dart';
import '../../services/network/utils.dart';
import '../../store/home/tv_home_store.dart';
import '../../store/tv_list/tv_list_store.dart';
import '../../utils/keycode.dart';
import '../../utils/screen_size.dart';
import '../../widgets/screen_background_image.dart';
import '../../widgets/tv_horizontal_list.dart';

class TvFeed extends StatefulWidget {
  final TvHomeStore store;
  final Stream<int> clickEvents;

  final List<Future<List<BaseModel>>> items;
  final List<String> headings;
  final int count;
  const TvFeed({
    required this.store,
    required this.clickEvents,
    required this.items,
    required this.headings,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  State<TvFeed> createState() => _TvFeedState();
}

class _TvFeedState extends State<TvFeed> {
  final Duration animationDuration = Duration(milliseconds: 500);

  final ItemScrollController homeScrollController = ItemScrollController();

  final List<TvListStore> controllers = [];
  final List<Widget> listWidgets = [];
  int yFocus = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controllers[0].changeFocus(true);
    });
    widget.clickEvents.listen(_handleKeyboardEvents);
  }

  @override
  void didChangeDependencies() {
    _init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Observer(builder: (_) {
          return ScreenBackgroundImage(
            colors: _getColorStopsBackground(),
            stops: _getStopsBackground(),
            child: Container(),
            image: Utils.getBackdropUrl(
              widget.store.currentFocused?.backdropPath ?? "",
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
            top: TvHomeFirst.CHILDREN_PADDING_TOP,
            right: TvHomeFirst.CHILDREN_PADDING_RIGHT,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TvHomeSelectedTile(store: widget.store),
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
                    itemCount: widget.count,
                    itemScrollController: homeScrollController,
                  ),
                ),
              ),
              Style.getVerticalSpacing(context: context),
            ],
          ),
        ),
      ],
    );
  }

  void _init() {
    for (int i = 0; i < widget.items.length; i++) {
      controllers.add(_createController(widget.items[i], initialFocus: i == 0));
    }

    for (int i = 0; i < widget.headings.length; i++) {
      listWidgets.add(TvHorizontalList(
        heading: widget.headings[i],
        height: Style.getMovieTileHeight(
          context: context,
          widthPercent: Style.tvTileWidth,
        ),
        widthPercentItem: Style.tvTileWidth,
        tvListStore: controllers[i],
      ));
    }
  }

  TvListStore _createController(Future<List<BaseModel>> future,
      {bool initialFocus = false}) {
    return TvListStore<BaseModel>(
      future: future,
      focusChange: (item) {
        widget.store.changeCurrentFocused(item);
      },
    );
  }

  void _handleKeyboardEvents(int keyCode) {
    switch (keyCode) {
      case KEY_UP:
        if (yFocus > 0 && !widget.store.railFocused) {
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
        if (yFocus < (widget.count - 1) && !widget.store.railFocused) {
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
        if (controllers[yFocus].focusedIndex == 0 &&
            !widget.store.railFocused) {
          widget.store.changeRailFocused(true);
          break;
        }
        controllers[yFocus].changeIndex(KEY_LEFT);
        break;
      case KEY_RIGHT:
        if (controllers[yFocus].focusedIndex == 0 && widget.store.railFocused) {
          widget.store.changeRailFocused(false);
          break;
        }
        controllers[yFocus].changeIndex(KEY_RIGHT);
        break;
      case KEY_CENTER:
        if (widget.store.currentFocused != null) {
          Navigator.pushNamed(
            context,
            DetailsPage.routeName,
            arguments: widget.store.currentFocused,
          );
        }
        break;
      default:
    }
    SystemSound.play(SystemSoundType.click);
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
