import 'dart:async';

import 'package:audio_player_package/audio_player_package.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'audio_track_bloc.freezed.dart';

@singleton
class AudioTrackBloc extends Bloc<AudioTrackEvent, AudioTrackState> {
  final AudioTrackManager _audioTrackManager;

  StreamSubscription? _audioStateSubscription;

  @override
  Future<void> close() async {
    _audioTrackManager.dispose();
    _audioStateSubscription?.cancel();
    super.close();
  }

  AudioTrackBloc(this._audioTrackManager) : super(const AudioTrackState()) {
    _audioStateSubscription = _audioTrackManager.audioStateStream.listen((audioState) {
      if (audioState.audioContent != null)
        add(AudioTrackCurrentEvent(currentAudioContent: audioState.audioContent, album: audioState.album));
    });

    on<AudioTrackCurrentEvent>((event, emit) async {
      emit(state.copyWith(currentAudioContent: event.currentAudioContent,album: event.album));
    }, transformer: droppable());
  }
}

@freezed
sealed class AudioTrackState with _$AudioTrackState {
  const factory AudioTrackState({
    @Default(null) AudioContent? currentAudioContent,
    @Default([]) List<AudioContent>? album,
  }) = _AudioTrackState;
}

sealed class AudioTrackEvent {
  const AudioTrackEvent();
}

class AudioTrackCurrentEvent extends AudioTrackEvent {
  final AudioContent? currentAudioContent;
  final List<AudioContent>? album;

  AudioTrackCurrentEvent({this.currentAudioContent, this.album});
}

class AudioTrackPlayAudioEvent extends AudioTrackEvent {
  final List<AudioContent> album;
  final String playId;

  AudioTrackPlayAudioEvent({required this.album, required this.playId});
}
