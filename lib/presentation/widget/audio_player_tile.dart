import 'package:audio_player_package/audio_player_package.dart';
import 'package:audio_player_package/presentation/widget/play_pause_button.dart';
import 'package:flutter/material.dart';
import '../../models/audio_content.dart';

class AudioPlayerTile extends StatelessWidget {
  final List<AudioContent> album;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final double? imageSize;

  final BoxDecoration? tileDecoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double imageBoarderRadius;
  final double tileBorderRadius;
  final void Function(List<AudioContent> album, AudioContent currentTrack)? onTapView;

  const AudioPlayerTile({
    super.key,
    required this.album,
    this.titleStyle,
    this.subTitleStyle,
    this.imageSize = 42,
    this.tileDecoration,
    this.padding,
    this.margin,
    this.imageBoarderRadius = 8,
    this.tileBorderRadius = 12,
    this.onTapView,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: album.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: margin ?? const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final track = album[index];
        return InkWell(
          onTap: () => onTapView?.call(album, track),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration:
                tileDecoration ??
                BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(tileBorderRadius)),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(imageBoarderRadius),
                child:
                    track.thumbUrl != null && track.thumbUrl!.isNotEmpty
                        ? Image.network(
                          track.thumbUrl!,
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.cover,
                        )
                        : Container(
                          width: imageSize,
                          height: imageSize,
                          color: Colors.grey,
                          child: const Icon(Icons.music_note, color: Colors.white),
                        ),
              ),
              title: Text(
                track.contentTitle,
                style: titleStyle ?? TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle:
                  track.artist != null
                      ? Text(
                        track.artist!,
                        style: subTitleStyle ?? TextStyle(color: Colors.black.withValues(alpha: 0.7)),
                      )
                      : null,
              trailing: PlayPauseButton(currentTrack: track, album: album),
            ),
          ),
        );
      },
    );
  }
}
