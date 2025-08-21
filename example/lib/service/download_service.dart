import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:audio_player_package_example/model/download_model.dart';

import '../local_repository/storage.dart';
import '../manager/download_manager.dart';

abstract class DownloadService {
  Future<Result<List<DownloadModel>>> getDownloadedFiles();

  Future<void> deleteDownloadedFile(DownloadModel file);

  Future<void> setDownloadedFile(List<DownloadModel> downloadedFile);

  Stream<List<DownloadModel>> get setDownloadedFileStream;
}

@Singleton(as: DownloadService)
class ImplDownloadService implements DownloadService {
  final Storage _storage;
  final DownloadManager _downloadManager;

  final List<DownloadModel> _downloadedFiles = [];
  final StreamController<List<DownloadModel>> _controller = StreamController<List<DownloadModel>>.broadcast();

  ImplDownloadService(this._storage, this._downloadManager) {
    // Listen for download complete events
    _downloadManager.downloadStatus.listen((state) async {
      if (state.status == DownloaderStatus.complete &&
          state.audioUrl.isNotEmpty &&
          state.downloadedAudioUrl.isNotEmpty) {
        final model = DownloadModel(
          audioUrl: state.audioUrl,
          downloadedAudioUrl: state.downloadedAudioUrl,
        );

        _downloadedFiles.add(model);
        await _save();

        _controller.add(List.from(_downloadedFiles));
      }
    });
  }

  @override
  Stream<List<DownloadModel>> get setDownloadedFileStream => _controller.stream;

  @override
  Future<Result<List<DownloadModel>>> getDownloadedFiles() async {
    final resp = await _storage.getDownloads();

    if (resp.isValue) {
      final docs = resp.asValue!.value.documents;
      _downloadedFiles
        ..clear()
        ..addAll(docs);
      return Result.value(_downloadedFiles);
    }

    return Result.value([]);
  }

  @override
  Future<void> deleteDownloadedFile(DownloadModel file) async {
    try {
      final f = File(file.downloadedAudioUrl);
      if (await f.exists()) {
        await f.delete();
      }

      _downloadedFiles.removeWhere((e) => e.downloadedAudioUrl == file.downloadedAudioUrl);

      await _save();
      _controller.add(List.from(_downloadedFiles));
    } catch (_) {}
  }

  Future<void> _save() async {
    await _storage.setDownloads(
      ParentDownloadModel(documents: _downloadedFiles),
    );
  }

  @override
  Future<void> setDownloadedFile(List<DownloadModel> downloadedFile) async {
    _downloadedFiles
      ..clear()
      ..addAll(downloadedFile);

    await _save();
    _controller.add(List.from(_downloadedFiles));
  }
}
