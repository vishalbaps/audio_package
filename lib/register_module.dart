import 'package:audio_player_package/utils/audio_manager.dart';
import 'package:audio_player_package/utils/connections.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @singleton
  Future<AudioManager> get audioManager => AudioManager.init();

  @singleton
  InternetConnectivity get internetConnectivity => InternetConnectivity.init();
}
