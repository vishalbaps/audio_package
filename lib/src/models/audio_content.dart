import 'dart:convert';

import 'package:audio_player_package/src/utils/string_utils.dart';
import 'package:audio_service/audio_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/constants.dart';

part 'audio_content.g.dart';

@JsonSerializable()
class AudioContent {
  String contentId;
  String contentTitle;
  String? subTitle;
  String? description;
  String? thumbUrl;
  String? artist;
  String? album;
  String audioUrl;
  String? downloadedAudioUrl;

  AudioContent({
    required this.contentId,
    required this.contentTitle,
    this.subTitle,
    this.description,
    this.thumbUrl,
    this.artist,
    this.album,
    this.downloadedAudioUrl,
    required this.audioUrl,
  });

  AudioContent copyWith({
    String? contentId,
    String? contentTitle,
    String? subTitle,
    String? description,
    String? thumbUrl,
    String? artist,
    String? album,
    String? audioUrl,
    String? downloadedAudioUrl,
  }) {
    return AudioContent(
      contentId: contentId ?? this.contentId,
      contentTitle: contentTitle ?? this.contentTitle,
      subTitle: subTitle ?? this.subTitle,
      description: description ?? this.description,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      audioUrl: audioUrl ?? this.audioUrl,
      downloadedAudioUrl: downloadedAudioUrl ?? this.downloadedAudioUrl,
    );
  }

  factory AudioContent.empty() {
    return AudioContent(contentId: '', audioUrl: '', contentTitle: '');
  }

  AudioContent copy() => AudioContent.fromJson(jsonDecode(jsonEncode(this)));

  factory AudioContent.fromJson(Map<String, dynamic> json) => _$AudioContentFromJson(json);

  Map<String, dynamic> toJson() => _$AudioContentToJson(this);
}

extension ContentExtraFunction on AudioContent {
  MediaItem get media {
    final iconUri = thumbUrl.hasValue ? Uri.tryParse(thumbUrl!) : Uri.parse(AudioConsts.defaultAssetsLogo);

    return MediaItem(
      //id is take care as a audio url
      id: audioUrl,
      title: contentTitle,
      displayTitle: contentTitle,
      displayDescription: description,
      artist: artist,
      album: album,
      artUri: iconUri,
      extras: {"contentId": contentId, "subTitle": subTitle},
    );
  }
}

extension AudioContentFunction on MediaItem {
  AudioContent get audioContent {
    return AudioContent(
      contentId: extras?["contentId"],
      contentTitle: title,
      audioUrl: id,
      artist: artist,
      album: album,
      subTitle: extras?["subTitle"],
      description: displayDescription,
      thumbUrl: artUri?.toString(),
    );
  }
}
