import 'package:audio_player_package/audio_player_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/audio_bloc.dart';

class MiniPlayerBottom extends StatelessWidget {
  final void Function(List<AudioContent> album, AudioContent currentTrack)? onTapView;
  final void Function(List<AudioContent> album, AudioContent track)? onTapQueueIcon;
  final BoxDecoration? decoration;
  final double? height;
  final double imageRadius;
  final double tileCornerRadius;
  final double imageSize;
  final bool isShowQueueIcon;
  final IconData queueIcon;

  const MiniPlayerBottom({
    super.key,
    this.onTapView,
    this.onTapQueueIcon,
    this.decoration,
    this.height = 70,
    this.imageRadius = 8,
    this.tileCornerRadius = 0,
    this.imageSize = 42,
    this.isShowQueueIcon = true,
    this.queueIcon = Icons.queue_music,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (_, state) {
        final track = state.audioContent;
        if (track == null) return const SizedBox.shrink();
        return Material(
          child: Container(
            height: height,
            decoration:
                decoration ??
                BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(tileCornerRadius),
                    topLeft: Radius.circular(tileCornerRadius),
                  ),
                ),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(imageRadius),
                  child:
                      track.thumbUrl != null && track.thumbUrl!.isNotEmpty
                          ? Image.network(track.thumbUrl!, width: imageSize, height: imageSize, fit: BoxFit.cover)
                          : Container(
                            width: imageSize,
                            height: imageSize,
                            color: Colors.grey,
                            child: const Icon(Icons.music_note, color: Colors.white),
                          ),
                ),
              ),
              title: Text(track.contentTitle, style: const TextStyle(color: Colors.white)),
              subtitle:
                  track.artist != null ? Text(track.artist!, style: const TextStyle(color: Colors.white70)) : null,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PlayPauseButton(currentTrack: track, album: state.album ?? [], iconColor: Colors.white),
                  isShowQueueIcon
                      ? IconButton(
                        icon: Icon(queueIcon, color: Colors.white),
                        onPressed: () {
                          onTapQueueIcon?.call(state.album ?? [], track);
                        },
                      )
                      : SizedBox(),
                ],
              ),
              onTap: () => onTapView?.call(state.album ?? [], track),
            ),
          ),
        );
      },
    );
  }
}
