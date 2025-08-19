// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioContent _$AudioContentFromJson(Map<String, dynamic> json) => AudioContent(
  contentId: json['contentId'] as String,
  contentTitle: json['contentTitle'] as String,
  subTitle: json['subTitle'] as String?,
  description: json['description'] as String?,
  thumbUrl: json['thumbUrl'] as String?,
  artist: json['artist'] as String?,
  album: json['album'] as String?,
  downloadedAudioUrl: json['downloadedAudioUrl'] as String?,
  audioUrl: json['audioUrl'] as String,
);

Map<String, dynamic> _$AudioContentToJson(AudioContent instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'contentTitle': instance.contentTitle,
      'subTitle': instance.subTitle,
      'description': instance.description,
      'thumbUrl': instance.thumbUrl,
      'artist': instance.artist,
      'album': instance.album,
      'audioUrl': instance.audioUrl,
      'downloadedAudioUrl': instance.downloadedAudioUrl,
    };
