import 'package:audio_player_package/audio_player_package.dart';
import 'package:audio_player_package/presentation/widget/play_pause_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/audio_content.dart';

class AudioPlayerTile extends StatefulWidget {
  final List<AudioContent> album;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final double? imageSize;

  final BoxDecoration? tileDecoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double imageBoarderRadius;
  final double tileBorderRadius;

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
  });

  @override
  State<AudioPlayerTile> createState() => _AudioPlayerTileState();
}

class _AudioPlayerTileState extends State<AudioPlayerTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.album.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: widget.margin ?? const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) {
        final track = widget.album[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration:
              widget.tileDecoration ??
              BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(widget.tileBorderRadius),
              ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(widget.imageBoarderRadius),
              child:
                  track.thumbUrl != null && track.thumbUrl!.isNotEmpty
                      ? Image.network(
                        track.thumbUrl!,
                        width: widget.imageSize,
                        height: widget.imageSize,
                        fit: BoxFit.cover,
                      )
                      : Container(
                        width: widget.imageSize,
                        height: widget.imageSize,
                        color: Colors.grey,
                        child: const Icon(Icons.music_note, color: Colors.white),
                      ),
            ),
            title: Text(
              track.contentTitle,
              style: widget.titleStyle ?? TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle:
                track.artist != null
                    ? Text(
                      track.artist!,
                      style: widget.subTitleStyle ?? TextStyle(color: Colors.black.withValues(alpha: 0.7)),
                    )
                    : null,
            trailing: PlayPauseButton(currentTrack: track, album: widget.album),
          ),
        );
      },
    );
  }
}
