import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/home_page.dart';
import 'package:watrix/screens/profile_page.dart';
import 'package:watrix/screens/search_page.dart';
import 'package:watrix/screens/wishlist_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    WishlistPage(),
    ProfilePage(),
  ];
  int _pageIndex = 0;

  void onBottomNavChanged(int index) {
    setState(() => _pageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _pages[_pageIndex],
      ),
      extendBody: true,
      bottomNavigationBar: getNavBar(context),
    );
  }

  Widget getNavBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          elevation: 16,
          backgroundColor: Colors.blueGrey.shade100.withOpacity(0.4),
          currentIndex: _pageIndex,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(
            color: Colors.black,
            size: 36,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.brown.shade500,
            size: 36,
          ),
          onTap: onBottomNavChanged,
          items: [
            Style.getbottomNavItem(Strings.home, Icons.home_outlined),
            Style.getbottomNavItem(Strings.search, Icons.search_outlined),
            Style.getbottomNavItem(Strings.wishlist, Icons.favorite_outline),
            Style.getbottomNavItem(Strings.profile, Icons.person_outline),
          ],
        ),
      ),
    );
  }
}
