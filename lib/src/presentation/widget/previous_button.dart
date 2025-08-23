import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_bloc.dart';

class PreviousButton extends StatelessWidget {
  final IconData previousIcon;
  final Color iconColor;
  final double iconSize;
  final ButtonStyle? buttonStyle;
  final EdgeInsets padding;

  const PreviousButton({
    super.key,
    this.previousIcon = Icons.skip_previous,
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
          icon: Icon(previousIcon, size: iconSize, color: state.isPreviousAvailable ? iconColor : Colors.grey),
          onPressed: () {
            state.isPreviousAvailable ? context.read<AudioBloc>().add(AudioEventPrevious()) : null;
          },
          padding: padding,
          style: buttonStyle,
        );
      },
    );
  }
}
