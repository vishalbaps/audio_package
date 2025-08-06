import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_bloc.dart';

class NextButton extends StatelessWidget {
  final Icon? nextIcon;
  final Color? iconColor;
  final double iconSize;
  final BoxDecoration? decoration;
  final EdgeInsets padding;

  const NextButton({
    super.key,
    this.nextIcon,
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
          onTap: () => state.isNextAvailable ? context.read<AudioBloc>().add(AudioEventNext()) : null,
          child: Container(
            padding: padding,
            decoration: decoration,
            child:
                nextIcon ??
                Icon(
                  Icons.skip_next,
                  color: state.isNextAvailable ? iconColor ?? Colors.blue : Colors.grey,
                  size: iconSize,
                ),
          ),
        );
      },
    );
  }
}
