# Advanced Audio Player Package

A feature-rich, highly customizable audio player package for Flutter apps. It supports playlists, full media controls, beautiful UI components, and background playback with BLoC integration.

## Features

- 🎵 Play single tracks or full playlists
- 🎮 Full playback controls (play, pause, stop, seek, next, previous)
- 🎨 Customizable widgets (mini player, full player, tiles, buttons, etc.)
- 🧭 Top and bottom mini player support via NavigationScreen
- 📱 Background playback with notification controls
- 🧩 BLoC state management
- ⚙️ Easily pluggable in any Flutter app

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


🧱 Architecture Overview
- Player Initialization: Done inside AudioPlayerWrapper
- UI Layout: Managed with NavigationScreen
- Playback State: Managed via AudioBloc
- Seekbar State: Managed via SliderSeekBloc
- Mini Player: Always active when a track is playing


## Getting Started
- 1️⃣ Wrap the App with AudioPlayerWrapper


```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AudioPlayerWrapper(
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
```

- 2️⃣ Use NavigationScreen to Get Mini Player Support

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationScreen(
      appbar: AppBar(title: const Text("Screen name")),
      miniPlayerType: MiniPlayerType.bottom, // or MiniPlayerType.top
      child: AudioPlayerTile(album: albumList),
    );
  }
}

```


## Widgets

- 🎵 AudioPlayerTile (List of Tracks)

```dart
AudioPlayerTile(
  album: albumList,
  imageSize: 48,
  titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  subTitleStyle: TextStyle(fontSize: 12),
);
```

- Displays track info with artwork
- Includes inline play/pause buttons
- Easily themeable


## Playback Controls

- ▶️ Play/Pause

```dart
PlayPauseButton(currentTrack: track, album: albumList)
```


- ⏭️ Next

```dart
NextButton(iconColor: Colors.green)
```


- ⏮️ Previous

```dart
PreviousButton(iconColor: Colors.red)
```

- 📊 Seek Bar

```dart
AudioSeekBar(
activeColor: Colors.blueAccent,
inactiveColor: Colors.grey,
textStyle: TextStyle(fontSize: 12),
)
```

- Syncs with player position
- Drag-to-seek support
- Built with SliderSeekBloc

## Example

Check out the example app in the `example` directory for a complete implementation.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
