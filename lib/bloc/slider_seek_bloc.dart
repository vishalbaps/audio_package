import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../utils/audio_manager.dart';

part 'slider_seek_bloc.freezed.dart';

@singleton
class SliderSeekBloc extends Bloc<SliderSeekEvent, SliderSeekState> {
  final AudioManager _audioManager;
  StreamSubscription? _durationSubscription;

  @override
  Future<void> close() async {
    _durationSubscription?.cancel();
    super.close();
  }

  SliderSeekBloc(this._audioManager) : super(const SliderSeekState(Duration.zero, Duration.zero, false, 0)) {
    _durationSubscription = _audioManager.durationStream.listen((duration) {
      if (!state.isUserSeek) {
        add(SliderSeekEventBoth(currentDuration: duration.$1, totalDuration: duration.$2));
      }
    });

    on<SliderSeekEventBoth>((event, emit) async {
      if (event.totalDuration.inSeconds > 0) {
        if (event.currentDuration.inSeconds <= event.totalDuration.inSeconds) {
          var playPosition = event.currentDuration.inSeconds / event.totalDuration.inSeconds;
          emit(state.copyWith(
              currentDuration: event.currentDuration, totalDuration: event.totalDuration, playPosition: playPosition));
        }
      }
    }, transformer: droppable());

    on<SliderSeekEventCurrent>((event, emit) async {
      if (event.currentDuration.inSeconds > state.totalDuration.inSeconds) {
        return;
      }
      if (!state.isUserSeek) {
        _audioManager.seek(event.currentDuration);
      }
      var playPosition = event.currentDuration.inSeconds / state.totalDuration.inSeconds;
      emit(state.copyWith(currentDuration: event.currentDuration, playPosition: playPosition));
    }, transformer: droppable());

    on<SliderSeekEventIsUserSeek>((event, emit) async {
      emit(state.copyWith(isUserSeek: event.isUserSeek));
    }, transformer: restartable());
  }
}

@freezed
class SliderSeekState with _$SliderSeekState {
  const factory SliderSeekState(
      Duration currentDuration, Duration totalDuration, bool isUserSeek, double playPosition) = _SliderSeekState;
}

@sealed
abstract class SliderSeekEvent {}

class SliderSeekEventBoth extends SliderSeekEvent {
  final Duration currentDuration;
  final Duration totalDuration;

  SliderSeekEventBoth({required this.currentDuration, required this.totalDuration});
}

class SliderSeekEventCurrent extends SliderSeekEvent {
  final Duration currentDuration;

  SliderSeekEventCurrent(this.currentDuration);
}

class SliderSeekEventIsUserSeek extends SliderSeekEvent {
  final bool isUserSeek;

  SliderSeekEventIsUserSeek(this.isUserSeek);
}
