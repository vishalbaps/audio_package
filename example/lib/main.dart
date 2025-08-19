import 'package:audio_player_package/audio_player_package.dart';
import 'package:audio_player_package/src/models/audio_notification_settings.dart';
import 'package:audio_player_package_example/bloc/audio_track_bloc.dart';
import 'package:audio_player_package_example/bloc/seekbar_bloc.dart';
import 'package:audio_player_package_example/presentation/custom_listing/custom_listing_screen.dart';
import 'package:audio_player_package_example/presentation/now_playing_screen.dart';
import 'package:audio_player_package_example/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //need to implement from library package
  await AudioPlayerConfig.init(
    audioNotificationSettings: AudioNotificationSettings(
        androidNotificationChannelId: "my_channel_id",
        androidNotificationChannelName: "My Channel Name",
        androidNotificationIcon: 'mipmap/ic_launcher'),
  );
  runApp(const MyApp());
}

final album = List.generate(10, (index) {
  final isEven = index % 2 == 0;
  final id = '${index + 1}';

  return AudioContent(
    contentId: id,
    contentTitle: isEven ? 'Epic Soundtrack' : 'Minimal Track',
    audioUrl: isEven
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
    return AudioPlayerWrapper(
        child: MultiBlocProvider(
      providers: [
        BlocProvider<AudioTrackBloc>(create: (context) => AudioTrackBloc(AudioTrackManager())),
        BlocProvider<SeekBarBloc>(create: (context) => SeekBarBloc(SliderSeekManager())),
      ],
      child: MaterialApp.router(routerConfig: router),
    ));
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Details Screen"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Default Listing"),
            subtitle: Text("Package provided screen"),
            onTap: () {
              context.push(DefaultListingScreen.path);
            },
          ),
          ListTile(
            title: Text("Custom Listing"),
            subtitle: Text("Custom made listing with needed features"),
            onTap: () {
              context.push(CustomListingScreen.path);
            },
          ),
          ListTile(
            title: Text("Custom Listing with download feature"),
            subtitle: Text("download is not part of our package for now. any thoughts? for it "),
            onTap: () {
              context.push(CustomListingScreen.path);
            },
          ),
        ],
      ),
    );
  }
}

class DefaultListingScreen extends StatefulWidget {
  static String path = "/default-listing";

  const DefaultListingScreen({super.key});

  @override
  State<DefaultListingScreen> createState() => _DefaultListingScreenState();
}

class _DefaultListingScreenState extends State<DefaultListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Details Screen"),
      ),
      body: NavigationScreen(
        child: AudioPlayerDefaultListing(
          album: album,
          onTapView: (album, track) {
            context.push(NowPlayingScreen.path);
          },
        ),
      ),
    );
  }
}
