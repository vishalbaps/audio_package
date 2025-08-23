import 'package:audio_player_package/audio_player_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import '../bloc/audio_track_bloc.dart';
import 'menu_list_screen.dart';

class AudioComponent extends StatelessWidget {
  static String id = "audio_component";
  static String path = "${MenuListScreen.path}/$id";

  const AudioComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audio Component")),
      body: BlocBuilder<AudioTrackBloc, AudioTrackState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.currentAudioContent?.contentTitle ?? ''),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => context.read<AudioTrackBloc>().add(AudioShuffle()),
                      child: SvgPicture.asset(
                        "assets/svg/shuffle.svg",
                        package: "audio_player_package",
                        height: 25,
                        width: 25,
                        color: state.isShuffleEnabled ? Colors.black : Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () => context.read<AudioTrackBloc>().add(AudioPrevious()),
                      child: SvgPicture.asset(
                        "assets/svg/previous.svg",
                        package: "audio_player_package",
                        height: 25,
                        width: 25,
                        color: state.isPreviousAvailable ? Colors.black : Colors.grey,
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        Widget playPauseIcon;
                        switch (state.loadingStatus) {
                          case AudioLoadingStatus.playing:
                            playPauseIcon = SvgPicture.asset(
                              "assets/svg/pause.svg",
                              package: "audio_player_package",
                              height: 40,
                              width: 40,
                            );
                            break;

                          case AudioLoadingStatus.loading:
                            playPauseIcon = const SizedBox(
                              height: 40,
                              width: 40,
                              child: CupertinoActivityIndicator(),
                            );
                            break;

                          default: // paused or none
                            playPauseIcon = SvgPicture.asset(
                              "assets/svg/play.svg",
                              package: "audio_player_package",
                              height: 40,
                              width: 40,
                            );
                            break;
                        }

                        return InkWell(
                          onTap: () {
                            if (state.loadingStatus == AudioLoadingStatus.playing) {
                              context.read<AudioTrackBloc>().add(AudioPause());
                            } else if (state.loadingStatus == AudioLoadingStatus.paused) {
                              context.read<AudioTrackBloc>().add(AudioResume());
                            } else {
                              context.read<AudioTrackBloc>().add(PlayNewAudio(
                                    album: state.album!,
                                    playId: state.currentAudioContent!.contentId,
                                  ));
                            }
                          },
                          child: playPauseIcon,
                        );
                      },
                    ),
                    InkWell(
                      onTap: () => context.read<AudioTrackBloc>().add(AudioNext()),
                      child: SvgPicture.asset(
                        "assets/svg/next.svg",
                        package: "audio_player_package",
                        height: 25,
                        width: 25,
                        color: state.isNextAvailable ? Colors.black : Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () => context.read<AudioTrackBloc>().add(AudioRepeat()),
                      child: SvgPicture.asset(
                        state.loopMode == LoopMode.one ? "assets/svg/repeat_one.svg" : "assets/svg/repeat.svg",
                        package: "audio_player_package",
                        height: 25,
                        width: 25,
                        color: state.loopMode == LoopMode.off ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
