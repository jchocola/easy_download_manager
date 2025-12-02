import 'dart:io';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_foreground_task/models/notification_permission.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerRepositoryImpl {
  Future<void> notificationRequest() async {
    await Permission.notification.request();
  }

  Future<void> requestNotificationForForegroundTask() async {
    final NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();

    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    // for android
    if (Platform.isAndroid) {
      // Android 12+, there are restrictions on starting a foreground service.

      // To restart the service on device reboot or unexpected problem, you need to allow below permission.
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }

      // Use this utility only if you provide services that require long-term survival,
      // such as exact alarm service, healthcare service, or Bluetooth communication.

      // This utility requires the "android.permission.SCHEDULE_EXACT_ALARM" permission.
      // Using this permission may make app distribution difficult due to Google policy.

      if (!await FlutterForegroundTask.canScheduleExactAlarms) {
        // When you call this function, will be gone to the settings page. 
      // So you need to explain to the user why set it.
       await FlutterForegroundTask.openAlarmsAndRemindersSettings();
      }
    }
  }

  // SINGLETONE

  // singleton
  PermissionHandlerRepositoryImpl._();
  static final PermissionHandlerRepositoryImpl _instance =
      PermissionHandlerRepositoryImpl._();

  static PermissionHandlerRepositoryImpl get instance => _instance;
}
