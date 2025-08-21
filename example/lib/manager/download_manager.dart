import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/connections.dart';

enum DownloaderStatus { none, downloading, error, complete, networkError }

class DownloaderState {
  DownloaderStatus status;
  String audioUrl;
  String downloadedAudioUrl;

  DownloaderState({required this.status, this.audioUrl = "", this.downloadedAudioUrl = ""});
}

class DownloadManager {
  final Dio _dio = Dio();
  CancelToken? _cancelToken;
  DownloaderStatus _currentStatus = DownloaderStatus.none;
  final InternetConnectivity _internetConnectivity;

  DownloadManager(this._internetConnectivity) {
    _downloadStatusController.sink.add(DownloaderState(status: _currentStatus));
    downloadStatus.listen((event) => _currentStatus = event.status);

    _internetConnectivity.myStream.listen((event) {
      if (event is Map<bool, bool> &&
          event.values.isNotEmpty &&
          !event.values.first &&
          _currentStatus == DownloaderStatus.downloading) {
        _downloadStatusController.sink.add(DownloaderState(status: DownloaderStatus.networkError));
        stop();
      }
    });
  }

  void dispose() {
    _downloadStatusController.close();
    _downloadPercentController.close();
  }

  final StreamController<DownloaderState> _downloadStatusController = StreamController<DownloaderState>.broadcast();
  final StreamController<double> _downloadPercentController = StreamController<double>.broadcast();

  Stream<DownloaderState> get downloadStatus => _downloadStatusController.stream;

  Stream<double> get downloadPercent => _downloadPercentController.stream;

  Future<bool> download(String url) async {
    if (_currentStatus != DownloaderStatus.none) {
      return false;
    }

    _downloadStatusController.sink.add(
      DownloaderState(status: DownloaderStatus.downloading),
    );

    try {
      List<String> segments = Uri.parse(url).path.split('/');

      if (segments.isNotEmpty) {
        // Extract filename
        String fileName = segments.lastWhere((s) => s.trim().isNotEmpty);

        // Append extension if missing
        if (!(fileName.split(".").length > 1)) fileName += ".mp3";

        String fullPath = await getAudioFilePath(fileName);

        await _download(url, fullPath);

        return true;
      }

      return false;
    } catch (e, _) {
      return false;
    }
  }

  Future<String> getAudioFilePath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final audioDir = Directory("${dir.path}/audio");

    if (!(await audioDir.exists())) {
      await audioDir.create(recursive: true);
    }

    return "${audioDir.path}/$fileName";
  }

  void stop() {
    _cancelToken?.cancel();
    _downloadPercentController.sink.add(0);
    _downloadStatusController.sink.add(DownloaderState(status: DownloaderStatus.none));
  }

  Future<void> _download(String audioUrl, String downloadedAudioUrl) async {
    try {
      _cancelToken = CancelToken();
      var resp = await _dio.download(
        audioUrl,
        downloadedAudioUrl,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          if (total == -1 || total == 0) {
            _downloadPercentController.sink.add(100);
          } else {
            _downloadPercentController.sink.add((received / total) * 100);
          }
        },
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return (status ?? 0) < 500;
          },
        ),
      );

      _downloadPercentController.sink.add(0);

      if (resp.statusCode == 200) {
        _downloadStatusController.sink.add(
          DownloaderState(
            status: DownloaderStatus.complete,
            audioUrl: audioUrl,
            downloadedAudioUrl: downloadedAudioUrl,
          ),
        );
      } else {
        _downloadStatusController.sink.add(DownloaderState(status: DownloaderStatus.error));
        deleteFile(File(downloadedAudioUrl));
      }
      _downloadStatusController.sink.add(DownloaderState(status: DownloaderStatus.none));
    } catch (e, _) {
      _downloadPercentController.sink.add(0);

      _downloadStatusController.sink.add(DownloaderState(status: DownloaderStatus.error));
      _downloadStatusController.sink.add(DownloaderState(status: DownloaderStatus.none));
    }
  }

  void deleteFile(File file) async {
    try {
      await file.delete();
    } catch (_) {}
  }
}
