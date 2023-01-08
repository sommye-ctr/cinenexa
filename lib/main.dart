import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart' as Provider;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cinenexa/models/local/favorites.dart';
import 'package:cinenexa/models/local/installed_extensions.dart';
import 'package:cinenexa/models/local/last_activities.dart';
import 'package:cinenexa/models/local/progress.dart';
import 'package:cinenexa/models/local/search_history.dart';
import 'package:cinenexa/models/local/show_history.dart';
import 'package:cinenexa/resources/scroll_modified.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/actor_details_page.dart';
import 'package:cinenexa/screens/details_page.dart';
import 'package:cinenexa/screens/forgot_pass_page.dart';
import 'package:cinenexa/screens/home_first_screen.dart';
import 'package:cinenexa/screens/intro_page.dart';
import 'package:cinenexa/screens/login_configure_page.dart';
import 'package:cinenexa/screens/login_page.dart';
import 'package:cinenexa/screens/register_page.dart';
import 'package:cinenexa/screens/settings_page.dart';
import 'package:cinenexa/screens/video_player_page.dart';
import 'package:cinenexa/screens/vlc_video_player.dart';
import 'package:cinenexa/screens/youtube_video_player.dart';
import 'package:cinenexa/store/extensions/extensions_store.dart';
import 'package:cinenexa/store/favorites/favorites_store.dart';
import 'package:cinenexa/store/user/user_store.dart';

import 'models/network/base_model.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: "lib/.env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? "",
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? "",
  );

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
            extensionStream: value['stream'],
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
