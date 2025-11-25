import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:easy_download_manager/core/enum/download_method.dart';
import 'package:easy_download_manager/core/enum/download_status.dart';

class DownloadTask extends Equatable {
  final String id; // taskId
  final String url; // downloadUrl
  final String fileName; // filename
  final String directory; //save path
  final DOWNLOAD_METHOD method; // download method
  final DOWNLOAD_STATUS status; // status
  final int downloadedBytes;
  final int? totalBytes;
  final double speedBytesPerSecond;
  final bool isResumable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? error;
  final String? torrentPath;

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

  double get progress {
    if (totalBytes == null || totalBytes == 0) {
      return 0;
    } else {
      return downloadedBytes / totalBytes!;
    }
  }

  bool get isComplete =>
      status == DOWNLOAD_STATUS.COMPLETED ||
      status == DOWNLOAD_STATUS.CANCELED ||
      status == DOWNLOAD_STATUS.FAILED;

  DownloadTask copyWith({
    String? id,
    String? url,
    String? fileName,
    String? directory,
    DOWNLOAD_METHOD? method,
    DOWNLOAD_STATUS? status,
    int? downloadedBytes,
    int? totalBytes,
    double? speedBytesPerSecond,
    bool? isResumable,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? error,
    String? torrentPath,
  }) {
    return DownloadTask(
      id: id ?? this.id,
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
      directory: directory ?? this.directory,
      method: method ?? this.method,
      status: status ?? this.status,
      downloadedBytes: downloadedBytes ?? this.downloadedBytes,
      totalBytes: totalBytes ?? this.totalBytes,
      speedBytesPerSecond: speedBytesPerSecond ?? this.speedBytesPerSecond,
      isResumable: isResumable ?? this.isResumable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      error: error ?? this.error,
      torrentPath: torrentPath ?? this.torrentPath,
    );
  }

  Map<String, dynamic> toMap() {
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

  factory DownloadTask.fromMap(Map<String, dynamic> map) {
    return DownloadTask(
      id: map['id'] ?? '',
      url: map['url'] ?? '',
      fileName: map['fileName'] ?? '',
      directory: map['directory'] ?? '',
      method: downloadMethodFromValue(value: map['method'] as String),
      status: downloadStatusFromValue(value: map['status'] as String),
      downloadedBytes: map['downloadedBytes']?.toInt() ?? 0,
      totalBytes: map['totalBytes']?.toInt(),
      speedBytesPerSecond: map['speedBytesPerSecond']?.toDouble() ?? 0.0,
      isResumable: map['isResumable'] ?? false,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      error: map['error'],
      torrentPath: map['torrentPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DownloadTask.fromJson(String source) =>
      DownloadTask.fromMap(json.decode(source));

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
