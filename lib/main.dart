import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:watrix/models/local/favorites.dart';
import 'package:watrix/models/local/last_activities.dart';
import 'package:watrix/models/local/progress.dart';
import 'package:watrix/models/local/search_history.dart';
import 'package:watrix/models/local/show_history.dart';
import 'package:watrix/models/local/show_history_season.dart';
import 'package:watrix/resources/my_theme.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/actor_details_page.dart';
import 'package:watrix/screens/details_page.dart';
import 'package:watrix/screens/home_page.dart';
import 'package:watrix/screens/profile_page.dart';
import 'package:watrix/screens/search_page.dart';
import 'package:watrix/components/home_bottom_nav_bar.dart';
import 'package:watrix/store/favorites/favorites_store.dart';
import 'package:watrix/store/user/user_store.dart';

import 'models/network/base_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Isar.open(
    schemas: [
      FavoritesSchema,
      SearchHistorySchema,
      ProgressSchema,
      ShowHistorySchema,
      LastActivitiesSchema,
      ShowHistorySeasonSchema,
    ],
    directory: (await getApplicationSupportDirectory()).path,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => MyTheme(),
      child: MyApp(),
    ),
  );
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
    FavoritesStore favoritesStore = FavoritesStore();
    return MultiProvider(
      providers: [
        Provider(create: (_) => favoritesStore),
        Provider(
          create: (_) => UserStore(favoritesStore: favoritesStore),
        ),
      ],
      child: MaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: Style.themeData,
        darkTheme: Style.darkThemeData(context),
        themeMode: Provider.of<MyTheme>(context).darkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case DetailsPage.routeName:
              final value = settings.arguments as BaseModel;
              return MaterialPageRoute(
                builder: (context) => DetailsPage(baseModel: value),
              );
            case ActorDetailsPage.routeName:
              final value = settings.arguments as BaseModel;
              return MaterialPageRoute(
                builder: (context) => ActorDetailsPage(baseModel: value),
              );
            default:
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
                  child: HomeBottomNavBar((index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
