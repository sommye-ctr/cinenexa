import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:watrix/screens/extensions_page.dart';
import 'package:watrix/screens/home_page.dart';
import 'package:watrix/screens/profile_page.dart';
import 'package:watrix/screens/search_page.dart';

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
                  HomePage(),
                  ExtensionsPage(),
                  SearchPage(
                    onBack: () {
                      setState(() {
                        _pageIndex = 0;
                        (bottomNavigationKey.currentWidget
                                as BottomNavigationBar)
                            .onTap!(0);
                      });
                    },
                  ),
                  ProfilePage(
                    onBack: () {
                      setState(() {
                        _pageIndex = 0;
                        (bottomNavigationKey.currentWidget
                                as BottomNavigationBar)
                            .onTap!(0);
                      });
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
}
