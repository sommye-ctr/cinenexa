import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int index) onChanged;
  const BottomNavBar(this.onChanged, {Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Opacity(
            opacity: 0.5,
            child: BottomNavigationBar(
              elevation: 16,
              backgroundColor: Colors.blueGrey.shade100,
              currentIndex: _pageIndex,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              selectedIconTheme: IconThemeData(
                color: Colors.black,
                size: 24,
              ),
              unselectedIconTheme: IconThemeData(
                color: Colors.brown.shade500,
                size: 24,
              ),
              onTap: onBottomNavChanged,
              items: [
                Style.getbottomNavItem(Strings.home, Icons.home_outlined),
                Style.getbottomNavItem(Strings.search, Icons.search_outlined),
                Style.getbottomNavItem(
                    Strings.wishlist, Icons.favorite_outline),
                Style.getbottomNavItem(Strings.profile, Icons.person_outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
