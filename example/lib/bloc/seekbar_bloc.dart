import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'seekbar_bloc.freezed.dart';

@singleton
class SeekBarBloc extends Bloc<SeekBarEvent, SeekBarState> {
  SeekBarBloc() : super(const SeekBarState()) {
    on<SeekBarEventCurrent>(
      (event, emit) => emit(state.copyWith(currentDuration: event.duration)),
    );

    on<SeekBarEventTotal>(
      (event, emit) => emit(state.copyWith(totalDuration: event.duration)),
    );

    on<SeekBarEventIsUserSeek>(
      (event, emit) => emit(state.copyWith(isUserSeek: event.value)),
    );

    on<SeekBarEventPlayPosition>(
      (event, emit) => emit(state.copyWith(playPosition: event.position)),
    );
  }
}

@freezed
class SeekBarState with _$SeekBarState {
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

class SeekBarEventCurrent extends SeekBarEvent {
  final Duration duration;

  const SeekBarEventCurrent(this.duration);
}

class SeekBarEventTotal extends SeekBarEvent {
  final Duration duration;

  const SeekBarEventTotal(this.duration);
}

class SeekBarEventIsUserSeek extends SeekBarEvent {
  final bool value;

  const SeekBarEventIsUserSeek(this.value);
}

class SeekBarEventPlayPosition extends SeekBarEvent {
  final double position;

  const SeekBarEventPlayPosition(this.position);
}
