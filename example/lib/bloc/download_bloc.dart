import 'dart:io';
import 'package:audio_player_package_example/model/download_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../manager/download_manager.dart';
import '../service/download_service.dart';
import '../utils/enum.dart';

part 'download_bloc.freezed.dart';

@singleton
class DownloadBloc extends Bloc<_DownloadEvent, DownloadState> {
  final DownloadManager _downloadManager;
  final DownloadService _downloadService;

  DownloadBloc(this._downloadManager, this._downloadService) : super(const DownloadState()) {
    on<DownloadEventInitialize>((event, emit) async {
      emit(state.copyWith(loadingStatus: Status.process, downloaderStatus: DownloaderStatus.none));

      final resp = await _downloadService.getDownloadedFiles();

      if (resp.isError) {
        emit(state.copyWith(loadingStatus: Status.error));
        return;
      }

      emit(state.copyWith(
        loadingStatus: Status.done,
        downloadFileList: resp.asValue?.value ?? [],
      ));
    });

    on<DownloadEventAdd>((event, emit) async {
      DownloadModel downloadModel = event.downloadModel;

      if (state.downloaderStatus == DownloaderStatus.none) {
        emit(state.copyWith(
            downloaderStatus: DownloaderStatus.downloading,
            currentDownload: downloadModel,
            loadingStatus: Status.process));

        final added = await _downloadManager.download(downloadModel.audioUrl);

        if (added) {
          emit(state.copyWith(currentDownload: downloadModel, loadingStatus: Status.done));
        }
        return;
      }

      if (state.downloaderStatus == DownloaderStatus.downloading) {
        List<DownloadModel> value = state.downloadQueue.toList()
          ..removeWhere((e) => e.audioUrl == downloadModel.audioUrl)
          ..add(downloadModel)
          ..toSet().toList();

        emit(state.copyWith(downloadQueue: value));
      }
    });

    on<DownloadEventDownloaderStateUpdate>((event, emit) async {
      DownloaderStatus downloaderStatus = event.downloaderState.status;

      switch (event.downloaderState.status) {
        case DownloaderStatus.none:
          List<DownloadModel> queue = state.downloadQueue.toList()
            ..removeWhere((e) => e.audioUrl == state.currentDownload?.audioUrl);

          if (queue.isNotEmpty) {
            emit(state.copyWith(downloaderStatus: downloaderStatus));
            add(DownloadEventAdd(queue.first));
          } else {
            emit(state.copyWith(
                currentDownload: null,
                downloadQueue: [],
                currentDownloadPercent: 0,
                downloaderStatus: downloaderStatus));
          }
          break;
        case DownloaderStatus.downloading:
          break;
        case DownloaderStatus.error:
          List<DownloadModel> value = state.downloadQueue.toList()
            ..removeWhere((e) => e.audioUrl == state.currentDownload?.audioUrl);

          emit(state.copyWith(currentDownload: null, downloadQueue: value, downloaderStatus: downloaderStatus));
          break;
        case DownloaderStatus.complete:
          final value = state.downloadQueue.toList()..removeWhere((e) => e.audioUrl == state.currentDownload?.audioUrl);

          final List<DownloadModel> downloadedFile = state.downloadFileList.toList();

          if (state.currentDownload != null) {
            downloadedFile
                .add(state.currentDownload!.copyWith(downloadedAudioUrl: event.downloaderState.downloadedAudioUrl));
            _downloadService.setDownloadedFile(downloadedFile.toSet().toList());
          }

          emit(state.copyWith(
              currentDownload: null,
              downloadQueue: value,
              downloadFileList: downloadedFile,
              downloaderStatus: downloaderStatus));
          break;
        case DownloaderStatus.networkError:
          deleteFile(state.currentDownload);
          emit(state.copyWith(currentDownload: null, downloadQueue: [], downloaderStatus: downloaderStatus));
          break;
      }
    });

    on<DownloadEventUpdatePercent>((event, emit) async {
      emit(state.copyWith(currentDownloadPercent: event.percent));
    });

    on<DownloadEventDeleteAll>((event, emit) async {
      emit(const DownloadState(
          loadingStatus: Status.process,
          currentDownload: null,
          currentDownloadPercent: 0,
          downloadQueue: [],
          downloadFileList: []));
      _downloadManager.stop();

      List<Future> futureList = [];

      for (var e in state.downloadFileList.toList()) {
        futureList.add(deleteFile(e));
      }

      _downloadService.setDownloadedFile([]);
      await Future.wait(futureList);

      emit(state.copyWith(loadingStatus: Status.done));
    });

    on<DownloadEventDelete>((event, emit) async {
      final downloadedFile = state.downloadFileList.toList();
      emit(state.copyWith(loadingStatus: Status.process));
      for (var element in event.downloadFileList) {
        await deleteFile(element);
      }
      downloadedFile
          .removeWhere((element) => event.downloadFileList.map((e) => e.audioUrl).toList().contains(element.audioUrl));
      await _downloadService.setDownloadedFile(downloadedFile);
      emit(state.copyWith(loadingStatus: Status.done, downloadFileList: downloadedFile));
    });

    on<DownloadEventStop>((event, emit) async {
      _downloadManager.stop();
    });

    on<SetDownloadFileList>((event, emit) async {
      emit(state.copyWith(downloadFileList: event.downloadFileList));
    });

    _downloadManager.downloadStatus.listen((event) {
      add(DownloadEventDownloaderStateUpdate(event));
    });

    _downloadManager.downloadPercent.listen((event) {
      add(DownloadEventUpdatePercent(event));
    });

    _downloadService.setDownloadedFileStream.listen((data) {
      add(SetDownloadFileList(data));
    });
  }

  Future<void> deleteFile(DownloadModel? downloadModel) async {
    try {
      File file = File(downloadModel!.downloadedAudioUrl);
      await file.delete();
    } catch (_) {}
  }
}

@freezed
sealed class DownloadState with _$DownloadState {
  const factory DownloadState({
    @Default(Status.init) Status loadingStatus,
    @Default(null) DownloadModel? currentDownload,
    @Default(0.0) double currentDownloadPercent,
    @Default([]) List<DownloadModel> downloadQueue,
    @Default([]) List<DownloadModel> downloadFileList,
    @Default(DownloaderStatus.none) DownloaderStatus downloaderStatus,
  }) = _DownloadState;
}

sealed class _DownloadEvent {}

class DownloadEventInitialize extends _DownloadEvent {
  DownloadEventInitialize();
}

class DownloadEventAdd extends _DownloadEvent {
  final DownloadModel downloadModel;

  DownloadEventAdd(this.downloadModel);
}

class DownloadEventUpdatePercent extends _DownloadEvent {
  final double percent;

  DownloadEventUpdatePercent(this.percent);
}

class DownloadEventDownloaderStateUpdate extends _DownloadEvent {
  final DownloaderState downloaderState;

  DownloadEventDownloaderStateUpdate(this.downloaderState);
}

class DownloadEventStop extends _DownloadEvent {}

class DownloadEventDeleteAll extends _DownloadEvent {}

class DownloadEventDelete extends _DownloadEvent {
  final List<DownloadModel> downloadFileList;

  DownloadEventDelete(this.downloadFileList);
}

class SetDownloadFileList extends _DownloadEvent {
  final List<DownloadModel> downloadFileList;

  SetDownloadFileList(this.downloadFileList);
}
