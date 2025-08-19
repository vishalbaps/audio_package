import 'package:audio_player_package/audio_player_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_track_bloc.dart';
import '../../bloc/seekbar_bloc.dart';

class AudioItemView extends StatelessWidget {
  const AudioItemView({
    super.key,
    required this.audioContent,
    required this.audioContentList,
    required this.audioTrackState,
    // required this.downloadState,
  });

  final AudioTrackState audioTrackState;
  final AudioContent audioContent;
  final List<AudioContent> audioContentList;

  // final DownloadState downloadState;

  @override
  Widget build(BuildContext context) {
    var isCurrent = audioTrackState.currentAudioContent?.contentId == audioContent.contentId;
    // final documentModel = DocumentModel(
    //   url: audioContent.url,
    //   title: audioContent.contentTitle,
    //   isPermenentCaching: audioContent.isPermenentCaching ?? false,
    // );
    if (isCurrent) {
      print("current ${audioContent.contentId}");
      print("state ${audioTrackState.loadingStatus}");
    }
    void playAudio() {
      if (!isCurrent) {
        BlocProvider.of<AudioTrackBloc>(context)
            .add(PlayNewAudio(album: audioContentList, playId: audioContent.contentId));
        return;
      }

      switch (audioTrackState.loadingStatus) {
        case AudioLoadingStatus.playing:
          BlocProvider.of<AudioTrackBloc>(context).add(AudioPause());
          break;
        case AudioLoadingStatus.paused:
          BlocProvider.of<AudioTrackBloc>(context).add(AudioResume());
          break;
        case AudioLoadingStatus.none:
          BlocProvider.of<AudioTrackBloc>(context)
              .add(PlayNewAudio(album: audioContentList, playId: audioContent.contentId));
          break;
        default:
          break;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.teal[300],
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                    onPressed: () {
                      // if (!isCurrent &&
                      //     (downloadState.userSettings?.audioSetting == AudioSettings.alwaysDownload ||
                      //         documentModel.isPermenentCaching) &&
                      //     !audioContent.url.isFileExist.isExist) {
                      //   context.read<DownloadBloc>().add(DownloadEventAdd(documentModel));
                      //   return;
                      // }
                      //
                      // if (!isCurrent &&
                      //     downloadState.userSettings?.audioSetting == AudioSettings.downloadWhenAsked &&
                      //     !audioContent.url.isFileExist.isExist) {
                      //   showDialog(
                      //     context: context,
                      //     builder: (ctx) => AlertDialog(
                      //       title: const Text('Alert'),
                      //       content: const Text('Would you like to download the audio or play it directly?'),
                      //       actions: [
                      //         TextButton(
                      //           onPressed: () {
                      //             Navigator.pop(ctx);
                      //             playAudio();
                      //           },
                      //           child: const Text('Play'),
                      //         ),
                      //         TextButton(
                      //           onPressed: () {
                      //             Navigator.pop(ctx);
                      //             context.read<DownloadBloc>().add(DownloadEventAdd(documentModel));
                      //           },
                      //           child: const Text('Download'),
                      //         ),
                      //       ],
                      //     ),
                      //   );
                      //   return;
                      // }

                      playAudio();
                    },
                    color: Colors.grey,
                    icon: Icon(() {
                      if (!isCurrent) {
                        return Icons.play_arrow;
                      }
                      switch (audioTrackState.loadingStatus) {
                        case AudioLoadingStatus.playing:
                          return Icons.pause;
                        case AudioLoadingStatus.loading:
                        case AudioLoadingStatus.buffering:
                          return Icons.hourglass_bottom;
                        default:
                          return Icons.play_arrow;
                      }
                    }.call()),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audioContent.contentTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 7),
                // DownloadProgressWidget(documentModel: documentModel),
              ],
            ),
            SizedBox(height: 10,),
            if (isCurrent)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BlocBuilder<SeekBarBloc, SeekBarState>(
                  builder: (context, state) {
                    print(state.playPosition);
                    return Row(
                      children: [
                        Text(
                          state.currentDuration.toHHMMSS(),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Slider(
                            value: state.playPosition,
                            padding: EdgeInsets.zero,
                            onChanged: (double value) async {
                              if (!state.isUserSeek) {
                                context.read<SeekBarBloc>().add(SeekBarUserSeekEvent(true));
                              }
                              var newCurrentDuration =
                                  Duration(seconds: (state.totalDuration.inSeconds * value).toInt());
                              context.read<SeekBarBloc>().add(SeekBarSetCurrentDurationEvent(newCurrentDuration));
                            },
                            onChangeStart: (_) {
                              context.read<SeekBarBloc>().add(SeekBarUserSeekEvent(true));
                            },
                            onChangeEnd: (value) {
                              context.read<SeekBarBloc>().add(SeekBarUserSeekEvent(false));

                              var newCurrentDuration =
                                  Duration(seconds: (state.totalDuration.inSeconds * value).ceil());
                              context.read<SeekBarBloc>().add(SeekBarSetCurrentDurationEvent(newCurrentDuration));
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          state.totalDuration.toHHMMSS(),
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
