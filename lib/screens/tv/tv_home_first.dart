import 'dart:async';

import 'package:cinenexa/screens/tv/tv_movies_page.dart';
import 'package:cinenexa/screens/tv/tv_favorites.dart';
import 'package:cinenexa/screens/tv/tv_home.dart';
import 'package:cinenexa/screens/tv/tv_lists_page.dart';
import 'package:cinenexa/screens/tv/tv_profile_page.dart';
import 'package:cinenexa/screens/tv/tv_search_page.dart';
import 'package:cinenexa/screens/tv/tv_shows_page.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/tv/tv_home_rail.dart';
import '../../store/home/tv_home_store.dart';
import '../../utils/screen_size.dart';

class TvHomeFirst extends StatefulWidget {
  static const int RAIL_COUNT = 7;
  static const double CHILDREN_PADDING_TOP = 36;
  static const double CHILDREN_PADDING_RIGHT = 8;

  const TvHomeFirst({Key? key}) : super(key: key);

  @override
  State<TvHomeFirst> createState() => _TvHomeFirstState();
}

class _TvHomeFirstState extends State<TvHomeFirst> {
  late TvHomeStore store;
  final FocusNode focusNode = FocusNode();

  final List<StreamController<int>> streams = [
    StreamController(),
    StreamController(),
    StreamController(),
    StreamController(),
    StreamController(),
    StreamController(),
    StreamController()
  ];

  @override
  void initState() {
    store = TvHomeStore();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    for (var element in streams) {
      element..close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (event) {
        if (!(event is RawKeyDownEvent)) {
          return;
        }
        RawKeyEventDataAndroid rawKeyEventData =
            event.data as RawKeyEventDataAndroid;

        if (store.railFocused) {
          if (rawKeyEventData.keyCode == KEY_UP && store.tabIndex != 0) {
            store.changeIndex(store.tabIndex - 1);
            return;
          } else if (rawKeyEventData.keyCode == KEY_DOWN &&
              store.tabIndex != TvHomeFirst.RAIL_COUNT - 1) {
            store.changeIndex(store.tabIndex + 1);
            return;
          }
        }
        streams[store.tabIndex].add(rawKeyEventData.keyCode);
      },
      child: Material(
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: TvHomeRail.NAVIGATION_RAIL_WIDTH + 16,
                  ),
                  child: Observer(builder: (_) {
                    return IndexedStack(
                      index: store.tabIndex,
                      children: [
                        TvSearchPage(
                          clickEvents: streams[0].stream,
                          tvHomeStore: store,
                        ),
                        TvHome(
                          store: store,
                          clickEvents: streams[1].stream,
                        ),
                        TvMoviesPage(
                          store: store,
                          clickEvents: streams[2].stream,
                        ),
                        TvShowsPage(
                          store: store,
                          clickEvents: streams[3].stream,
                        ),
                        TvFavorites(
                          onClickEvents: streams[4].stream,
                          homeStore: store,
                        ),
                        TvListsPage(),
                        TvProfilePage(
                          homeStore: store,
                          clickEvents: streams[6].stream,
                        ),
                      ],
                    );
                  }),
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
}
