import 'package:audio_player_package/presentation/widget/play_pause_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_bloc.dart';
import '../../models/audio_content.dart';

class MiniPlayerTop extends StatelessWidget {
  final double height;
  final Color color;
  final double iconPadding;
  final IconData playIcon;
  final IconData pauseIcon;
  final Color playPauseIconColor;
  final double iconSize;
  final Color cancelIconColor;
  final TextStyle? textStyle;
  final void Function(List<AudioContent> album, AudioContent track)? onTap;

  const MiniPlayerTop({
    super.key,
    this.height = 30,
    this.color = Colors.grey,
    this.iconPadding = 0,
    this.iconSize = 20,
    this.playIcon = Icons.play_arrow,
    this.pauseIcon = Icons.pause,
    this.playPauseIconColor = Colors.blue,
    this.cancelIconColor = Colors.black,
    this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (_, state) {
        return InkWell(
          onTap: () => onTap?.call(state.album ?? [], state.audioContent!),
          child: Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            color: color,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: iconPadding),
                  child: PlayPauseButton(
                    currentTrack: state.audioContent!,
                    album: state.album ?? [],
                    iconSize: iconSize,
                    iconColor: playPauseIconColor,
                    playIcon: playIcon,
                    pauseIcon: pauseIcon,
                  ),
                ),
                SizedBox(width: 15),
                Text(state.audioContent!.contentTitle, style: textStyle),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.only(right: iconPadding),
                  icon: Icon(Icons.close, size: iconSize, color: cancelIconColor),
                  onPressed: () {
                    context.read<AudioBloc>().add(AudioEventStop());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
