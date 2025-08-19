import 'package:audio_player_package/src/configure.dart';
import 'package:audio_player_package/src/models/audio_notification_settings.dart';
import 'package:audio_player_package/src/utils/audio_manager.dart';
import 'package:get_it/get_it.dart';

class AudioPlayerConfig {
  static Future<void> init({required AudioNotificationSettings audioNotificationSettings}) async {
    await configureDependencies();
    await GetIt.I.allReady();
    //because audio service should initialize only once in life time
    GetIt.I<AudioManager>().setup(
      androidNotificationChannelId: audioNotificationSettings.androidNotificationChannelId,
      androidNotificationChannelName: audioNotificationSettings.androidNotificationChannelName,
      androidNotificationIcon: audioNotificationSettings.androidNotificationIcon,
      showNotificationBadge: true,
      ongoingNotification: true,
    );
  }
}
