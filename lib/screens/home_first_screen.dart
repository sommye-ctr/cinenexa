import 'package:cinenexa/screens/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:cinenexa/screens/extensions_page.dart';
import 'package:cinenexa/screens/home_page.dart';
import 'package:cinenexa/screens/profile_page.dart';
import 'package:cinenexa/screens/search_page.dart';
import 'package:flutter/services.dart';

import '../components/home_bottom_nav_bar.dart';

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
                  HomePage(
                    onBack: () async {
                      await Future.delayed(Duration(milliseconds: 500));
                      _changeBottomNavIndex(1);
                    },
                  ),
                  WatchListPage(),
                  SearchPage(
                    onBack: ({index}) async {
                      if (_pageIndex != 0) {
                        await Future.delayed(Duration(milliseconds: 500));
                        _changeBottomNavIndex(index ?? 0);
                        return;
                      }
                      SystemNavigator.pop();
                    },
                  ),
                  ProfilePage(
                    onBack: () {
                      _changeBottomNavIndex(0);
                    },
                  ),
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

  void _changeBottomNavIndex(int index) {
    setState(() {
      _pageIndex = index;
      (bottomNavigationKey.currentWidget as BottomNavigationBar).onTap!(index);
    });
  }
}
