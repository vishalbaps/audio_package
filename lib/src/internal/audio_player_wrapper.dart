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

  const AudioPlayerWrapper({
    super.key,
    required this.child,
    required this.audioNotificationSettings
  });

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
        // Provide AudioBloc
        BlocProvider<AudioBloc>(create: (context) => GetIt.I<AudioBloc>()),

        // Provide SliderSeekBloc
        BlocProvider<SliderSeekBloc>(create: (context) => GetIt.I<SliderSeekBloc>()),

        // Provide and initialize AudioPlayerConfigBloc
        /* BlocProvider<AudioPlayerConfigBloc>(
          create: (context) => GetIt.I<AudioPlayerConfigBloc>()
            ..add(
              InitializeAudioManager(
                AudioManagerConfig(
                  androidNotificationChannelId: 'my_channel_id',
                  androidNotificationChannelName: 'My Channel Name',
                  androidNotificationIcon: 'mipmap/ic_launcher',
                  showNotificationBadge: true,
                  ongoingNotification: true,
                ),
              ),
            ),
        ),*/
      ],
      child: child /*BlocListener<AudioPlayerConfigBloc, AudioPlayerConfigState>(
        listener: (context, state) {
          // Debug log to check if initialization is working
          debugPrint("AudioPlayerConfigBloc state changed: $state");

          if (state.loadingStatus == AudioManagerStatus.loading) {
            debugPrint("🎧 Audio Manager initializing...");
          } else if (state.loadingStatus == AudioManagerStatus.ready) {
            debugPrint("✅ Audio Manager ready: ${state.audioManager}");
          } else if (state.loadingStatus == AudioManagerStatus.error) {
            debugPrint("❌ Failed to initialize Audio Manager");
          }
        },
        child: child,
      ),*/,
    );
  }
}
