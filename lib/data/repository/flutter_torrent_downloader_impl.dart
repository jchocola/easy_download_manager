import 'dart:async';

import 'package:dtorrent_parser/dtorrent_parser.dart';
import 'package:dtorrent_task/dtorrent_task.dart';
import 'package:easy_download_manager/domain/models/torrent_task_model.dart';

class FlutterTorrentDownloaderImpl {
  Future<Torrent> createTorrentModel({required String torrentFilePath}) async {
    try {
      return await Torrent.parse(torrentFilePath);
    } catch (e) {
      rethrow;
    }
  }

  Future<TorrentTask> createTorrentTask({
    required Torrent model,
    required String saveDir,
  }) async {
    try {
      return TorrentTask.newTask(model, saveDir, true);
    } catch (e) {
      rethrow;
    }
    
  }

  // Stream<TorrentTaskProgress> taskProgressMonitoring({
  //   required TorrentTask task,
  // }) async* {
  //   final StreamController<TorrentTaskProgress> controller =
  //       StreamController<TorrentTaskProgress>();
  //   Timer? periodicTimer;

  //   // Emiting function
  //   void emitProgress() {
  //     if (!controller.isClosed) {
  //       controller.add(
  //         TorrentTaskProgress(
  //           progress: task.progress,
  //           downloaded: task.downloaded ?? 0,
  //           total: task.metaInfo.length,
  //           speed: task.currentDownloadSpeed,
  //           peers: task.connectedPeersNumber,
  //         ),
  //       );
  //     }
  //   }

  //   // Начальное значение
  //   emitProgress();

  //   // Периодическое обновление
  //   periodicTimer = Timer.periodic(Duration(seconds: 1), (_) {
  //     if (task.state == TaskState.running || task.state == TaskState.paused) {
  //       emitProgress();
  //     }
  //   });

  //   final taskListener = task.createListener();

  //   taskListener.on<StateFileUpdated>((event) {
  //     emitProgress();
  //   });

  //   taskListener.on<TaskFileCompleted>((event) {
  //     emitProgress();
  //   });

  //   taskListener.on<TaskCompleted>((event) {
  //     emitProgress(); // Финальное значение 100%
  //     periodicTimer?.cancel();
  //     taskListener?.dispose();
  //     if (!controller.isClosed) {
  //       controller.close();
  //     }
  //   });

  //   taskListener.on<TaskStopped>((event) {
  //     periodicTimer?.cancel();
  //     taskListener?.dispose();
  //     if (!controller.isClosed) {
  //       controller.close();
  //     }
  //   });

  //   taskListener.on<TaskPaused>((event) {
  //     emitProgress();
  //   });

  //   taskListener.on<TaskResumed>((event) {
  //     emitProgress();
  //   });

  //   // Обработка ошибок стрима
  //   controller.onCancel = () {
  //     periodicTimer?.cancel();
  //     taskListener?.dispose();
  //     if (!controller.isClosed) {
  //       controller.close();
  //     }
  //   };

  //   yield* controller.stream;
  // }

  Future<void> stopTask({required TorrentTask task}) async {
    try {
      await task.stop();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> pauseTask({required TorrentTask task}) async {
    try {
      task.pause();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resumeTask({required TorrentTask task}) async {
    try {
      task.resume();
    } catch (e) {
      rethrow;
    }
  }
}
