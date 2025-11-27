import 'package:easy_download_manager/core/enum/download_card_status.dart';
import 'package:easy_download_manager/domain/models/download_task.dart'
    as DownloadTaskModel;
import 'package:easy_download_manager/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class FlutterDownloaderRepositoryImpl {
  Future<void> initPlugin() async {
    await FlutterDownloader.initialize(
      debug:
          kDebugMode, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true, // option: set to false to disable working with http links (default: false)
    ).then((value) {
      logger.i('flutter downloader inited');
    });
  }

  ///
  /// START DOWNLOADING AND RETURN TASK ID
  ///
  Future<String> createNewTask({
    required DownloadTaskModel.DownloadTask task,
  }) async {
    try {
      final taskId =
          await FlutterDownloader.enqueue(
            url: task.url,
            savedDir: task.directory,
            //fileName: task.fileName,
            showNotification: true,
            openFileFromNotification: true,
          ).then((value) {
            logger.i('CreatedTask : $value');
          });
      if (taskId == null) {
        throw Exception('Unknown error');
      }
      return taskId;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  ///
  /// GET ALL WORKING/DOWNLOADING TASKS
  ///

  Future<List<DownloadTask>> getAllDownloadingTasks() async {
    try {
      final List<DownloadTask>? tasks = await FlutterDownloader.loadTasks();
      final activeTasks = tasks?.where((e) {
        return e.status == DownloadTaskStatus.running;
      }).toList();

      return activeTasks ?? [];
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// CANCEL A TASK
  ///

  Future<void> cancelTask({required String taskId}) async {
    logger.i('Canceled task : $taskId');
    await FlutterDownloader.cancel(taskId: taskId);
    await FlutterDownloader.remove(taskId: taskId);
  }

  ///
  /// CANCEL ALL TASKS
  ///

  Future<void> cancelAllTasks() async {
    await FlutterDownloader.cancelAll();
    logger.i('Canceled all tasks');
  }

  ///
  /// PAUSE TASK
  ///
  Future<void> pauseTask({required String taskId}) async {
    await FlutterDownloader.pause(taskId: taskId);
    logger.i('Paused task : $taskId');
  }

  ///
  /// RESUME TASK - RETURN NEW ID TASK
  ///

  Future<String> resumeTask({required String taskId}) async {
    final newTaskId = await FlutterDownloader.resume(taskId: taskId);
    logger.i('Resumed task : $taskId');
    logger.i('New task Id : $newTaskId');

    if (newTaskId == null) {
      throw Exception('Unknown error');
    }
    return newTaskId;
  }

  ///
  /// RETRY FAILED TASK - RETURN NEW ID TASK
  ///

  Future<String> retryFailedTask({required String taskId}) async {
    final newTaskId = await FlutterDownloader.retry(taskId: taskId);
    logger.i('Retryed task : $taskId');
    logger.i('New task Id : $newTaskId');

    if (newTaskId == null) {
      throw Exception('Unknown error');
    }
    return newTaskId;
  }

  ///
  /// REMOVE TASK
  ///

  Future<void> removeTask({required String taskId}) async {
    await FlutterDownloader.remove(
      taskId: taskId,
      shouldDeleteContent: false,
    ).then((value) {
      logger.i('Deleted task : $taskId');
    });
  }

  ///
  /// OPEN FILE
  ///
  Future<bool> openFile({required String taskId}) async {
    try {
      final res = await FlutterDownloader.open(taskId: taskId);

      logger.i('Open file : $res');
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getActiveTasksCount() async {
    try {
      final allTasks = await FlutterDownloader.loadTasks();

      final activeTasks = allTasks?.where((e) {
        return e.status == DownloadTaskStatus.running ||
            e.status == DownloadTaskStatus.enqueued;
      }).toList();

      return activeTasks?.length ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<int> getCompleteTasksCount() async {
    try {
      final allTasks = await FlutterDownloader.loadTasks();

      final completeTask = allTasks?.where((e) {
        return e.status == DownloadTaskStatus.complete;
      }).toList();

      return completeTask?.length ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<List<DownloadTask>> getCompleteTasks() async {
    try {
      final allTasks = await FlutterDownloader.loadTasks();

      final completeTask = allTasks?.where((e) {
        return e.status == DownloadTaskStatus.complete;
      }).toList();

      return completeTask ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<List<DownloadTask>> getPausedTasks() async {
    try {
      final allTasks = await FlutterDownloader.loadTasks();

      final pausedTask = allTasks?.where((e) {
        return e.status == DownloadTaskStatus.paused;
      }).toList();

      return pausedTask ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<List<DownloadTask>> getFailedTasks() async {
    try {
      final allTasks = await FlutterDownloader.loadTasks();

      final failedTask = allTasks?.where((e) {
        return e.status == DownloadTaskStatus.failed;
      }).toList();

      return failedTask ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<int> getErrorTasksCount() async {
    try {
      final allTasks = await FlutterDownloader.loadTasks();

      final faileds = allTasks?.where((e) {
        return e.status == DownloadTaskStatus.failed;
      }).toList();

      return faileds?.length ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<int> getPausedTasksCount() async {
    try {
      final allTasks = await FlutterDownloader.loadTasks();

      final paused = allTasks?.where((e) {
        return e.status == DownloadTaskStatus.paused;
      }).toList();

      return paused?.length ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // singleton
  FlutterDownloaderRepositoryImpl._();
  static final FlutterDownloaderRepositoryImpl _instance =
      FlutterDownloaderRepositoryImpl._();

  static FlutterDownloaderRepositoryImpl get instance => _instance;
}
