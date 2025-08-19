import 'package:audio_player_package/audio_player_package.dart';
import 'package:audio_player_package_example/bloc/audio_track_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import 'audio_item_widget.dart';

class CustomListingScreen extends StatelessWidget {
  static String path = "/custom-listing";

  const CustomListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Details Screen"),
      ),
      body: BlocBuilder<AudioTrackBloc, AudioTrackState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: album.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemBuilder: (context, index) {
                      final audioContent = album[index];
                      return AudioItemView(audioTrackState: state, audioContentList: album, audioContent: audioContent);
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
