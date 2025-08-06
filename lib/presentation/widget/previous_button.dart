import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_bloc.dart';

class PreviousButton extends StatelessWidget {
  final Icon? previousIcon;
  final Color? iconColor;
  final double iconSize;
  final BoxDecoration? decoration;
  final EdgeInsets padding;

  const PreviousButton({
    super.key,
    this.previousIcon,
    this.iconColor,
    this.iconSize = 25,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => state.isPreviousAvailable ? context.read<AudioBloc>().add(AudioEventPrevious()) : null,
          child: Container(
            padding: padding,
            decoration: decoration,
            child:
                previousIcon ??
                Icon(
                  Icons.skip_previous,
                  color: state.isPreviousAvailable ? iconColor ?? Colors.blue : Colors.grey,
                  size: iconSize,
                ),
          ),
        );
      },
    );
  }
}
