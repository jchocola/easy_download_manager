import 'package:easy_download_manager/core/models/download_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService() {
    _plugin = FlutterLocalNotificationsPlugin();
  }

  late final FlutterLocalNotificationsPlugin _plugin;

  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: androidInit,
    );
    await _plugin.initialize(initializationSettings);
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showDownloadSuccess(DownloadTask task) async {
    await _plugin.show(
      task.id.hashCode,
      'Download complete',
      task.fileName,
      _notificationDetails(),
    );
  }

  Future<void> showDownloadFailure(DownloadTask task) async {
    await _plugin.show(
      task.id.hashCode,
      'Download failed',
      task.error ?? task.fileName,
      _notificationDetails(),
    );
  }

  NotificationDetails _notificationDetails() {
    const androidDetails = AndroidNotificationDetails(
      'downloads_channel',
      'Downloads',
      channelDescription: 'Download status updates',
      importance: Importance.high,
      priority: Priority.high,
    );
    return const NotificationDetails(android: androidDetails);
  }
}

