import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/audio_bloc.dart';
import '../../models/audio_content.dart';
import '../../utils/enum.dart';

class PlayPauseButton extends StatelessWidget {
  final AudioContent currentTrack;
  final Icon? playIcon;
  final Icon? pauseIcon;
  final Color? iconColor;
  final double iconSize;
  final List<AudioContent> album;

  final BoxDecoration? decoration;
  final EdgeInsets padding;

  const PlayPauseButton({
    super.key,
    required this.currentTrack,
    this.playIcon,
    this.pauseIcon,
    this.iconColor,
    this.iconSize = 25,
    required this.album,
    this.decoration,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        var isCurrentTrack = state.audioContent?.contentId == currentTrack.contentId;
        Future<void> playAudio() async {
          if (!isCurrentTrack) {
            BlocProvider.of<AudioBloc>(context).add(AudioEventPlay(album: album, playId: currentTrack.contentId));
            return;
          }

          switch (state.loadingStatus) {
            case AudioLoadingStatus.playing:
              BlocProvider.of<AudioBloc>(context).add(AudioEventPause());
              break;
            case AudioLoadingStatus.paused:
              BlocProvider.of<AudioBloc>(context).add(AudioEventResume());
              break;
            case AudioLoadingStatus.none:
              BlocProvider.of<AudioBloc>(context).add(AudioEventPlay(album: album, playId: currentTrack.contentId));
              break;
            default:
              break;
          }
        }

        final Widget child = () {
          if (!isCurrentTrack) {
            return playIcon ?? Icon(Icons.play_arrow, color: iconColor ?? Colors.blue, size: iconSize);
          }

          switch (state.loadingStatus) {
            case AudioLoadingStatus.playing:
              return pauseIcon ?? Icon(Icons.pause, color: iconColor ?? Colors.blue, size: iconSize);

            case AudioLoadingStatus.loading:
              return SizedBox(
                width: iconSize,
                height: iconSize,
                child: CupertinoActivityIndicator(radius: iconSize / 2.5, color: iconColor ?? Colors.blue),
              );

            default:
              return playIcon ?? Icon(Icons.play_arrow, color: iconColor ?? Colors.blue, size: iconSize);
          }
        }();

        return InkWell(
          onTap: () => playAudio(),
          child: Container(padding: padding, decoration: decoration, child: child),
        );
      },
    );
  }
}
