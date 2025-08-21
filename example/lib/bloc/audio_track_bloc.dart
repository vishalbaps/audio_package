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
      if (audioState.loadingStatus == AudioLoadingStatus.error) {
        add(_CurrentPlayedAudio(
            currentAudioContent: AudioContent.empty(),
            album: audioState.album ?? [],
            loadingStatus: AudioLoadingStatus.error,
            error: audioState.failure?.message));
      } else if (audioState.audioContent != null) {
        add(_CurrentPlayedAudio(
            currentAudioContent: audioState.audioContent!,
            album: audioState.album ?? [],
            loadingStatus: audioState.loadingStatus));
      }
    });

    on<_CurrentPlayedAudio>((event, emit) async {
      emit(state.copyWith(
          currentAudioContent: event.currentAudioContent,
          album: event.album,
          loadingStatus: event.loadingStatus,
          error: event.error));
    }, transformer: droppable());

    on<PlayNewAudio>((event, emit) async {
      _audioTrackManager.play(event.album, event.playId);
    }, transformer: droppable());

    on<AudioPause>((event, emit) async {
      _audioTrackManager.pause();
    }, transformer: droppable());

    on<AudioResume>((event, emit) async {
      _audioTrackManager.resume();
    }, transformer: droppable());

    on<AudioStop>((event, emit) async {
      _audioTrackManager.stop();
    }, transformer: droppable());

    on<AudioEventUpdateDownloaded>((event, emit) {
      final updatedAlbum = state.album?.map((audio) {
        if (audio.audioUrl == event.audioUrl) {
          return audio.copyWith(downloadedAudioUrl: event.downloadedAudioUrl);
        }
        return audio;
      }).toList();

      emit(state.copyWith(album: updatedAlbum));
    });
  }
}

@freezed
sealed class AudioTrackState with _$AudioTrackState {
  const factory AudioTrackState({
    @Default(null) AudioContent? currentAudioContent,
    @Default([]) List<AudioContent>? album,
    @Default(AudioLoadingStatus.none) AudioLoadingStatus loadingStatus,
    @Default(null) String? error,
  }) = _AudioTrackState;
}

sealed class AudioTrackEvent {
  const AudioTrackEvent();
}

class _CurrentPlayedAudio extends AudioTrackEvent {
  final AudioContent currentAudioContent;
  final List<AudioContent> album;
  final AudioLoadingStatus loadingStatus;
  final String? error;

  _CurrentPlayedAudio({
    required this.currentAudioContent,
    required this.album,
    required this.loadingStatus,
    this.error,
  });
}

class PlayNewAudio extends AudioTrackEvent {
  final List<AudioContent> album;
  final String playId;

  PlayNewAudio({required this.album, required this.playId});
}

class AudioPause extends AudioTrackEvent {}

class AudioResume extends AudioTrackEvent {}

class AudioStop extends AudioTrackEvent {}

class AudioEventUpdateDownloaded extends AudioTrackEvent {
  final String audioUrl;
  final String downloadedAudioUrl;

  AudioEventUpdateDownloaded({required this.audioUrl, required this.downloadedAudioUrl});
}
