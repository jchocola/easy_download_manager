import 'dart:convert';

import 'package:dtorrent_parser/dtorrent_parser.dart';
import 'package:dtorrent_task/dtorrent_task.dart';
import 'package:easy_download_manager/data/repository/flutter_torrent_downloader_impl.dart';
import 'package:easy_download_manager/main.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:path_provider/path_provider.dart';

// The callback function should always be a top-level or static function.
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

///
/// TASK HANDLER
///
class MyTaskHandler extends TaskHandler {
  late TorrentTask torrentTask;
  late dynamic taskListener;

  // Called when the task is started.
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    logger.i('onStart  ${timestamp}');
  }

  // Called based on the eventAction set in ForegroundTaskOptions.
  @override
  void onRepeatEvent(DateTime timestamp) {
    logger.i('onRepeatEvent  ${timestamp}');
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    logger.e('onDestroy  ${timestamp}');
  }

  // Called when data is sent using `FlutterForegroundTask.sendDataToTask`.
  @override
  void onReceiveData(Object data) async {
    logger.i('onReceiveData: ${data.toString()}');

    logger.i('onReceiveData: ${data.toString()}');
    logger.i('onReceiveData: ${data.toString()}');

    final Torrent torrent = await FlutterTorrentDownloaderImpl()
        .createTorrentModel(torrentFilePath: data as String);

    print('🔴 FOREGROUND SERVICE - Torrent model created: ${torrent.name}');

    final saveDir = await getDownloadsDirectory();
    torrentTask = await FlutterTorrentDownloaderImpl().createTorrentTask(
      model: torrent,
      saveDir: saveDir!.path,
    );

    torrentTask.start();

    taskListener = torrentTask.createListener();
    // // Обрабатываем события торрент задачи
    taskListener.on<TaskCompleted>((event) {
      // Используем Bloc для эмитации события завершения
      // Это можно сделать через дополнительное событие или сохраняя ссылку на задачу
      logger.e('Torrent download completed: ${torrentTask.name}');
    });

    taskListener.on<TaskStarted>((event) {
      logger.e('Torrent download started ${torrentTask.name}');
    });

    taskListener.on<StateFileUpdated>((event) {
      // Можно отправлять обновления прогресса
      logger.e('Torrent progress updated: ${torrentTask.progress}');
    });

    taskListener.on<TaskStopped>((event) {
      // Можно отправлять обновления прогресса
      logger.e('Torrent Stopped: ${torrentTask.progress}');
    });

    // torrentTask = TorrentTask.

    // torrentTask.start()

    // create listener
  }

  // Called when the notification button is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    logger.i('onNotificationButtonPressed: $id');
  }

  // Called when the notification itself is pressed.
  @override
  void onNotificationPressed() {
    logger.i('onNotificationPressed');
  }

  // Called when the notification itself is dismissed.
  @override
  void onNotificationDismissed() {
    logger.i('onNotificationDismissed');
  }
}

///
/// Init Service
///

void initService() {
  final AndroidNotificationOptions androidNotificationOptions =
      AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        onlyAlertOnce: true,
      );
  final IOSNotificationOptions iosNotificationOptions = IOSNotificationOptions(
    showNotification: false,
    playSound: false,
  );
  final ForegroundTaskOptions foregroundTaskOptions = ForegroundTaskOptions(
    eventAction: ForegroundTaskEventAction.repeat(5000),
    autoRunOnBoot: true,
    autoRunOnMyPackageReplaced: true,
    allowWakeLock: true,
    allowWifiLock: true,
  );

  FlutterForegroundTask.init(
    androidNotificationOptions: androidNotificationOptions,
    iosNotificationOptions: iosNotificationOptions,
    foregroundTaskOptions: foregroundTaskOptions,
  );

  logger.i('Inited foreground task');
}

Future<ServiceRequestResult> startService() async {
  if (await FlutterForegroundTask.isRunningService) {
    return FlutterForegroundTask.restartService();
  } else {
    return FlutterForegroundTask.startService(
      serviceTypes: [ForegroundServiceTypes.dataSync],
      notificationTitle: 'Foreground Service is running',
      notificationText: 'Tap to return to the app',
      notificationInitialRoute: '/torrents',
      callback: startCallback,
    );
  }
}

Future<ServiceRequestResult> stopService() async {
  return FlutterForegroundTask.stopService();
}

///
/// SEND DATA FROM UI (MAIN ISOLATE)
///

Future<void> sendDataFromUI({required String torrentFilePath}) async {
  FlutterForegroundTask.sendDataToTask(torrentFilePath);
}
