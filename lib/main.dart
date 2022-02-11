import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/home_page.dart';
import 'package:watrix/screens/profile_page.dart';
import 'package:watrix/screens/search_page.dart';
import 'package:watrix/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: Style.themeData,
      darkTheme: Style.darkThemeData(context),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Stack(
            children: [
              IndexedStack(
                index: _pageIndex,
                children: [
                  HomePage(),
                  SearchPage(),
                  ProfilePage(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavBar((index) {
                  setState(() {
                    _pageIndex = index;
                  });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
