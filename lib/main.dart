import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart' as Provider;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:watrix/models/local/favorites.dart';
import 'package:watrix/models/local/installed_extensions.dart';
import 'package:watrix/models/local/last_activities.dart';
import 'package:watrix/models/local/progress.dart';
import 'package:watrix/models/local/search_history.dart';
import 'package:watrix/models/local/show_history.dart';
import 'package:watrix/resources/scroll_modified.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/actor_details_page.dart';
import 'package:watrix/screens/details_page.dart';
import 'package:watrix/screens/forgot_pass_page.dart';
import 'package:watrix/screens/home_first_screen.dart';
import 'package:watrix/screens/intro_page.dart';
import 'package:watrix/screens/login_configure_page.dart';
import 'package:watrix/screens/login_page.dart';
import 'package:watrix/screens/register_page.dart';
import 'package:watrix/screens/settings_page.dart';
import 'package:watrix/screens/video_player_page.dart';
import 'package:watrix/screens/vlc_video_player.dart';
import 'package:watrix/screens/youtube_video_player.dart';
import 'package:watrix/store/extensions/extensions_store.dart';
import 'package:watrix/store/favorites/favorites_store.dart';
import 'package:watrix/store/user/user_store.dart';

import 'models/network/base_model.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Supabase.initialize(
    url: "https://lsmnsbwamwjgpgnbhfqf.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxzbW5zYndhbXdqZ3BnbmJoZnFmIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzAzNTAyNzIsImV4cCI6MTk4NTkyNjI3Mn0.mpkdOMhskj7ii0KRBRWjzZpnm-nVxw1rFlIJjH85hV4",
  );

  await Isar.open(
    [
      FavoritesSchema,
      SearchHistorySchema,
      ProgressSchema,
      ShowHistorySchema,
      LastActivitiesSchema,
      InstalledExtensionsSchema,
    ],
    directory: (await getApplicationSupportDirectory()).path,
  );

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(MyApp(
    savedThemeMode: savedThemeMode,
  ));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({
    Key? key,
    this.savedThemeMode,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FavoritesStore favoritesStore = FavoritesStore();
    Widget homeWidget;

    if (Supabase.instance.client.auth.currentUser == null) {
      homeWidget = IntroPage();
    } else {
      homeWidget = HomeFirstScreen();
    }
    FlutterNativeSplash.remove();

    return Provider.MultiProvider(
      providers: [
        Provider.Provider(create: (_) => favoritesStore),
        Provider.Provider(
          create: (_) => UserStore(favoritesStore: favoritesStore),
        ),
        Provider.Provider(
          create: (_) => ExtensionsStore(),
        ),
      ],
      child: AdaptiveTheme(
        light: Style.themeData,
        dark: Style.darkThemeData(context),
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (light, dark) => MaterialApp(
          title: Strings.appName,
          debugShowCheckedModeBanner: false,
          theme: light,
          darkTheme: dark,
          scrollBehavior: ScrollBehaviorModified(),
          onGenerateRoute: _handleRoutes,
          home: homeWidget,
        ),
      ),
    );
  }

  Route<dynamic>? _handleRoutes(settings) {
    switch (settings.name) {
      case DetailsPage.routeName:
        final value = settings.arguments as BaseModel;
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
        return MaterialPageRoute(
          builder: (context) => DetailsPage(baseModel: value),
          maintainState: true,
        );
      case ActorDetailsPage.routeName:
        final value = settings.arguments as BaseModel;
        return MaterialPageRoute(
          builder: (context) => ActorDetailsPage(baseModel: value),
        );
      case HomeFirstScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => HomeFirstScreen(),
        );

      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => SettingsPage(
            type: settings.arguments as int,
          ),
        );
      case RegisterPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return RegisterPage();
          },
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        );
      case IntroPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return IntroPage();
          },
        );
      case ForgotPassPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ForgotPassPage();
          },
        );
      case LoginConfigurePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LoginConfigurePage(
              showSkip: settings.arguments,
            );
          },
        );
      case YoutubeVideoPlayer.routeName:
        final value = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return YoutubeVideoPlayer(ytId: value);
          },
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
  }
}
