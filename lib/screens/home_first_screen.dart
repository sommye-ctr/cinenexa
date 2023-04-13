import 'package:flutter/material.dart';
import 'package:cinenexa/screens/home_page.dart';
import 'package:cinenexa/screens/profile_page.dart';
import 'package:cinenexa/screens/search_page.dart';

import '../components/home_bottom_nav_bar.dart';
import 'favourites_page.dart';

class HomeFirstScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeFirstScreen({Key? key}) : super(key: key);

  @override
  State<HomeFirstScreen> createState() => _HomeFirstScreenState();
}

class _HomeFirstScreenState extends State<HomeFirstScreen> {
  GlobalKey bottomNavigationKey = GlobalKey();
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              IndexedStack(
                index: _pageIndex,
                children: [
                  HomePage(),
                  FavoritesPage(),
                  SearchPage(),
                  ProfilePage(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: HomeBottomNavBar((index) {
                  setState(() {
                    _pageIndex = index;
                  });
                }, bottomNavigationKey: bottomNavigationKey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
