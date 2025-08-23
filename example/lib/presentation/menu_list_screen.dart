import 'package:audio_player_package_example/presentation/seekbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'audio_component.dart';
import 'now_playing_screen.dart';

class MenuListScreen extends StatelessWidget {
  static String path = "/menu_list";

  const MenuListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Component"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Now Playing"),
            subtitle: Text("it contain all feature related music player"),
            onTap: () {
              context.push(NowPlayingScreen.path);
            },
          ),
          ListTile(
            title: Text("Seekbar"),
            subtitle: Text("Custom seekbar feature"),
            onTap: () {
              context.push(SeekbarScreen.path);
            },
          ),
          ListTile(
            title: Text("Audio Component"),
            subtitle: Text("Custom audio component"),
            onTap: () {
              context.push(AudioComponent.path);
            },
          ),
        ],
      ),
    );
  }
}
