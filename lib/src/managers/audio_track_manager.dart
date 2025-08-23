import 'package:get_it/get_it.dart';

import '../../audio_player_package.dart';
import '../bloc/audio_bloc.dart';

class AudioTrackManager {
  final AudioBloc _audioBloc;

  AudioTrackManager() : _audioBloc = GetIt.I<AudioBloc>();

  /// Stream of the full AudioState
  Stream<AudioState> get audioStateStream => _audioBloc.stream;

  /// Public API to control playback
  void play(List<AudioContent> album, String playId) => _audioBloc.add(AudioEventPlay(album: album, playId: playId));

  void pause() => _audioBloc.add(AudioEventPause());

  void resume() => _audioBloc.add(AudioEventResume());

  void stop() => _audioBloc.add(AudioEventStop());

  void toggleShuffle() => _audioBloc.add(AudioEventToggleShuffle());

  void toggleLoop() => _audioBloc.add(AudioEventToggleLoop());

  void setAudioSpeed(double speed) => _audioBloc.add(AudioEventAudioSpeed(speed));

  void next() => _audioBloc.add(AudioEventNext());

  void previous() => _audioBloc.add(AudioEventPrevious());

  Future<void> dispose() => _audioBloc.close();
}
