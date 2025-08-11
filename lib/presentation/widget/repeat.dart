import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../bloc/audio_bloc.dart';

class Repeat extends StatelessWidget {
  final ButtonStyle? buttonStyle;
  final Color enableColor;
  final Color disableColor;
  final IconData? repeatIcon;
  final IconData? repeatOneIcon;

  const Repeat({
    super.key,
    this.buttonStyle,
    this.enableColor = Colors.black,
    this.disableColor = Colors.grey,
    this.repeatIcon = Icons.repeat,
    this.repeatOneIcon = Icons.repeat_one,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (BuildContext context, state) {
        return IconButton(
          onPressed: () {
            context.read<AudioBloc>().add(AudioEventToggleLoop());
          },
          icon: Icon(
            state.loopMode == LoopMode.one ? repeatOneIcon : repeatIcon,
            color: state.loopMode == LoopMode.off ? disableColor : enableColor,
          ),
          style: buttonStyle,
        );
      },
    );
  }
}
