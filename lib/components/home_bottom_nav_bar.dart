import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';

class HomeBottomNavBar extends StatefulWidget {
  static const double bottomNavHeight = 56;
  static const double bottomNavPadding = 8;

  final Function(int index) onChanged;
  final Key? bottomNavigationKey;
  const HomeBottomNavBar(
    this.onChanged, {
    Key? key,
    this.bottomNavigationKey,
  }) : super(key: key);

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  int _pageIndex = 0;

  void onBottomNavChanged(int index) {
    setState(() => _pageIndex = index);
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Style.largeRoundEdgeRadius),
            topRight: Radius.circular(Style.largeRoundEdgeRadius),
            bottomLeft: Radius.circular(Style.largeRoundEdgeRadius),
            bottomRight: Radius.circular(Style.largeRoundEdgeRadius)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Opacity(
            opacity: 0.5,
            child: BottomNavigationBar(
              key: widget.bottomNavigationKey,
              elevation: 16,
              backgroundColor: Colors.blueGrey.shade100,
              currentIndex: _pageIndex,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.shifting,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).focusColor,
              selectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
              ),
              unselectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onTap: onBottomNavChanged,
              items: [
                Style.getbottomNavItem(Strings.home, Icons.home_rounded),
                Style.getbottomNavItem(
                    Strings.extensions, Icons.extension_rounded),
                Style.getbottomNavItem(Strings.search, Icons.search_rounded),
                Style.getbottomNavItem(Strings.profile, Icons.person_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
