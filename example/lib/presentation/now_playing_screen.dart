import 'package:audio_player_package/audio_player_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingScreen extends StatefulWidget {
  static String path = "/now_playing";

  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox()
;    // return BlocBuilder<AudioBloc, AudioState>(builder: (context, state) {
    //   AudioContent? currentTrack = state.audioContent;
    //   if (currentTrack == null) {
    //     return SizedBox();
    //   }
    //   return NavigationScreen(
    //     miniPlayerType: MiniPlayerType.top,
    //     title: Text("Home Details Screen"),
    //     child: Stack(fit: StackFit.expand, children: [
    //       SingleChildScrollView(
    //         child: Padding(
    //           padding: const EdgeInsets.only(left: 20, right: 20),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: 50,
    //               ),
    //               Center(
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(8),
    //                   child: currentTrack.thumbUrl != null && currentTrack.thumbUrl!.isNotEmpty
    //                       ? Image.network(
    //                           currentTrack.thumbUrl!,
    //                           width: MediaQuery.of(context).size.width,
    //                           height: 300,
    //                           fit: BoxFit.cover,
    //                         )
    //                       : Container(
    //                           width: MediaQuery.of(context).size.width,
    //                           height: 300,
    //                           color: Colors.grey,
    //                           child: const Icon(Icons.music_note, color: Colors.white),
    //                         ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 15,
    //               ),
    //               Text(
    //                 currentTrack.contentTitle,
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 25,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //                 maxLines: 1,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //               Text(
    //                 currentTrack.artist ?? "",
    //                 style: TextStyle(
    //                   color: Colors.black.withValues(alpha: 0.8),
    //                   fontSize: 18,
    //                 ),
    //                 maxLines: 1,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //               SizedBox(
    //                 height: 15,
    //               ),
    //               AudioSpeed(),
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               AudioSeekBar(),
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Shuffle(),
    //                   PreviousButton(),
    //                   PlayPauseButton(currentTrack: currentTrack, album: state.album ?? []),
    //                   NextButton(),
    //                   Repeat(),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       AudioPlayerDraggableAlbum()
    //     ]),
    //   );
    // });
  }
}
