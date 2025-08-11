class AudioManagerConfig {
  final String androidNotificationChannelId;
  final String androidNotificationChannelName;
  final String androidNotificationIcon;
  final bool showNotificationBadge;
  final bool ongoingNotification;

  const AudioManagerConfig({
    required this.androidNotificationChannelId,
    required this.androidNotificationChannelName,
    required this.androidNotificationIcon,
    this.showNotificationBadge = true,
    this.ongoingNotification = true,
  });
}
