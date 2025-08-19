import 'package:audio_player_package_example/main.dart';
import 'package:audio_player_package_example/presentation/custom_listing/custom_listing_screen.dart';
import 'package:audio_player_package_example/presentation/now_playing_screen.dart';
import 'package:audio_player_package_example/presentation/root_screen.dart';
import 'package:go_router/go_router.dart';

import '../transition.dart';

var router = GoRouter(
  initialLocation: HomeScreen.path,
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return RootScreen(child: child);
      },
      routes: [
        GoRoute(
            path: HomeScreen.path,
            pageBuilder: (context, state) => buildCustomTransitionPage(child: const HomeScreen())),
        GoRoute(
            path: DefaultListingScreen.path,
            pageBuilder: (context, state) => buildCustomTransitionPage(child: const DefaultListingScreen())),
        GoRoute(
            path: CustomListingScreen.path,
            pageBuilder: (context, state) => buildCustomTransitionPage(child: const CustomListingScreen())),
        GoRoute(
            path: NowPlayingScreen.path,
            pageBuilder: (context, state) => buildCustomTransitionPage(child: const NowPlayingScreen())),
      ],
    ),
  ],
);
