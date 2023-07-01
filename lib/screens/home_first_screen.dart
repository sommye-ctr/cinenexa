import 'package:cinenexa/screens/tv/tv_home_first.dart';
import 'package:cinenexa/store/platform/platform_store.dart';
import 'package:flutter/material.dart';
import 'package:cinenexa/screens/home_page.dart';
import 'package:cinenexa/screens/profile_page.dart';
import 'package:cinenexa/screens/search_page.dart';
import 'package:provider/provider.dart';

import '../components/mobile/home_bottom_nav_bar.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<PlatformStore>(context, listen: false).isAndroidTv) {
      return TvHomeFirst();
    }
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
