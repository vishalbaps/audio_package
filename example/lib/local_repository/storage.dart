import 'dart:convert';
import 'package:async/async.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:audio_player_package_example/model/download_model.dart';

@lazySingleton
class Storage {
  final GetStorage _dataStorage;

  Storage(this._dataStorage);

  @FactoryMethod(preResolve: true)
  static Future<Storage> init() async {
    const dataKey = '_data_storage';
    await GetStorage.init(dataKey);
    final dataStorage = GetStorage(dataKey);
    return Storage(dataStorage);
  }

  Future<Result<ParentDownloadModel>> getDownloads() async {
    try {
      final json = _dataStorage.read(ParentDownloadModel.getKey);
      if (json == null) {
        return Result.error("No cache found");
      }
      final model = ParentDownloadModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
      return Result.value(model);
    } catch (e) {
      return Result.error("Failed to load downloads");
    }
  }

  Future<Result<void>> setDownloads(ParentDownloadModel data) async {
    try {
      await _dataStorage.write(ParentDownloadModel.getKey, jsonEncode(data.toJson()));
      return Result.value(null);
    } catch (e) {
      return Result.error("Failed to save downloads");
    }
  }

  Future<void> clearDownloads() async {
    await _dataStorage.remove(ParentDownloadModel.getKey);
  }
}
