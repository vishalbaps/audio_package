import 'package:audio_player_package/audio_player_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/audio_bloc.dart';
import '../../bloc/slider_seek_bloc.dart';

class AudioSeekBar extends StatelessWidget {
  final Color activeColor;
  final Color inactiveColor;
  final TextStyle? textStyle;

  const AudioSeekBar({super.key, this.activeColor = Colors.blue, this.inactiveColor = Colors.grey, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderSeekBloc, SliderSeekState>(
      builder: (context, state) {
        final duration = state.totalDuration.inSeconds.toDouble();

        if (duration == 0.0) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Slider(
              value: state.playPosition,
              padding: EdgeInsets.zero,
              onChanged: (double value) async {
                if (!state.isUserSeek) {
                  context.read<SliderSeekBloc>().add(SliderSeekEventIsUserSeek(true));
                }
                var newCurrentDuration = Duration(seconds: (state.totalDuration.inSeconds * value).toInt());
                context.read<SliderSeekBloc>().add(SliderSeekEventCurrent(newCurrentDuration));
              },
              onChangeStart: (_) {
                context.read<SliderSeekBloc>().add(SliderSeekEventIsUserSeek(true));
              },
              onChangeEnd: (value) {
                context.read<SliderSeekBloc>().add(SliderSeekEventIsUserSeek(false));

                var newCurrentDuration = Duration(seconds: (state.totalDuration.inSeconds * value).ceil());
                context.read<SliderSeekBloc>().add(SliderSeekEventCurrent(newCurrentDuration));
              },
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(state.currentDuration.toHHMMSS(), style: textStyle),
                Text(state.totalDuration.toHHMMSS(), style: textStyle),
              ],
            ),
          ],
        );
      },
    );
    //return SizedBox();
  }
}
