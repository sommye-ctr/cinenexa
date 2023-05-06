import 'package:cinenexa/screens/tv/tv_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/tv/tv_home_rail.dart';
import '../../store/home/tv_home_store.dart';
import '../../utils/screen_size.dart';

class TvHomeFirst extends StatefulWidget {
  static const int RAIL_COUNT = 6;
  const TvHomeFirst({Key? key}) : super(key: key);

  @override
  State<TvHomeFirst> createState() => _TvHomeFirstState();
}

class _TvHomeFirstState extends State<TvHomeFirst> {
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
              Padding(
                padding: EdgeInsets.only(
                  left: TvHomeRail.NAVIGATION_RAIL_WIDTH + 16,
                ),
                child: Observer(builder: (_) {
                  return IndexedStack(
                    index: store.tabIndex,
                    children: [
                      Container(),
                      TvHome(store: store),
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
    );
  }
}
