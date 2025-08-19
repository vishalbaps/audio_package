import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_bloc.dart';

class AutoPlaySwitch extends StatelessWidget {
  const AutoPlaySwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return Switch(
          value: state.isAutoPlay,
          onChanged: (value) {
            context.read<AudioBloc>().add(AudioEventAutoPlay(value));
          },
        );
      },
    );
  }
}
