import 'dart:convert';

import 'package:dtorrent_parser/dtorrent_parser.dart';
import 'package:dtorrent_task/dtorrent_task.dart';
import 'package:easy_download_manager/data/repository/flutter_torrent_downloader_impl.dart';
import 'package:easy_download_manager/data/repository/local_torrent_db_impl.dart';
import 'package:easy_download_manager/domain/models/torrent_task_model.dart';
import 'package:easy_download_manager/main.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

// The callback function should always be a top-level or static function.
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(TorrentTaskHandler());
}

///
/// TASK HANDLER
///
class TorrentTaskHandler extends TaskHandler {
  final LocalTorrentDbImpl _localTorrentDb = LocalTorrentDbImpl();
  late TorrentTask torrentTask;
  late dynamic taskListener;
  late TorrentTaskModel taskModel;

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

    if (torrentTask.progress < 1) {
      final taskModelWithNewData = taskModel.copyWith(
        status: TORRENT_TASK_STATUS.TaskPaused,
        progress: torrentTask.progress,
        currentDownloadSpeed: torrentTask.currentDownloadSpeed,
        averageDownloadSpeed: torrentTask.averageDownloadSpeed,
        allPeersNumber: torrentTask.allPeersNumber,
        connectedPeersNumber: torrentTask.connectedPeersNumber,
        seederNumber: torrentTask.seederNumber,
        downloaded: torrentTask.downloaded,
      );
      torrentTask.pause(); 

      await _localTorrentDb.updateTorrentTask(
        torrentTask: taskModelWithNewData,
      );
    }
  }

  // Called when data is sent using `FlutterForegroundTask.sendDataToTask`.
  @override
  void onReceiveData(Object data) async {
    logger.i('onReceiveData: ${data.toString()}');

    late String torrentFilePath;
    late String saveDir;
    try {
      final map = data as Map<String, dynamic>;

      logger.d(map['torrentFilePath']);
      logger.d(map['saveDir']);

      torrentFilePath = map['torrentFilePath'];
      saveDir = map['saveDir'];
    } catch (e) {
      logger.e('error');
    }

    final Torrent torrent = await FlutterTorrentDownloaderImpl()
        .createTorrentModel(torrentFilePath: torrentFilePath);

    logger.e('🔴 FOREGROUND SERVICE - Torrent model created: ${torrent.name}');

    torrentTask = await FlutterTorrentDownloaderImpl().createTorrentTask(
      model: torrent,
      saveDir: saveDir,
    );

    /// create torrent task in db
    taskModel = TorrentTaskModel(
      id: Uuid().v4(),
      name: torrentTask.name,
      filePath: torrentFilePath,
      saveDir: saveDir,
      progress: torrentTask.progress,
      status: TORRENT_TASK_STATUS.TaskStarted,
      downloaded: 0,
      speed: torrentTask.currentDownloadSpeed,
      allPeersNumber: torrentTask.allPeersNumber,
      total: torrent.length,
      connectedPeersNumber: torrentTask.connectedPeersNumber,
      seederNumber: torrentTask.seederNumber,
      currentDownloadSpeed: torrentTask.currentDownloadSpeed,
      averageDownloadSpeed: torrentTask.averageDownloadSpeed,
    );
    // save to db

    await _localTorrentDb.saveNewTorrentTask(torrentTask: taskModel);
    logger.e(
      '🔴 FOREGROUND SERVICE - Torrent task saved to db: ${torrentTask.name}',
    );

    /// start torrent download
    torrentTask.start();

    /// creating listener
    taskListener = torrentTask.createListener();
    // // Обрабатываем события торрент задачи
    taskListener.on<TaskCompleted>((event) async {
      // Используем Bloc для эмитации события завершения
      // Это можно сделать через дополнительное событие или сохраняя ссылку на задачу
      logger.e('Torrent download completed: ${torrentTask.name}');

      final taskModelWithNewData = taskModel.copyWith(
        status: TORRENT_TASK_STATUS.TaskCompleted,
        progress: torrentTask.progress,
        currentDownloadSpeed: torrentTask.currentDownloadSpeed,
        averageDownloadSpeed: torrentTask.averageDownloadSpeed,
        allPeersNumber: torrentTask.allPeersNumber,
        connectedPeersNumber: torrentTask.connectedPeersNumber,
        seederNumber: torrentTask.seederNumber,
        downloaded: torrentTask.downloaded,
      );
      await _localTorrentDb.updateTorrentTask(
        torrentTask: taskModelWithNewData,
      );

      // stop foreground service
      await stopService();
    });

    taskListener.on<TaskStarted>((event) async {
      logger.e('Torrent download started ${torrentTask.name}');

      final taskModelWithNewData = taskModel.copyWith(
        status: TORRENT_TASK_STATUS.TaskStarted,
        progress: torrentTask.progress,
        currentDownloadSpeed: torrentTask.currentDownloadSpeed,
        averageDownloadSpeed: torrentTask.averageDownloadSpeed,
        allPeersNumber: torrentTask.allPeersNumber,
        connectedPeersNumber: torrentTask.connectedPeersNumber,
        seederNumber: torrentTask.seederNumber,
        downloaded: torrentTask.downloaded,
      );
      await _localTorrentDb.updateTorrentTask(
        torrentTask: taskModelWithNewData,
      );
    });

    taskListener.on<StateFileUpdated>((event) async {
      // Можно отправлять обновления прогресса
      logger.e('Torrent progress updated: ${torrentTask.progress}');

      final taskModelWithNewData = taskModel.copyWith(
        status: TORRENT_TASK_STATUS.TaskStarted,
        progress: torrentTask.progress,
        currentDownloadSpeed: torrentTask.currentDownloadSpeed,
        averageDownloadSpeed: torrentTask.averageDownloadSpeed,
        allPeersNumber: torrentTask.allPeersNumber,
        connectedPeersNumber: torrentTask.connectedPeersNumber,
        seederNumber: torrentTask.seederNumber,
        downloaded: torrentTask.downloaded,
      );
      await _localTorrentDb.updateTorrentTask(
        torrentTask: taskModelWithNewData,
      );
    });

    taskListener.on<TaskStopped>((event) async {
      // Можно отправлять обновления прогресса
      logger.e('Torrent Stopped: ${torrentTask.progress}');

      final taskModelWithNewData = taskModel.copyWith(
        status: TORRENT_TASK_STATUS.TaskStopped,
        progress: torrentTask.progress,
        currentDownloadSpeed: torrentTask.currentDownloadSpeed,
        averageDownloadSpeed: torrentTask.averageDownloadSpeed,
        allPeersNumber: torrentTask.allPeersNumber,
        connectedPeersNumber: torrentTask.connectedPeersNumber,
        seederNumber: torrentTask.seederNumber,
        downloaded: torrentTask.downloaded,
      );
      await _localTorrentDb.updateTorrentTask(
        torrentTask: taskModelWithNewData,
      );
    });
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

Future<void> sendDataFromUI({
  required String torrentFilePath,
  required String saveDir,
}) async {
  final Map<String, dynamic> sendData = {
    'torrentFilePath': torrentFilePath,
    'saveDir': saveDir,
  };

  FlutterForegroundTask.sendDataToTask(sendData);
}
