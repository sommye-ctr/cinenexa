import 'package:cinenexa/store/home/tv_home_store.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../resources/asset.dart';
import '../../resources/strings.dart';
import '../../utils/screen_size.dart';
import '../../widgets/glassy_container.dart';

class TvHomeRail extends StatefulWidget {
  static double NAVIGATION_RAIL_WIDTH = 60;

  final TvHomeStore store;
  const TvHomeRail({required this.store, Key? key}) : super(key: key);

  @override
  State<TvHomeRail> createState() => _TvHomeRailState();
}

class _TvHomeRailState extends State<TvHomeRail> {
  final FocusNode focusNode = FocusNode();

  int yFocus = 1;

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: Observer(builder: (_) {
        widget.store.railFocused;
        return GlassyContainer(
          child: NavigationRail(
            groupAlignment: 0,
            minWidth: TvHomeRail.NAVIGATION_RAIL_WIDTH,
            backgroundColor: Colors.transparent,
            minExtendedWidth: ScreenSize.getPercentOfWidth(context, 0.15),
            leading: Container(
              width: 40,
              child: Image.asset(Asset.icon),
            ),
            destinations: _getNavigationTrails(),
            selectedIndex: widget.store.tabIndex,
            extended: widget.store.railFocused,
            useIndicator: false,
          ),
        );
      }),
    );
  }

  // CHANGE RAIL_COUNT IN HOME FOR NAVIGATION BEFORE CHANGING ANY PROPERTY HERE
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
        icon: Icon(Icons.favorite_rounded),
        label: Text(Strings.favorites),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.list_rounded),
        label: Text("Lists"),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.person_rounded),
        label: Text(Strings.profile),
      )
    ];
  }
}
