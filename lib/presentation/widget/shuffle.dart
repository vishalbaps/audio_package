import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_bloc.dart';

class Shuffle extends StatelessWidget {
  const Shuffle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (BuildContext context, state) {
        return IconButton(
          onPressed: () {
            context.read<AudioBloc>().add(AudioEventToggleShuffle());
          },
          icon: Icon(Icons.shuffle, color: state.isShuffleEnabled ? Colors.black : Colors.grey),
        );
      },
    );
  }
}
