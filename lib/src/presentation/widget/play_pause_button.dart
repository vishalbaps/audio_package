import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/audio_bloc.dart';
import '../../models/audio_content.dart';
import '../../utils/enum.dart';

class PlayPauseButton extends StatelessWidget {
  final AudioContent currentTrack;
  final IconData playIcon;
  final IconData pauseIcon;
  final Color iconColor;
  final double iconSize;
  final List<AudioContent> album;

  final ButtonStyle? buttonStyle;
  final EdgeInsets padding;

  const PlayPauseButton({
    super.key,
    required this.currentTrack,
    this.playIcon = Icons.play_arrow,
    this.pauseIcon = Icons.pause,
    this.iconColor = Colors.blue,
    this.iconSize = 25,
    required this.album,
    this.buttonStyle,
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
            return Icon(playIcon, color: iconColor, size: iconSize);
          }

          switch (state.loadingStatus) {
            case AudioLoadingStatus.playing:
              return Icon(pauseIcon, color: iconColor, size: iconSize);

            case AudioLoadingStatus.loading:
              return SizedBox(
                width: iconSize,
                height: iconSize,
                child: CupertinoActivityIndicator(radius: iconSize / 2.5, color: iconColor),
              );

            default:
              return Icon(playIcon, color: iconColor, size: iconSize);
          }
        }();

        return IconButton(onPressed: () => playAudio(), icon: child, padding: padding, style: buttonStyle);
      },
    );
  }
}
