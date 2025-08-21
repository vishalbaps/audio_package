import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_model.g.dart';

@JsonSerializable()
class DownloadModel {
  final String audioUrl;
  final String downloadedAudioUrl;

  const DownloadModel({
    required this.audioUrl,
    this.downloadedAudioUrl = "",
  });

  factory DownloadModel.fromJson(Map<String, dynamic> json) => _$DownloadModelFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadModelToJson(this);

  DownloadModel copyWith({String? downloadedAudioUrl, String? audioUrl}) {
    return DownloadModel(
      audioUrl: audioUrl ?? this.audioUrl,
      downloadedAudioUrl: downloadedAudioUrl ?? this.downloadedAudioUrl,
    );
  }
}

@JsonSerializable()
class ParentDownloadModel {
  final List<DownloadModel> documents;

  const ParentDownloadModel({required this.documents});

  factory ParentDownloadModel.fromJson(Map<String, dynamic> json) => _$ParentDownloadModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParentDownloadModelToJson(this);

  static String get getKey => "parent_download_model";
}
