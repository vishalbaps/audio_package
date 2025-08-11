import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../models/audio_manager_config.dart';
import '../utils/audio_manager.dart';
import '../utils/enum.dart';

part 'audio_player_config_bloc.freezed.dart';

@singleton
class AudioPlayerConfigBloc extends Bloc<AudioPlayerConfigEvent, AudioPlayerConfigState> {
  AudioPlayerConfigBloc() : super(const AudioPlayerConfigState(AudioManagerStatus.initial, null)) {
    on<InitializeAudioManager>(_onInit);
  }

  Future<void> _onInit(InitializeAudioManager event, Emitter<AudioPlayerConfigState> emit) async {
    emit(state.copyWith(loadingStatus: AudioManagerStatus.loading));

    try {
      final session = await AudioSession.instance;
      await session.configure(AudioSessionConfiguration.music());

      final audioManager = await AudioService.init(
        builder: () => AudioManager(),
        config: AudioServiceConfig(
          androidNotificationChannelId: event.config.androidNotificationChannelId,
          androidNotificationChannelName: event.config.androidNotificationChannelName,
          androidNotificationIcon: event.config.androidNotificationIcon,
          androidShowNotificationBadge: event.config.showNotificationBadge,
          androidNotificationOngoing: event.config.ongoingNotification,
        ),
      );

      emit(AudioPlayerConfigState(AudioManagerStatus.ready, audioManager));
    } catch (e) {
      emit(state.copyWith(loadingStatus: AudioManagerStatus.error));
    }
  }
}

@sealed
abstract class AudioPlayerConfigEvent {}

class InitializeAudioManager extends AudioPlayerConfigEvent {
  final AudioManagerConfig config;

  InitializeAudioManager(this.config);
}

@freezed
class AudioPlayerConfigState with _$AudioPlayerConfigState {
  const factory AudioPlayerConfigState(AudioManagerStatus loadingStatus, AudioManager? audioManager) =
      _AudioPlayerConfigState;
}
