import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../models/audio_content.dart';

class AudioManager extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player = AudioPlayer();
  AudioSession? _session;
  MediaItem? _currentContent;
  StreamSubscription? _stateSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playBackSubscription;

  Duration totalDuration = Duration.zero;

  bool? previousShuffleState;

  // int? nextIndex; // Variable to store the next index in the shuffled sequence.

  //when album is changed
  final StreamController<List<AudioContent>> _albumController = StreamController<List<AudioContent>>.broadcast();

  Stream<List<AudioContent>> get albumStream => _albumController.stream;

  //when audio changed
  final StreamController<(int, bool, bool)> _albumItemController = StreamController<(int, bool, bool)>.broadcast();

  Stream<(int, bool, bool)> get albumItemStream => _albumItemController.stream;

  //current Duration
  final StreamController<(Duration current, Duration total)> _durationController =
      StreamController<(Duration current, Duration total)>.broadcast();

  Stream<(Duration current, Duration total)> get durationStream => _durationController.stream;

  final StreamController<PlayerState> _stateController = StreamController<PlayerState>.broadcast();

  Stream<PlayerState> get stateStream => _stateController.stream;

  final StreamController<MediaButton> _buttonController = StreamController<MediaButton>.broadcast();

  Stream<MediaButton> get buttonStream => _buttonController.stream;

  Duration? duration;

  AudioManager() {
    _stateSubscription = _player.playerStateStream.listen((state) {
      _stateController.sink.add(state);
    });
    _playBackSubscription = _player.playbackEventStream.map(_transformEvent).listen((event) {
      playbackState.add(event);
    });
    _durationSubscription = _player.positionStream.listen((currentDuration) {
      _durationController.sink.add((currentDuration, totalDuration));
    });

    _player.durationStream.listen((duration) {
      totalDuration = duration ?? Duration.zero;

      _durationController.sink.add((Duration.zero, totalDuration));
    });

    _player.sequenceStateStream.debounceTime(const Duration(milliseconds: 500)).listen((SequenceState? sequenceState) {
      final sequence = sequenceState?.effectiveSequence ?? [];
      final shuffleIndices = sequenceState?.shuffleIndices ?? [];
      var currentIndex = sequenceState?.currentIndex ?? 0;

      if (sequenceState?.shuffleModeEnabled ?? false) {
        currentIndex = shuffleIndices.indexOf(currentIndex);
      }

      if (sequence.isEmpty) return;

      // change album
      var items = sequence.map((source) => (source.tag as MediaItem).audioContent).toList();
      _albumController.sink.add(items);

      // Check if next audio is available
      final isNextAvailable = currentIndex + 1 < sequence.length;

      // Check if previous audio is available
      final isPreviousAvailable = currentIndex > 0;

      _albumItemController.sink.add((currentIndex, isNextAvailable, isPreviousAvailable));

      bool currentShuffleState = _player.shuffleModeEnabled;
      previousShuffleState = currentShuffleState;

      // When the current audio completes, play the next one in the shuffled order
      _player.playbackEventStream.listen((PlaybackEvent event) {
        if (event.processingState == ProcessingState.completed) {
          // Find the current shuffled index
          final currentShuffleIndex = shuffleIndices.indexOf(currentIndex);

          // Play the next item in the shuffled sequence if it exists
          if (currentShuffleIndex < shuffleIndices.length - 1) {
            final nextIndex = shuffleIndices[currentShuffleIndex + 1];
            _player.seek(Duration.zero, index: nextIndex);
            _player.play();
          }
        }
      });
    });
  }

  static Future<AudioManager> init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
    return AudioService.init(
      builder: () => AudioManager().._session = session,
      config: AudioServiceConfig(
        androidNotificationChannelId: 'org.player.channel.audio',
        androidNotificationChannelName: 'Music playback',
        androidShowNotificationBadge: true,
        androidNotificationOngoing: true,
        androidNotificationIcon: 'mipmap/ic_launcher',
      ),
    );
  }

  void dispose() {
    _durationController.close();
    _stateController.close();
    _stateSubscription?.cancel();
    _playBackSubscription?.cancel();
    _durationSubscription?.cancel();
    _buttonController.close();
    mediaItem.close();
    playbackState.close();
  }

  @override
  Future<void> onTaskRemoved() => _player.stop();

  Future<void> playAudio(MediaItem media, {Duration? seekTo, List<AudioContent>? album, int? initialIndex}) async {
    _currentContent = media;
    await _session?.setActive(true);

    final playlist = ConcatenatingAudioSource(
      children:
          album!.map((audioContent) {
            return AudioSource.uri(Uri.parse(audioContent.url), tag: audioContent.media);
          }).toList(),
    );

    try {
      duration = await _player.setAudioSource(
        playlist,
        initialPosition: seekTo,
        preload: true,
        initialIndex: initialIndex,
      );
      totalDuration = duration ?? Duration.zero;
      _player.play();

      mediaItem.add(media.copyWith(duration: duration));
      playbackState.add(
        PlaybackState(
          controls: [MediaControl.skipToPrevious, MediaControl.pause, MediaControl.skipToNext],
          systemActions: const {MediaAction.seek},
          processingState: AudioProcessingState.ready,
          playing: true,
        ),
      );
    } catch (e) {
      _player.stop();
    }
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      processingState:
          {
            ProcessingState.idle: Platform.isIOS ? AudioProcessingState.ready : AudioProcessingState.idle,
            ProcessingState.loading: AudioProcessingState.loading,
            ProcessingState.buffering: AudioProcessingState.buffering,
            ProcessingState.ready: AudioProcessingState.ready,
            ProcessingState.completed: AudioProcessingState.completed,
          }[_player.processingState]!,
      systemActions: const {MediaAction.seek},
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }

  Future<void> play() async {
    await _session?.setActive(true);
    if (!mediaItem.hasValue) {
      mediaItem.add(_currentContent);
    }

    await _player.play();
  }

  Future<void> pause() async {
    await _session?.setActive(false);
    await _player.pause();
  }

  Future<void> stop() async {
    // _durationController.sink.add((Duration.zero, Duration.zero));
    playbackState.add(
      PlaybackState(controls: [], systemActions: {}, processingState: AudioProcessingState.idle, playing: false),
    );
    await _session?.setActive(false);
    await _player.stop();
  }

  Future<void> resume() async {
    await play();
  }

  Future<void> seek(Duration duration) async {
    await _player.seek(duration);
  }

  Future<void> setAudioShuffleMode(bool isShuffleEnabled) async {
    if (isShuffleEnabled) {
      await _player.shuffle();
    }
    await _player.setShuffleModeEnabled(isShuffleEnabled);
  }

  Future<void> setLoopMode(LoopMode loopMode) async {
    await _player.setLoopMode(loopMode);
  }

  Future<void> setAudioSpeed(double audioSpeed) async {
    await _player.setSpeed(audioSpeed);
  }

  Future<void> seekToNext() async {
    await _player.seekToNext();
    // _buttonController.add(MediaButton.next);
  }

  Future<void> seekToPrevious() async {
    await _player.seekToPrevious();
    // _buttonController.add(MediaButton.previous);
  }

  Future<void> click([MediaButton button = MediaButton.media]) async {
    _buttonController.sink.add(button);
  }

  Future<void> skipToNext() async {
    await seekToNext();
  }

  Future<void> skipToPrevious() async {
    await seekToPrevious();
  }
}
