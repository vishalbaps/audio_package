import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';

import '../../audio_player_package.dart';
import '../bloc/audio_bloc.dart';

@singleton
class AudioTrackManager {
  final AudioBloc _audioBloc;

  AudioTrackManager() : _audioBloc = GetIt.I<AudioBloc>();


  /// Stream of the full AudioState
  // Stream<AudioState> get audioStateStream => _audioBloc.stream;

  /// Expose only specific state fields as separate streams
  Stream<AudioLoadingStatus> get loadingStatusStream =>
      _audioBloc.stream.map((s) => s.loadingStatus).distinct();

  Stream<List<AudioContent>?> get albumStream =>
      _audioBloc.stream.map((s) => s.album).distinct();

  Stream<AudioContent?> get currentAudioContentStream =>
      _audioBloc.stream.map((s) => s.audioContent).distinct();

  Stream<bool> get isShuffleEnabledStream =>
      _audioBloc.stream.map((s) => s.isShuffleEnabled).distinct();

  Stream<LoopMode> get loopModeStream =>
      _audioBloc.stream.map((s) => s.loopMode).distinct();

  Stream<double> get audioSpeedStream =>
      _audioBloc.stream.map((s) => s.audioSpeed).distinct();

  /// Public API to control playback
  void play(List<AudioContent> album, String playId) {
    _audioBloc.add(AudioEventPlay(album: album, playId: playId));
  }

  // void playById(String playId) {
  //   _audioBloc.add(AudioEventPlayById(playId: playId));
  // }

  void pause() => _audioBloc.add(AudioEventPause());
  void resume() => _audioBloc.add(AudioEventResume());
  void stop() => _audioBloc.add(AudioEventStop());
  void toggleShuffle() => _audioBloc.add(AudioEventToggleShuffle());
  void toggleLoop() => _audioBloc.add(AudioEventToggleLoop());
  void setAudioSpeed(double speed) =>
      _audioBloc.add(AudioEventAudioSpeed(speed));

  Future<void> dispose() => _audioBloc.close();


}