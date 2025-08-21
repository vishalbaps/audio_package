import 'package:audio_player_package_example/utils/connections.dart';
import 'package:injectable/injectable.dart';

import 'manager/download_manager.dart';

@module
abstract class RegisterModule {

  @singleton
  InternetConnectivity get internetConnectivity => InternetConnectivity.init();

  @singleton
  DownloadManager get downloadManager => DownloadManager(internetConnectivity);


}
