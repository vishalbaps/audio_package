import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_bloc.dart';

class NextButton extends StatelessWidget {
  final IconData nextIcon;
  final Color iconColor;
  final double iconSize;
  final ButtonStyle? buttonStyle;
  final EdgeInsets padding;

  const NextButton({
    super.key,
    this.nextIcon = Icons.skip_next,
    this.iconColor = Colors.blue,
    this.iconSize = 25,
    this.buttonStyle,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(nextIcon, size: iconSize, color: state.isNextAvailable ? iconColor : Colors.grey),
          onPressed: () {
            state.isNextAvailable ? context.read<AudioBloc>().add(AudioEventNext()) : null;
          },
          padding: padding,
          style: buttonStyle,
        );
      },
    );
  }
}
