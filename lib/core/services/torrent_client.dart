import 'dart:async';

import 'package:dtorrent_parser/dtorrent_parser.dart';
import 'package:dtorrent_task/dtorrent_task.dart';
import 'package:easy_download_manager/core/enum/download_status.dart';
import 'package:easy_download_manager/core/models/download_task.dart';
import 'package:easy_download_manager/core/services/download_client.dart';
import 'package:events_emitter2/events_emitter2.dart';
import 'package:logging/logging.dart';

class TorrentClient {
  final _log = Logger('TorrentClient');
  final Map<String, _TorrentSession> _sessions = {};

  Future<void> enqueue({
    required DownloadTask task,
    required Torrent torrent,
    required DownloadProgressCallback onProgress,
  }) async {
    final torrentTask = TorrentTask.newTask(torrent, task.directory);
    final listener = torrentTask.createListener();
    final session = _TorrentSession(
      taskId: task.id,
      torrentTask: torrentTask,
      torrent: torrent,
      listener: listener,
      onProgress: onProgress,
    );
    _sessions[task.id] = session;

    listener.on<TaskEvent>((event) async {
      if (event is TaskPaused) {
        _emitProgress(task.id, DownloadStatus.PAUSED);
      } else if (event is TaskResumed || event is TaskStarted) {
        _emitProgress(task.id, DownloadStatus.DOWNLOADING);
      } else if (event is TaskCompleted || event is AllComplete) {
        _emitProgress(task.id, DownloadStatus.COMPLETED);
        await _cleanup(task.id);
      } else if (event is TaskStopped) {
        _emitProgress(task.id, DownloadStatus.CANCELED);
        await _cleanup(task.id);
      }
    });

    session.progressTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _emitProgress(task.id, DownloadStatus.DOWNLOADING),
    );

    try {
      await torrentTask.start();
      _emitProgress(task.id, DownloadStatus.DOWNLOADING);
    } catch (error, stackTrace) {
      _log.severe('Failed to start torrent', error, stackTrace);
      _emitProgress(
        task.id,
        DownloadStatus.FAILED,
        error: error.toString(),
      );
      await _cleanup(task.id);
      rethrow;
    }
  }

  Future<DownloadProgress?> pause(String taskId) async {
    final session = _sessions[taskId];
    if (session == null) return null;
    session.torrentTask.pause();
    final progress = session.buildProgress(status: DownloadStatus.PAUSED);
    return progress;
  }

  Future<DownloadProgress?> resume(String taskId) async {
    final session = _sessions[taskId];
    if (session == null) return null;
    session.torrentTask.resume();
    final progress = session.buildProgress(status: DownloadStatus.DOWNLOADING);
    return progress;
  }

  Future<DownloadProgress?> cancel(String taskId) async {
    final session = _sessions[taskId];
    if (session == null) return null;
    await session.torrentTask.stop();
    final progress = session.buildProgress(status: DownloadStatus.CANCELED);
    await _cleanup(taskId);
    return progress;
  }

  Future<void> dispose() async {
    final ids = _sessions.keys.toList();
    for (final id in ids) {
      await _cleanup(id);
    }
  }

  void _emitProgress(
    String taskId,
    DownloadStatus status, {
    String? error,
  }) {
    final session = _sessions[taskId];
    if (session == null) return;
    final progress = session.buildProgress(status: status, error: error);
    session.onProgress(progress);
  }

  Future<void> _cleanup(String taskId) async {
    final session = _sessions.remove(taskId);
    if (session == null) return;
    session.progressTimer?.cancel();
    await session.listener.dispose();
    try {
      await session.torrentTask.dispose();
    } catch (error, stackTrace) {
      _log.fine('Torrent task dispose failed', error, stackTrace);
    }
  }
}

class _TorrentSession {
  _TorrentSession({
    required this.taskId,
    required this.torrentTask,
    required this.torrent,
    required this.listener,
    required this.onProgress,
  });

  final String taskId;
  final TorrentTask torrentTask;
  final Torrent torrent;
  final EventsListener<TaskEvent> listener;
  final DownloadProgressCallback onProgress;
  Timer? progressTimer;
  int lastDownloaded = 0;

  DownloadProgress buildProgress({
    required DownloadStatus status,
    String? error,
  }) {
    final downloaded = torrentTask.downloaded ?? lastDownloaded;
    lastDownloaded = downloaded;
    final speed = torrentTask.currentDownloadSpeed;
    return DownloadProgress(
      taskId: taskId,
      status: status,
      downloadedBytes: downloaded,
      totalBytes: torrent.length,
      speedBytesPerSecond: speed,
      isResumable: status != DownloadStatus.COMPLETED &&
          status != DownloadStatus.CANCELED &&
          status != DownloadStatus.FAILED,
      error: error,
    );
  }
}
