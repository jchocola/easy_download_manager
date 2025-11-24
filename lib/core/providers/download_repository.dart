import 'dart:async';

import 'package:easy_download_manager/core/enum/download_status.dart';
import 'package:easy_download_manager/core/models/download_task.dart';
import 'package:easy_download_manager/core/services/download_client.dart';
import 'package:easy_download_manager/core/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadRepository {
  DownloadRepository._({
    required DownloadClient client,
    required SharedPreferences prefs,
    NotificationService? notificationService,
  })  : _client = client,
        _prefs = prefs,
        _notificationService = notificationService {
    _restoreTasks();
  }

  static const String _storageKey = 'edm.download.tasks';
  static const String _defaultDirectoryKey = 'edm.download.default_directory';
  static const String _notificationKey = 'edm.download.notifications';
  static const String _wifiOnlyKey = 'edm.download.wifi_only';

  final DownloadClient _client;
  final SharedPreferences _prefs;
  final NotificationService? _notificationService;
  final Map<String, DownloadTask> _tasks = {};
  final StreamController<List<DownloadTask>> _controller =
      StreamController<List<DownloadTask>>.broadcast();

  static Future<DownloadRepository> create({
    required DownloadClient client,
    NotificationService? notificationService,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return DownloadRepository._(
      client: client,
      prefs: prefs,
      notificationService: notificationService,
    );
  }

  Stream<List<DownloadTask>> watchTasks() => _controller.stream;

  List<DownloadTask> get currentTasks =>
      _tasks.values.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  DownloadTask? getTask(String id) => _tasks[id];

  Future<DownloadTask> enqueueHttpDownload({
    required String url,
    required String fileName,
    required String directory,
  }) async {
    final now = DateTime.now();
    final task = DownloadTask(
      id: now.microsecondsSinceEpoch.toString(),
      url: url,
      fileName: fileName,
      directory: directory,
      status: DownloadStatus.QUEUED,
      downloadedBytes: 0,
      totalBytes: null,
      speedBytesPerSecond: 0,
      isResumable: true,
      createdAt: now,
      updatedAt: now,
    );
    _tasks[task.id] = task;
    _emitAndPersist();

    unawaited(
      _client.enqueue(
        task: task,
        onProgress: _handleProgress,
      ),
    );

    return task;
  }

  Future<void> pauseTask(String id) async {
    final progress = await _client.pause(id);
    if (progress != null) {
      _handleProgress(progress);
    }
  }

  Future<void> resumeTask(String id) async {
    final task = _tasks[id];
    if (task == null) return;
    unawaited(
      _client.resume(
        task: task,
        onProgress: _handleProgress,
      ),
    );
  }

  Future<void> cancelTask(String id) async {
    final progress = await _client.cancel(id);
    if (progress != null) {
      _handleProgress(progress);
    } else {
      _updateTask(
        id,
        (task) => task.copyWith(
          status: DownloadStatus.CANCELED,
          downloadedBytes: 0,
          speedBytesPerSecond: 0,
          updatedAt: DateTime.now(),
        ),
      );
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.remove(id);
    _emitAndPersist();
  }

  Future<void> setDefaultDirectory(String path) async {
    await _prefs.setString(_defaultDirectoryKey, path);
  }

  String? get defaultDirectory => _prefs.getString(_defaultDirectoryKey);

  bool get notificationsEnabled => _prefs.getBool(_notificationKey) ?? true;

  Future<void> setNotificationsEnabled(bool value) async {
    await _prefs.setBool(_notificationKey, value);
  }

  bool get wifiOnly => _prefs.getBool(_wifiOnlyKey) ?? false;

  Future<void> setWifiOnly(bool value) async {
    await _prefs.setBool(_wifiOnlyKey, value);
  }

  Future<void> dispose() async {
    await _controller.close();
    await _client.dispose();
  }

  void _restoreTasks() {
    final persisted = _prefs.getString(_storageKey);
    if (persisted == null) {
      _controller.add([]);
      return;
    }
    final tasks = DownloadTask.decodeList(persisted);
    for (final task in tasks) {
      _tasks[task.id] = task;
    }
    _controller.add(currentTasks);
  }

  void _handleProgress(DownloadProgress progress) {
    final updatedTask = _updateTask(
      progress.taskId,
      (task) => task.copyWith(
        status: progress.status,
        downloadedBytes: progress.downloadedBytes,
        totalBytes: progress.totalBytes,
        speedBytesPerSecond: progress.speedBytesPerSecond,
        updatedAt: DateTime.now(),
        error: progress.error,
      ),
    );
    if (updatedTask != null) {
      _maybeNotify(updatedTask);
    }
  }

  DownloadTask? _updateTask(
    String taskId,
    DownloadTask Function(DownloadTask task) updater,
  ) {
    final existing = _tasks[taskId];
    if (existing == null) return null;
    final updated = updater(existing);
    _tasks[taskId] = updated;
    _emitAndPersist();
    return updated;
  }

  void _maybeNotify(DownloadTask task) {
    final service = _notificationService;
    if (service == null) return;
    if (!notificationsEnabled) return;
    if (task.status == DownloadStatus.COMPLETED) {
      service.showDownloadSuccess(task);
    } else if (task.status == DownloadStatus.FAILED) {
      service.showDownloadFailure(task);
    }
  }

  void _emitAndPersist() {
    final snapshot = currentTasks;
    if (!_controller.isClosed) {
      _controller.add(snapshot);
    }
    _prefs.setString(_storageKey, DownloadTask.encodeList(snapshot));
  }
}

