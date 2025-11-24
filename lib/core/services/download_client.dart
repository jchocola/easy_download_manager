import 'dart:async';
import 'dart:io';

import 'package:easy_download_manager/core/enum/download_status.dart';
import 'package:easy_download_manager/core/models/download_task.dart';

typedef DownloadProgressCallback = void Function(DownloadProgress progress);

class DownloadProgress {
  DownloadProgress({
    required this.taskId,
    required this.status,
    required this.downloadedBytes,
    required this.totalBytes,
    required this.speedBytesPerSecond,
    required this.isResumable,
    this.error,
  });

  final String taskId;
  final DownloadStatus status;
  final int downloadedBytes;
  final int? totalBytes;
  final double speedBytesPerSecond;
  final bool isResumable;
  final String? error;
}

class DownloadClient {
  DownloadClient({
    HttpClient? httpClient,
    Duration? connectionTimeout,
  }) : _httpClient = httpClient ?? HttpClient() {
    _httpClient.connectionTimeout = connectionTimeout ?? const Duration(seconds: 30);
  }

  final HttpClient _httpClient;
  final Map<String, _DownloadSession> _sessions = {};

  Future<void> enqueue({
    required DownloadTask task,
    required DownloadProgressCallback onProgress,
  }) async {
    await _startDownload(
      task: task,
      onProgress: onProgress,
      resumeFromBytes: 0,
    );
  }

  Future<void> resume({
    required DownloadTask task,
    required DownloadProgressCallback onProgress,
  }) async {
    final file = File(task.filePath);
    final resumeFromBytes =
        (await file.exists()) ? await file.length() : task.downloadedBytes;
    await _startDownload(
      task: task,
      onProgress: onProgress,
      resumeFromBytes: resumeFromBytes,
      isResume: true,
    );
  }

  Future<DownloadProgress?> pause(String taskId) async {
    final session = _sessions.remove(taskId);
    if (session == null) return null;
    await session.subscription?.cancel();
    await session.sink.flush();
    await session.sink.close();
    return DownloadProgress(
      taskId: taskId,
      status: DownloadStatus.PAUSED,
      downloadedBytes: session.downloadedBytes,
      totalBytes: session.totalBytes,
      speedBytesPerSecond: 0,
      isResumable: true,
    );
  }

  Future<DownloadProgress?> cancel(String taskId) async {
    final session = _sessions.remove(taskId);
    if (session == null) return null;
    await session.subscription?.cancel();
    await session.sink.close();
    try {
      final file = File(session.filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // ignore cleanup errors
    }
    return DownloadProgress(
      taskId: taskId,
      status: DownloadStatus.CANCELED,
      downloadedBytes: 0,
      totalBytes: session.totalBytes,
      speedBytesPerSecond: 0,
      isResumable: false,
    );
  }

  Future<void> dispose() async {
    for (final session in _sessions.values) {
      await session.subscription?.cancel();
      await session.sink.close();
    }
    _sessions.clear();
    _httpClient.close(force: true);
  }

  Future<void> _startDownload({
    required DownloadTask task,
    required DownloadProgressCallback onProgress,
    required int resumeFromBytes,
    bool isResume = false,
  }) async {
    final directory = Directory(task.directory);
    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    }

    final file = File(task.filePath);
    final sink = file.openWrite(
      mode: resumeFromBytes > 0 ? FileMode.append : FileMode.write,
    );

    final request = await _httpClient.getUrl(Uri.parse(task.url));
    if (resumeFromBytes > 0) {
      request.headers.set(HttpHeaders.rangeHeader, 'bytes=$resumeFromBytes-');
    }

    final response = await request.close();
    if (response.statusCode >= 400) {
      await sink.close();
      onProgress(
        DownloadProgress(
          taskId: task.id,
          status: DownloadStatus.FAILED,
          downloadedBytes: resumeFromBytes,
          totalBytes: resumeFromBytes,
          speedBytesPerSecond: 0,
          isResumable: false,
          error: 'HTTP ${response.statusCode}',
        ),
      );
      return;
    }
    final totalBytes = _resolveTotalBytes(response, resumeFromBytes);
    final session = _DownloadSession(
      sink: sink,
      totalBytes: totalBytes,
      filePath: file.path,
    );
    _sessions[task.id] = session;

    int downloadedBytes = resumeFromBytes;
    final speedTracker = _SpeedTracker(initialBytes: resumeFromBytes);

    onProgress(
      DownloadProgress(
        taskId: task.id,
        status: DownloadStatus.DOWNLOADING,
        downloadedBytes: downloadedBytes,
        totalBytes: totalBytes,
        speedBytesPerSecond: 0,
        isResumable: true,
      ),
    );

    session.subscription = response.listen(
      (chunk) {
        sink.add(chunk);
        downloadedBytes += chunk.length;
        session.downloadedBytes = downloadedBytes;
        final speed = speedTracker.report(downloadedBytes);
        onProgress(
          DownloadProgress(
            taskId: task.id,
            status: DownloadStatus.DOWNLOADING,
            downloadedBytes: downloadedBytes,
            totalBytes: totalBytes,
            speedBytesPerSecond: speed,
            isResumable: true,
          ),
        );
      },
      cancelOnError: true,
      onDone: () async {
        await sink.flush();
        await sink.close();
        _sessions.remove(task.id);
        onProgress(
          DownloadProgress(
            taskId: task.id,
            status: DownloadStatus.COMPLETED,
            downloadedBytes: downloadedBytes,
            totalBytes: totalBytes,
            speedBytesPerSecond: 0,
            isResumable: false,
          ),
        );
      },
      onError: (error, stackTrace) async {
        await sink.close();
        _sessions.remove(task.id);
        onProgress(
          DownloadProgress(
            taskId: task.id,
            status: DownloadStatus.FAILED,
            downloadedBytes: downloadedBytes,
            totalBytes: totalBytes,
            speedBytesPerSecond: 0,
            isResumable: isResume,
            error: error.toString(),
          ),
        );
      },
    );
  }

  int? _resolveTotalBytes(HttpClientResponse response, int resumeFromBytes) {
    final contentRange = response.headers.value(HttpHeaders.contentRangeHeader);
    if (contentRange != null && contentRange.contains('/')) {
      final totalPart = contentRange.split('/').last;
      final total = int.tryParse(totalPart);
      if (total != null) return total;
    }

    final contentLength = response.contentLength;
    if (contentLength >= 0) {
      return resumeFromBytes > 0 ? contentLength + resumeFromBytes : contentLength;
    }
    return null;
  }
}

class _DownloadSession {
  _DownloadSession({
    required this.sink,
    required this.totalBytes,
    required this.filePath,
  });

  final IOSink sink;
  final int? totalBytes;
  final String filePath;
  StreamSubscription<List<int>>? subscription;
  int downloadedBytes = 0;
}

class _SpeedTracker {
  _SpeedTracker({required int initialBytes}) : _lastBytes = initialBytes;

  int _lastBytes;
  DateTime _lastSample = DateTime.now();

  double report(int totalDownloaded) {
    final now = DateTime.now();
    final elapsed = now.difference(_lastSample).inMilliseconds;
    if (elapsed <= 0) {
      return 0;
    }
    final bytesSinceLast = totalDownloaded - _lastBytes;
    _lastBytes = totalDownloaded;
    _lastSample = now;
    final seconds = elapsed / 1000;
    return bytesSinceLast / (seconds == 0 ? 1 : seconds);
  }
}

