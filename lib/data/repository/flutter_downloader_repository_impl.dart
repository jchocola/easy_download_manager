import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

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
            fileName: task.fileName,
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
      rethrow;
    }
  }

  ///
  /// GET ALL WORKING/DOWNLOADING TASKS
  ///

  Future<List<DownloadTask>> getAllDownloadingTasks() async {
    try {
      final List<DownloadTask>? tasks = await FlutterDownloader.loadTasks();

      if (tasks == null) {
        return [];
      }
      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// CANCEL A TASK
  ///

  void cancelTask({required String taskId}) {
    logger.i('Canceled task : $taskId');
    FlutterDownloader.cancel(taskId: taskId);
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

  // singleton
  FlutterDownloaderRepositoryImpl._();
  static final FlutterDownloaderRepositoryImpl _instance =
      FlutterDownloaderRepositoryImpl._();

  static FlutterDownloaderRepositoryImpl get instance => _instance;
}
