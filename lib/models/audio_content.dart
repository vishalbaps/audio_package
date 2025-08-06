import 'dart:convert';

import 'package:audio_player_package/utils/string_utils.dart';
import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/constants.dart';

part 'audio_content.g.dart';

@JsonSerializable()
class AudioContent extends Equatable{
  String contentId;
  String contentTitle;
  String? subTitle;
  String? description;
  String? thumbUrl;
  String? artist;
  String? album;
  String url;

  AudioContent({
    required this.contentId,
    required this.contentTitle,
    this.subTitle,
    this.description,
    this.thumbUrl,
    this.artist,
    this.album,
    required this.url,
  });

  AudioContent copy() => AudioContent.fromJson(jsonDecode(jsonEncode(this)));

  factory AudioContent.fromJson(Map<String, dynamic> json) => _$AudioContentFromJson(json);

  Map<String, dynamic> toJson() => _$AudioContentToJson(this);

  @override
  List<Object?> get props => [contentId];
}

extension ContentExtraFunction on AudioContent {
  MediaItem get media {
    final iconUri = thumbUrl.hasValue ? Uri.tryParse(thumbUrl!) : Uri.parse(AudioConsts.defaultAssetsLogo);

    return MediaItem(
      //id is take care as a audio url
      id: url,
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
      url: id,
      artist: artist,
      album: album,
      subTitle: extras?["subTitle"],
      description: displayDescription,
      thumbUrl: artUri?.toString(),
    );
  }
}
