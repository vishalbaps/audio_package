import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/audio_bloc.dart';
import '../bloc/slider_seek_bloc.dart';

class AudioPlayerWrapper extends StatelessWidget {
  final Widget child;

  const AudioPlayerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioBloc>(create: (context) => GetIt.I<AudioBloc>()),
        BlocProvider<SliderSeekBloc>(create: (context) => GetIt.I<SliderSeekBloc>()),
      ],
      child: child,
    );
  }
}
