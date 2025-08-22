import 'dart:async';

import 'package:audio_player_package/audio_player_package.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'seekbar_bloc.freezed.dart';

@singleton
class SeekBarBloc extends Bloc<SeekBarEvent, SeekBarState> {
  final SliderSeekManager _sliderSeekManager = SliderSeekManager();

  StreamSubscription? _durationSubscription;

  @override
  Future<void> close() async {
    _sliderSeekManager.dispose();
    _durationSubscription?.cancel();
    super.close();
  }

  SeekBarBloc() : super(const SeekBarState()) {
    _durationSubscription = _sliderSeekManager.seekBarStateStream.listen((slideState) {
        add(_SeekBarEventListen(
            currentDuration: slideState.currentDuration,
            totalDuration: slideState.totalDuration,
            isUserSeek: slideState.isUserSeek,
            playPosition: slideState.playPosition));
    });

    on<_SeekBarEventListen>((event, emit) async {
      emit(state.copyWith(
          currentDuration: event.currentDuration,
          totalDuration: event.totalDuration,
          isUserSeek: event.isUserSeek,
          playPosition: event.playPosition));
    }, transformer: droppable());

    on<SeekBarSetCurrentDurationEvent>((event, emit) async {
      _sliderSeekManager.setCurrentDuration(event.currentDuration);
    }, transformer: droppable());

    on<SeekBarUserSeekEvent>((event, emit) async {
      _sliderSeekManager.setIsUserSeek(event.isUserSeek);
    }, transformer: droppable());
  }
}

@freezed
sealed class SeekBarState with _$SeekBarState {
  const factory SeekBarState({
    @Default(Duration.zero) Duration currentDuration,
    @Default(Duration.zero) Duration totalDuration,
    @Default(false) bool isUserSeek,
    @Default(0.0) double playPosition,
  }) = _SeekBarState;
}

sealed class SeekBarEvent {
  const SeekBarEvent();
}

class _SeekBarEventListen extends SeekBarEvent {
  final Duration currentDuration;
  final Duration totalDuration;
  final bool isUserSeek;
  final double playPosition;

  const _SeekBarEventListen({
    required this.currentDuration,
    required this.totalDuration,
    required this.isUserSeek,
    required this.playPosition,
  });
}

class SeekBarSetCurrentDurationEvent extends SeekBarEvent {
  final Duration currentDuration;

  SeekBarSetCurrentDurationEvent(this.currentDuration);
}

class SeekBarUserSeekEvent extends SeekBarEvent {
  final bool isUserSeek;

  SeekBarUserSeekEvent(this.isUserSeek);
}
