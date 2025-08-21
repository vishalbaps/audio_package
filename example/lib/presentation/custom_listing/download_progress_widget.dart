import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_track_bloc.dart';
import '../../bloc/download_bloc.dart';
import '../../manager/download_manager.dart';
import '../../model/download_model.dart';

class DownloadProgressWidget extends StatelessWidget {
  final DownloadModel downloadModel;

  const DownloadProgressWidget({super.key, required this.downloadModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadBloc, DownloadState>(
      listener: (context, state) {
        if (state.downloaderStatus == DownloaderStatus.complete && state.downloadFileList.isNotEmpty) {
          context.read<AudioTrackBloc>()
            ..add(AudioEventUpdateDownloaded(
                audioUrl: state.downloadFileList.last.audioUrl,
                downloadedAudioUrl: state.downloadFileList.last.downloadedAudioUrl));
        }
      },
      builder: (context, state) {
        return BlocBuilder<DownloadBloc, DownloadState>(
          builder: (context, state) {
            if (downloadModel.audioUrl == state.currentDownload?.audioUrl &&
                state.downloaderStatus == DownloaderStatus.downloading) {
              return Center(
                child: Container(
                  key: ValueKey(downloadModel.audioUrl),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black26),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(value: state.currentDownloadPercent / 100),
                      Text("${state.currentDownloadPercent.toStringAsFixed(0)}%", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              );
            }

            if (state.downloadQueue.any((e) => e.audioUrl == downloadModel.audioUrl)) {
              return Center(
                child: Container(
                  key: ValueKey(downloadModel.audioUrl),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black26),
                  child: Icon(Icons.downloading_outlined, color: Colors.white),
                ),
              );
            }

            if (!state.downloadFileList.any((doc) => doc.audioUrl == downloadModel.audioUrl)) {
              return Center(
                child: GestureDetector(
                  key: ValueKey(downloadModel.audioUrl),
                  onTap: () {
                    context.read<DownloadBloc>().add(DownloadEventAdd(downloadModel));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black26),
                    child: Icon(Icons.download, color: Colors.white),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
