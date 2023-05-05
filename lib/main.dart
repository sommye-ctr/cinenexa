import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:cinenexa/screens/extension_config_page.dart';
import 'package:cinenexa/screens/extensions_page.dart';
import 'package:cinenexa/screens/list_details_page.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/analytics.dart';
import 'package:cinenexa/store/platform/platform_store.dart';
import 'package:cinenexa/store/watchlist/watchlist_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart' as Provider;
import 'package:sentry_flutter/sentry_flutter.dart';
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
import 'package:cinenexa/screens/youtube_video_player.dart';
import 'package:cinenexa/store/extensions/extensions_store.dart';
import 'package:cinenexa/store/favorites/favorites_store.dart';
import 'package:cinenexa/store/user/user_store.dart';

import 'components/mobile/settings_subtitle_setting.dart';
import 'models/local/lists.dart';
import 'models/network/base_model.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: "lib/.env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? "",
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? "",
  );

  final Amplitude amplitude = Amplitude.getInstance();
  amplitude.init(dotenv.env['AMPLITUDE_KEY'] ?? "");

  await Isar.open(
    [
      FavoritesSchema,
      SearchHistorySchema,
      ProgressSchema,
      ShowHistorySchema,
      LastActivitiesSchema,
      InstalledExtensionsSchema,
      ListsSchema,
    ],
    directory: (await getApplicationSupportDirectory()).path,
  );

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final anonStatus = await Database().getGuestSignupStatus();

  final platformStore = PlatformStore();

  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_KEY'];
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 0.7;
    },
    appRunner: () => runApp(MyApp(
      savedThemeMode: savedThemeMode,
      anonStatus: anonStatus,
      platformStore: platformStore,
    )),
  );
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final bool? anonStatus;
  final PlatformStore? platformStore;
  const MyApp({
    Key? key,
    this.savedThemeMode,
    this.anonStatus,
    this.platformStore,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FavoritesStore favoritesStore = FavoritesStore();
    WatchListStore watchListStore = WatchListStore();
    ExtensionsStore extensionsStore = ExtensionsStore();
    Widget homeWidget;

    extensionsStore.init();

    if (Supabase.instance.client.auth.currentUser != null ||
        (widget.anonStatus ?? false)) {
      homeWidget = HomeFirstScreen();
    } else {
      homeWidget = IntroPage();
    }
    FlutterNativeSplash.remove();
    Analytics().logStartup();

    return Provider.MultiProvider(
      providers: [
        Provider.Provider(create: (_) => favoritesStore),
        Provider.Provider(
          create: (_) => UserStore(
            favoritesStore: favoritesStore,
            watchListsStore: watchListStore,
          ),
        ),
        Provider.Provider(
          create: (_) => extensionsStore,
        ),
        Provider.Provider(
          create: (_) => watchListStore,
        ),
        Provider.Provider(
          create: (_) => widget.platformStore,
        ),
      ],
      child: AdaptiveTheme(
        light: Style.themeData,
        dark: Style.darkThemeData(context),
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.dark,
        builder: (light, dark) => Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
          },
          child: MaterialApp(
            title: Strings.appName,
            debugShowCheckedModeBanner: false,
            theme: light,
            darkTheme: dark,
            scrollBehavior: ScrollBehaviorModified(),
            onGenerateRoute: _handleRoutes,
            home: homeWidget,
          ),
        ),
      ),
    );
  }

  Route<dynamic>? _handleRoutes(settings) {
    switch (settings.name) {
      case DetailsPage.routeName:
        final value = settings.arguments as BaseModel;

        /*  if (!Provider.Provider.of<PlatformStore>(context, listen: false).isAndroidTv) {
          SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
        } */ //TODO MANAGE ORIENTATION

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
      case ListDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => ListDetailsPage(
            traktList: settings.arguments['list'],
            isPersonal: settings.arguments['personal'] ?? false,
          ),
        );
      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => SettingsPage(
            type: settings.arguments as int,
          ),
        );
      case ExtensionsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => ExtensionsPage(),
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
      case ExtensionConfig.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ExtensionConfig(
              json: settings.arguments['json'],
              extension: settings.arguments['extension'],
            );
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
      case SubtitleSettings.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SubtitleSettings();
          },
        );
      case VideoPlayerPage.routeName:
        final value = settings.arguments as Map;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
        return MaterialPageRoute(
          builder: (context) => VideoPlayerPage(
            extensionStream: value['stream'],
            baseModel: value['model'],
            episode: value['episode'],
            movie: value['movie'],
            season: value['season'],
            show: value['tv'],
            progress: value['progress'],
            id: value['id'],
            detailsStore: value['store'],
            showHistory: value['showHistory'],
          ),
        );
      default:
    }
    return null;
  }
}
