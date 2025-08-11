import 'package:audio_player_package/configure.dart';
import 'package:audio_player_package_example/presentation/now_playing_screen.dart';
import 'package:audio_player_package_example/router.dart';
import 'package:flutter/material.dart';
import 'package:audio_player_package/audio_player_package.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await GetIt.I.allReady();
  runApp(const MyApp());
}

final album = List.generate(10, (index) {
  final isEven = index % 2 == 0;
  final id = '${index + 1}';

  return AudioContent(
    contentId: id,
    contentTitle: isEven ? 'Epic Soundtrack' : 'Minimal Track',
    url: isEven
        ? 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'
        : 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    thumbUrl: isEven ? 'https://picsum.photos/id/237/200/200' : 'https://picsum.photos/seed/picsum/200/300',
    artist: isEven ? 'John Doe' : null,
  );
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AudioPlayerWrapper(child: MaterialApp.router(routerConfig: router));
  }
}

class HomeScreen extends StatefulWidget {
  static String path = "/home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return NavigationScreen(
      title: Text("Home Details Screen"),
      child: AudioPlayerTile(
        album: album,
        onTapView: (album, track) {
          context.push(NowPlayingScreen.path);
        },
      ),
    );
  }
}
