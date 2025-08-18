import 'package:audio_player_package/audio_player_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/audio_bloc.dart';
import '../bloc/slider_seek_bloc.dart';
import '../models/audio_notification_settings.dart';
import '../utils/audio_manager.dart';

class AudioPlayerWrapper extends StatelessWidget {
  final Widget child;
  final AudioNotificationSettings audioNotificationSettings;

  const AudioPlayerWrapper({super.key, required this.child, required this.audioNotificationSettings});

  @override
  Widget build(BuildContext context) {
    GetIt.I<AudioManager>().setup(
      androidNotificationChannelId: audioNotificationSettings.androidNotificationChannelId,
      androidNotificationChannelName: audioNotificationSettings.androidNotificationChannelName,
      androidNotificationIcon: audioNotificationSettings.androidNotificationIcon,
      showNotificationBadge: true,
      ongoingNotification: true,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioBloc>(create: (context) => GetIt.I<AudioBloc>()),
        BlocProvider<SliderSeekBloc>(create: (context) => GetIt.I<SliderSeekBloc>()),
      ],
      child: child,
    );
  }
}
