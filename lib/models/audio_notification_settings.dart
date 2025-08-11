class AudioNotificationSettings {
  final String androidNotificationChannelId;
  final String androidNotificationChannelName;
  final String androidNotificationIcon;
  final bool showNotificationBadge;
  final bool ongoingNotification;

  AudioNotificationSettings({
    required this.androidNotificationChannelId,
    required this.androidNotificationChannelName,
    required this.androidNotificationIcon,
    this.showNotificationBadge = false,
    this.ongoingNotification = false,
  });
}
