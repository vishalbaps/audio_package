import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../bloc/slider_seek_bloc.dart';

@singleton
class SliderSeekManager {
  final SliderSeekBloc _bloc;

  SliderSeekManager() : _bloc = GetIt.I<SliderSeekBloc>();

  /// Public streams for package users
  Stream<SliderSeekState> get seekBarStateStream => _bloc.stream;

  // Stream<Duration> get totalDurationStream => _bloc.stream.map((s) => s.totalDuration).distinct();
  //
  // Stream<bool> get isUserSeekStream => _bloc.stream.map((s) => s.isUserSeek).distinct();
  //
  // Stream<double> get playPositionStream => _bloc.stream.map((s) => s.playPosition).distinct();

  /// Public API to control the slider
  void setCurrentDuration(Duration duration) {
    _bloc.add(SliderSeekEventCurrent(duration));
  }

  //whenever you slide that seekbar you need to freeze refreshing seekbar current position
  void setIsUserSeek(bool value) {
    _bloc.add(SliderSeekEventIsUserSeek(value));
  }

  Future<void> dispose() => _bloc.close();
}
