# Advanced Audio Player Package

A feature-rich, customizable audio player package for Flutter applications. This package provides a simple API for playing audio tracks and playlists with a beautiful, customizable UI.

## Features

- 🎵 Play single tracks or playlists
- 🎮 Full playback controls (play, pause, stop, seek, next, previous)
- 🎨 Customizable UI components
- 📱 Background playback with notification controls
- 🧩 BLoC state management
- 📦 Easy to integrate

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  audio_player_package: ^1.0.0
```

Or use the following command:

```bash
flutter pub add audio_player_package
```

## Usage

### Initialize the player

```dart
final player = await AdvancedAudioPlayer.initialize(
  androidNotificationChannelId: 'com.example.audio_player',
  androidNotificationChannelName: 'Audio Player',
  androidNotificationOngoing: true,
);
```

### Play a track

```dart
final track = AudioTrack(
  id: '1',
  title: 'Song Title',
  artist: 'Artist Name',
  album: 'Album Name',
  url: 'https://example.com/song.mp3',
  artUri: 'https://example.com/cover.jpg',
);

player.playTrack(track);
```

### Play a playlist

```dart
final playlist = Playlist(
  id: 'playlist1',
  name: 'My Playlist',
  tracks: [track1, track2, track3],
);

player.playPlaylist(playlist);
```

### Basic playback controls

```dart
// Toggle play/pause
player.playPause();

// Stop playback
player.stop();

// Skip to next track
player.next();

// Skip to previous track
player.previous();

// Seek to position
player.seek(Duration(seconds: 30));

// Set volume (0.0 to 1.0)
player.setVolume(0.7);

// Set repeat mode
player.setRepeatMode(AudioServiceRepeatMode.all);

// Set shuffle mode
player.setShuffleMode(AudioServiceShuffleMode.all);
```

## UI Components

### Standard Audio Player Widget

```dart
AdvancedAudioPlayer.createBlocProvider(
  player: player,
  child: Scaffold(
    body: Center(
      child: AdvancedAudioPlayer.createAudioPlayerWidget(
        primaryColor: Colors.blue,
        backgroundColor: Colors.grey[200],
        height: 200,
        showCoverArt: true,
        showQueue: false,
      ),
    ),
  ),
);
```

### Standard Mini Player Widget

```dart
AdvancedAudioPlayer.createBlocProvider(
  player: player,
  child: Scaffold(
    bottomNavigationBar: AdvancedAudioPlayer.createMiniPlayerWidget(
      primaryColor: Colors.blue,
      backgroundColor: Colors.white,
      onTap: () {
        // Navigate to full player screen
      },
    ),
  ),
);
```

### Custom Audio Player Widget

The package provides highly customizable player widgets that allow you to change icons, colors, styles, and more:

```dart
AdvancedAudioPlayer.createCustomAudioPlayerWidget(
  primaryColor: Colors.purple,
  backgroundColor: Colors.grey[200],
  height: 250,
  playIcon: Icons.play_circle_filled,
  pauseIcon: Icons.pause_circle_filled,
  nextIcon: Icons.skip_next_rounded,
  previousIcon: Icons.skip_previous_rounded,
  stopIcon: Icons.stop_circle,
  shuffleIcon: Icons.shuffle_on,
  shuffleOffIcon: Icons.shuffle,
  repeatIcon: Icons.repeat,
  repeatOneIcon: Icons.repeat_one,
  repeatOffIcon: Icons.repeat,
  titleStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  ),
  artistStyle: TextStyle(
    fontSize: 14,
    color: Colors.grey[700],
  ),
  sliderActiveColor: Colors.purpleAccent,
  sliderInactiveColor: Colors.grey[300],
  sliderThumbColor: Colors.purple,
  onTrackChanged: (track) {
    // Handle track change
  },
  onPlayStateChanged: (isPlaying) {
    // Handle play state change
  },
);
```

### Custom Mini Player Widget

```dart
AdvancedAudioPlayer.createCustomMiniPlayerWidget(
  primaryColor: Colors.teal,
  backgroundColor: Colors.teal[50],
  height: 80,
  playIcon: Icons.play_arrow_rounded,
  pauseIcon: Icons.pause_rounded,
  titleStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.teal,
  ),
  artistStyle: TextStyle(
    fontSize: 12,
    color: Colors.grey[700],
  ),
  borderRadius: BorderRadius.circular(16),
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  onTap: () {
    // Show full player or navigate to player screen
  },
);
```

## Advanced Usage

### Accessing the BLoC directly

```dart
final bloc = player.bloc;

// Listen to state changes
bloc.stream.listen((state) {
  if (state is AudioPlayerReady) {
    // Handle ready state
  }
});

// Dispatch events
bloc.add(PlayTrack(track));
```

## Example

Check out the example app in the `example` directory for a complete implementation.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
