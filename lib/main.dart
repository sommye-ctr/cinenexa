import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart' as Provider;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:watrix/models/local/favorites.dart';
import 'package:watrix/models/local/last_activities.dart';
import 'package:watrix/models/local/progress.dart';
import 'package:watrix/models/local/search_history.dart';
import 'package:watrix/models/local/show_history.dart';
import 'package:watrix/resources/my_theme.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/actor_details_page.dart';
import 'package:watrix/screens/details_page.dart';
import 'package:watrix/screens/home_page.dart';
import 'package:watrix/screens/profile_page.dart';
import 'package:watrix/screens/search_page.dart';
import 'package:watrix/components/home_bottom_nav_bar.dart';
import 'package:watrix/screens/settings_page.dart';
import 'package:watrix/screens/video_player_page.dart';
import 'package:watrix/screens/vlc_video_player.dart';
import 'package:watrix/store/favorites/favorites_store.dart';
import 'package:watrix/store/user/user_store.dart';

import 'models/network/base_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://uaetifonbolamgpivtli.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVhZXRpZm9uYm9sYW1ncGl2dGxpIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjcyNDQ4NjcsImV4cCI6MTk4MjgyMDg2N30.t2N3e0eE5LobMLjYl_KEfghR8XHI0_cj0jPKedKLJ-Y",
  );

  await Isar.open(
    [
      FavoritesSchema,
      SearchHistorySchema,
      ProgressSchema,
      ShowHistorySchema,
      LastActivitiesSchema,
    ],
    directory: (await getApplicationSupportDirectory()).path,
  );

  runApp(
    Provider.ChangeNotifierProvider(
      create: (_) => MyTheme()..changeTheme(true),
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
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FavoritesStore favoritesStore = FavoritesStore();
    return Provider.MultiProvider(
      providers: [
        Provider.Provider(create: (_) => favoritesStore),
        Provider.Provider(
          create: (_) => UserStore(favoritesStore: favoritesStore),
        ),
      ],
      child: MaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: Style.themeData,
        darkTheme: Style.darkThemeData(context),
        themeMode: Provider.Provider.of<MyTheme>(context).darkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case DetailsPage.routeName:
              final value = settings.arguments as BaseModel;
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitDown,
                DeviceOrientation.portraitUp
              ]);
              return MaterialPageRoute(
                builder: (context) => DetailsPage(baseModel: value),
                maintainState: true,
              );
            case ActorDetailsPage.routeName:
              final value = settings.arguments as BaseModel;
              return MaterialPageRoute(
                builder: (context) => ActorDetailsPage(baseModel: value),
              );
            case SettingsPage.routeName:
              return MaterialPageRoute(
                builder: (context) => SettingsPage(),
              );
            case VideoPlayerPage.routeName:
              final value = settings.arguments as Map;
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight
              ]);
              return MaterialPageRoute(
                builder: (context) => VlcPlayerPage(
                  url: value['url'],
                  baseModel: value['model'],
                  episode: value['episode'],
                  movie: value['movie'],
                  season: value['season'],
                  show: value['tv'],
                  progress: value['progress'],
                  id: value['id'],
                ),
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
      ),
    );
  }
}
