import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'now_playing_screen.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () {},
          ),

        ],
      ),
    );
  }
}
