import 'package:flutter/material.dart';
import 'package:watrix/screens/home_page.dart';
import 'package:watrix/screens/profile_page.dart';
import 'package:watrix/screens/search_page.dart';
import 'package:watrix/screens/wishlist_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          showSelectedLabels: false,
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
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: "Search",
              icon: Icon(Icons.search_outlined),
            ),
            BottomNavigationBarItem(
              label: "Wishlist",
              icon: Icon(Icons.favorite_outline),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person_outline),
            ),
          ],
        ),
      ),
    );
  }
}
