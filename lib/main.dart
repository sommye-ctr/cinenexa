import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/details_page.dart';
import 'package:watrix/screens/home_page.dart';
import 'package:watrix/screens/profile_page.dart';
import 'package:watrix/screens/search_page.dart';
import 'package:watrix/components/bottom_nav_bar.dart';

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
      onGenerateRoute: (settings) {
        if (settings.name == DetailsPage.routeName) {
          final value = settings.arguments as BaseModel;
          return MaterialPageRoute(
            builder: (context) => DetailsPage(baseModel: value),
          );
        }
        return null;
      },
      home: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
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
