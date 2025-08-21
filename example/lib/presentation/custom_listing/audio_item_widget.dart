import 'package:audio_player_package/audio_player_package.dart';
import 'package:audio_player_package_example/model/download_model.dart';
import 'package:audio_player_package_example/presentation/common/common_pop_up.dart';
import 'package:audio_player_package_example/utils/connections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/audio_track_bloc.dart';
import '../../bloc/download_bloc.dart';
import '../../bloc/seekbar_bloc.dart';
import 'download_progress_widget.dart';
import 'package:collection/collection.dart';

class AudioItemView extends StatelessWidget {
  AudioItemView({
    super.key,
    required this.audioContent,
    required this.audioContentList,
    required this.audioTrackState,
    this.isFromDownloadTile = false,
    // required this.downloadState,
  });

  final AudioTrackState audioTrackState;
  final AudioContent audioContent;
  final List<AudioContent> audioContentList;
  bool isFromDownloadTile;

  // final DownloadState downloadState;

  @override
  Widget build(BuildContext context) {
    var isCurrent = audioTrackState.currentAudioContent?.contentId == audioContent.contentId;
    final downloadModel = DownloadModel(
      audioUrl: audioContent.audioUrl,
    );
    if (isCurrent) {
      print("current ${audioContent.contentId}");
      print("state ${audioTrackState.loadingStatus}");
    }
    Future<void> playAudio() async {
      if (!isCurrent) {
        final downloadState = context.read<DownloadBloc>().state;
        final downloaded = downloadState.downloadFileList.firstWhereOrNull(
          (doc) => doc.audioUrl == audioContent.audioUrl,
        );
        final isDownloaded = downloaded != null && downloaded.downloadedAudioUrl.isNotEmpty;

        if (!isDownloaded && !(await GetIt.I<InternetConnectivity>().hasInternet())) {
          UserMessage.showSnackBarWithError(context, "You're offline. Please check your internet connection.");
          return;
        }

        final updatedAlbum = audioContentList.map((audio) {
          if (isDownloaded) {
            return audio.copyWith(
              audioUrl: downloaded.audioUrl,
              downloadedAudioUrl: downloaded.downloadedAudioUrl,
            );
          }
          return audio;
        }).toList();
        BlocProvider.of<AudioTrackBloc>(context).add(PlayNewAudio(album: updatedAlbum, playId: audioContent.contentId));
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

    return BlocListener<AudioTrackBloc, AudioTrackState>(
      listener: (context, state) {
        if (state.loadingStatus == AudioLoadingStatus.error) {
          UserMessage.showSnackBarWithError(context, state.error);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isFromDownloadTile ? Colors.red[300] : Colors.teal[300],
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
                  if (isFromDownloadTile) ...[
                    DownloadProgressWidget(
                      downloadModel: downloadModel,
                    ),
                    IconButton(
                        onPressed: () {
                          UserMessage.showSnackBarWithError(context, "User can open lyrics screen");
                        },
                        icon: Icon(
                          Icons.queue_music,
                          color: Colors.white,
                        ))
                  ]
                ],
              ),
              if (!isFromDownloadTile) ...[
                SizedBox(
                  height: 10,
                ),
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
              ]
            ],
          ),
        ),
      ),
    );
  }
}
