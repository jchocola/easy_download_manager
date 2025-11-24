import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as path;

import 'package:easy_download_manager/core/enum/download_method.dart';
import 'package:easy_download_manager/core/enum/download_status.dart';

const _sentinel = Object();

class DownloadTask extends Equatable {
  const DownloadTask({
    required this.id,
    required this.url,
    required this.fileName,
    required this.directory,
    required this.method,
    required this.status,
    required this.downloadedBytes,
    required this.totalBytes,
    required this.speedBytesPerSecond,
    required this.isResumable,
    required this.createdAt,
    required this.updatedAt,
    this.error,
    this.torrentPath,
  });

  final String id;
  final String url;
  final String fileName;
  final String directory;
  final DOWNLOAD_METHOD method;
  final DownloadStatus status;
  final int downloadedBytes;
  final int? totalBytes;
  final double speedBytesPerSecond;
  final bool isResumable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? error;
  final String? torrentPath;

  double get progress {
    if (totalBytes == null || totalBytes == 0) {
      return 0;
    }
    return downloadedBytes / totalBytes!;
  }

  String get filePath => path.join(directory, fileName);

  bool get isComplete =>
      status == DownloadStatus.COMPLETED ||
      status == DownloadStatus.CANCELED ||
      status == DownloadStatus.FAILED;

  DownloadTask copyWith({
    DOWNLOAD_METHOD? method,
    DownloadStatus? status,
    int? downloadedBytes,
    Object? totalBytes = _sentinel,
    double? speedBytesPerSecond,
    bool? isResumable,
    DateTime? updatedAt,
    Object? error = _sentinel,
    String? fileName,
    String? directory,
    Object? torrentPath = _sentinel,
  }) {
    return DownloadTask(
      id: id,
      url: url,
      fileName: fileName ?? this.fileName,
      directory: directory ?? this.directory,
      method: method ?? this.method,
      status: status ?? this.status,
      downloadedBytes: downloadedBytes ?? this.downloadedBytes,
      totalBytes: identical(totalBytes, _sentinel)
          ? this.totalBytes
          : totalBytes as int?,
      speedBytesPerSecond: speedBytesPerSecond ?? this.speedBytesPerSecond,
      isResumable: isResumable ?? this.isResumable,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      error: identical(error, _sentinel) ? this.error : error as String?,
      torrentPath: identical(torrentPath, _sentinel)
          ? this.torrentPath
          : torrentPath as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'fileName': fileName,
      'directory': directory,
      'method': method.name,
      'status': status.name,
      'downloadedBytes': downloadedBytes,
      'totalBytes': totalBytes,
      'speedBytesPerSecond': speedBytesPerSecond,
      'isResumable': isResumable,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'error': error,
      'torrentPath': torrentPath,
    };
  }

  factory DownloadTask.fromJson(Map<String, dynamic> json) {
    return DownloadTask(
      id: json['id'] as String,
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      directory: json['directory'] as String,
      method: DOWNLOAD_METHOD.values.firstWhere(
          (entry) => entry.name == json['method'],
          orElse: () => DOWNLOAD_METHOD.HTTP_HTTPS),
      status: DownloadStatus.values
          .firstWhere((status) => status.name == json['status']),
      downloadedBytes: json['downloadedBytes'] as int,
      totalBytes: json['totalBytes'] as int?,
      speedBytesPerSecond: (json['speedBytesPerSecond'] as num).toDouble(),
      isResumable: json['isResumable'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      error: json['error'] as String?,
      torrentPath: json['torrentPath'] as String?,
    );
  }

  static List<DownloadTask> decodeList(String? source) {
    if (source == null || source.isEmpty) return [];
    final List<dynamic> raw = jsonDecode(source) as List<dynamic>;
    return raw
        .map((entry) => DownloadTask.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  static String encodeList(List<DownloadTask> tasks) {
    return jsonEncode(tasks.map((task) => task.toJson()).toList());
  }

  @override
  List<Object?> get props => [
        id,
        url,
        fileName,
        directory,
        method,
        status,
        downloadedBytes,
        totalBytes,
        speedBytesPerSecond,
        isResumable,
        createdAt,
        updatedAt,
        error,
        torrentPath,
      ];
}
