import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../models/audio_content.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/enum.dart';
import '../models/failure.dart';
import '../utils/audio_manager.dart';
import '../utils/connections.dart';

part 'audio_bloc.freezed.dart';

@singleton
class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioManager _audioManager;
  final InternetConnectivity _internetConnectivity;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _playingStateSubscription;
  StreamSubscription? _albumSubscription;

  @override
  Future<void> close() async {
    _albumSubscription?.cancel();
    _durationSubscription?.cancel();
    _playingStateSubscription?.cancel();
    _audioManager.dispose();
    super.close();
  }

  AudioBloc(this._audioManager, this._internetConnectivity) : super(const AudioState.playing(AudioLoadingStatus.none)) {
   /* _durationSubscription = _audioManager.durationStream.listen((duration) {
      // controlling auto play
      if (duration.$2 != Duration.zero && duration.$1 >= duration.$2 && !state.isAutoPlay) {
        _audioManager.pause();
      }
    });*/

    _playingStateSubscription = _audioManager.stateStream.listen((audioState) {
      add(AudioEventPlayingStateChanged(audioState));
    });

    _albumSubscription = _audioManager.albumStream.listen((albumList) {
      //Changing album
      add(AudioEventChangeAlbum(albumList));
    });

    /*_albumSubscription = _audioManager.albumItemStream.listen((albumItem) {
      //1- currentIndex
      //2- isNextAvailable
      //3- isPreviousAvailable
      if (state.loadingStatus != AudioLoadingStatus.none) {
        add(AudioEventChangeAlbumItem(albumItem.$1, albumItem.$2, albumItem.$3));
      }
    });*/

    on<AudioEventPlay>((event, emit) async {
      int index = event.album.indexWhere((e) => e.contentId == event.playId);

      if (index >= 0) {
        if (event.album[index].url.toLowerCase().startsWith("http") && !await _internetConnectivity.hasInternet()) {
          emit(
            state.copyWith(
              loadingStatus: AudioLoadingStatus.error,
              failure: ServerFailure(message: UserMessages.turnOnInternet),
            ),
          );
        } else {
          var currentAudioContent = event.album[index];
          bool isPreviousAvailable = index >= 1;
          bool isNextAvailable = (index + 1) < event.album.length - 1;
          emit(
            state.copyWith(
              loadingStatus: AudioLoadingStatus.loading,
              album: event.album,
              audioContent: currentAudioContent,
              isNextAvailable: isNextAvailable,
              isPreviousAvailable: isPreviousAvailable,
            ),
          );
          try {
            await _audioManager.playAudio(currentAudioContent.media, album: event.album);
          } catch (e) {
            emit(
              state.copyWith(
                loadingStatus: AudioLoadingStatus.error,
                failure: const Failure(ErrorMessages.failedToPlay),
              ),
            );
          }
        }
      }
    }, transformer: restartable());

    on<AudioEventPlayById>((event, emit) async {
      add(AudioEventPlay(album: state.album!, playId: event.playId));
    }, transformer: restartable());

    on<AudioEventChangeAlbumItem>((event, emit) async {
      emit(
        state.copyWith(
          audioContent: state.album![event.currentIndex],
          isNextAvailable: event.isNextAvailable,
          isPreviousAvailable: event.isPreviousAvailable,
        ),
      );
    });

    on<AudioEventChangeAlbum>((event, emit) async {
      emit(state.copyWith(album: event.album));
    });

    on<AudioEventPlayingStateChanged>((event, emit) async {
      if (state.audioContent != null) {
        switch (event.playerState.processingState) {
          case ProcessingState.idle:
            emit(state.copyWith(loadingStatus: AudioLoadingStatus.none));
            break;
          case ProcessingState.loading:
            emit(state.copyWith(loadingStatus: AudioLoadingStatus.loading));
            break;
          case ProcessingState.buffering:
            emit(state.copyWith(loadingStatus: AudioLoadingStatus.buffering));
            break;
          case ProcessingState.ready:
            if (event.playerState.playing) {
              emit(
                state.copyWith(
                  loadingStatus: AudioLoadingStatus.playing,
                  album: state.album,
                  audioContent: state.audioContent,
                ),
              );
            } else {
              emit(state.copyWith(loadingStatus: AudioLoadingStatus.paused));
            }
            break;
          case ProcessingState.completed:
            if (event.playerState.playing) {
              emit(state.copyWith(loadingStatus: AudioLoadingStatus.complete));
              add(AudioEventStop());
            }
            break;
          default:
            break;
        }
      }
    }, transformer: restartable());

    on<AudioEventPause>((event, emit) async {
      await _audioManager.pause();
      if (state.audioContent != null) {
        emit(state.copyWith(loadingStatus: AudioLoadingStatus.paused));
      }
    }, transformer: restartable());

    on<AudioEventResume>((event, emit) async {
      await _audioManager.resume();
    }, transformer: restartable());

    on<AudioEventStop>((event, emit) async {
      await _audioManager.stop();
      emit(state.copyWith(loadingStatus: AudioLoadingStatus.stopped, audioContent: null));
      emit(state.copyWith(loadingStatus: AudioLoadingStatus.none));
    }, transformer: restartable());

    on<AudioEventNext>((event, emit) async {
      await _audioManager.seekToNext();
    }, transformer: restartable());

    on<AudioEventPrevious>((event, emit) async {
      await _audioManager.seekToPrevious();
    }, transformer: restartable());

    on<AudioEventAutoPlay>((event, emit) {
      emit(state.copyWith(isAutoPlay: event.isAutoPlay));
    });

    on<AudioEventToggleShuffle>((event, emit) async {
      await _audioManager.setAudioShuffleMode(!state.isShuffleEnabled);
      emit(state.copyWith(isShuffleEnabled: !state.isShuffleEnabled));
    }, transformer: restartable());

    on<AudioEventToggleLoop>((event, emit) async {
      LoopMode newLoopMode =
          state.loopMode == LoopMode.off
              ? LoopMode.one
              : state.loopMode == LoopMode.one
              ? LoopMode.all
              : LoopMode.off;

      await _audioManager.setLoopMode(newLoopMode);
      emit(state.copyWith(loopMode: newLoopMode));
    }, transformer: restartable());

    on<AudioEventAudioSpeed>((event, emit) async {
      await _audioManager.setAudioSpeed(event.audioSpeed);
      emit(state.copyWith(audioSpeed: event.audioSpeed));
    }, transformer: restartable());
  }
}

@freezed
class AudioState with _$AudioState {
  const factory AudioState.playing(
    AudioLoadingStatus loadingStatus, {
    List<AudioContent>? album,
    AudioContent? audioContent,
    Failure? failure,
    @Default(false) bool isAutoPlay,
    @Default(true) bool isNextAvailable,
    @Default(false) bool isPreviousAvailable,
    @Default(false) bool isShuffleEnabled,
    @Default(LoopMode.off) LoopMode loopMode,
    @Default(1.0) double audioSpeed,
  }) = _Playing;
}

@sealed
abstract class AudioEvent {}

class AudioEventPlay extends AudioEvent {
  final List<AudioContent> album;
  final String playId;

  AudioEventPlay({required this.album, required this.playId});
}

class AudioEventPlayById extends AudioEvent {
  final String playId;

  AudioEventPlayById({required this.playId});
}

class AudioEventPlayingStateChanged extends AudioEvent {
  final PlayerState playerState;

  AudioEventPlayingStateChanged(this.playerState);
}

class AudioEventToggleShuffle extends AudioEvent {}

class AudioEventToggleLoop extends AudioEvent {}

class AudioEventAudioSpeed extends AudioEvent {
  final double audioSpeed;

  AudioEventAudioSpeed(this.audioSpeed);
}

class AudioEventPause extends AudioEvent {}

class AudioEventResume extends AudioEvent {}

class AudioEventStop extends AudioEvent {}

class AudioEventNext extends AudioEvent {}

class AudioEventPrevious extends AudioEvent {}

class AudioEventAutoPlay extends AudioEvent {
  final bool isAutoPlay;

  AudioEventAutoPlay(this.isAutoPlay);
}

class AudioEventChangeAlbum extends AudioEvent {
  final List<AudioContent> album;

  AudioEventChangeAlbum(this.album);
}

class AudioEventChangeAlbumItem extends AudioEvent {
  final int currentIndex;
  final bool isNextAvailable;
  final bool isPreviousAvailable;

  AudioEventChangeAlbumItem(this.currentIndex, this.isNextAvailable, this.isPreviousAvailable);
}
