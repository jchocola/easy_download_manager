// ignore_for_file: camel_case_types, constant_identifier_names

import 'dart:convert';

enum TORRENT_TASK_STATUS {
  TaskStarted,
  TaskStopped,
  TaskCompleted,
  TaskPaused,
  TaskResumed,
}

TORRENT_TASK_STATUS convertFromValue(String value) {
  switch (value) {
    case 'TaskStarted':
      return TORRENT_TASK_STATUS.TaskStarted;

    case 'TaskStopped':
      return TORRENT_TASK_STATUS.TaskStopped;

    case 'TaskCompleted':
      return TORRENT_TASK_STATUS.TaskCompleted;

    case 'TaskPaused':
      return TORRENT_TASK_STATUS.TaskPaused;

    case 'TaskResumed':
      return TORRENT_TASK_STATUS.TaskResumed;

    default:
      // Можно вернуть что угодно, но обычно возвращают "Stopped"
      return TORRENT_TASK_STATUS.TaskStopped;
  }
}

class TorrentTaskModel {
  final String id; // id
  final String name; // final filename
  final double progress; // progress 0-1
  final int downloaded; // bytes
  final int total;
  final double speed;
  final int allPeersNumber;
  final int connectedPeersNumber;
  final int seederNumber;
  final double currentDownloadSpeed;
  final double averageDownloadSpeed;
  final String filePath;
  final String saveDir;
  final TORRENT_TASK_STATUS status;

  TorrentTaskModel({
    required this.id,
    required this.name,
    required this.progress,
    required this.downloaded,
    required this.total,
    required this.speed,
    required this.allPeersNumber,
    required this.connectedPeersNumber,
    required this.seederNumber,
    required this.currentDownloadSpeed,
    required this.averageDownloadSpeed,
    required this.filePath,
    required this.saveDir,
    required this.status, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'progress': progress,
      'downloaded': downloaded,
      'total': total,
      'speed': speed,
      'allPeersNumber': allPeersNumber,
      'connectedPeersNumber': connectedPeersNumber,
      'seederNumber': seederNumber,
      'currentDownloadSpeed': currentDownloadSpeed,
      'averageDownloadSpeed': averageDownloadSpeed,
      'filePath': filePath,
      'saveDir': saveDir,
      'status': status.name,
    };
  }

  factory TorrentTaskModel.fromMap(Map<String, dynamic> map) {
    return TorrentTaskModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      progress: map['progress']?.toDouble() ?? 0.0,
      downloaded: map['downloaded']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      speed: map['speed']?.toDouble() ?? 0.0,
      allPeersNumber: map['allPeersNumber']?.toInt() ?? 0,
      connectedPeersNumber: map['connectedPeersNumber']?.toInt() ?? 0,
      seederNumber: map['seederNumber']?.toInt() ?? 0,
      currentDownloadSpeed: map['currentDownloadSpeed']?.toDouble() ?? 0.0,
      averageDownloadSpeed: map['averageDownloadSpeed']?.toDouble() ?? 0.0,
      filePath: map['filePath'] ?? '',
      saveDir: map['saveDir'] ?? '',
      status: convertFromValue(map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TorrentTaskModel.fromJson(String source) =>
      TorrentTaskModel.fromMap(json.decode(source));

  TorrentTaskModel copyWith({
    String? id,
    String? name,
    double? progress,
    int? downloaded,
    int? total,
    double? speed,
    int? allPeersNumber,
    int? connectedPeersNumber,
    int? seederNumber,
    double? currentDownloadSpeed,
    double? averageDownloadSpeed,
    String? filePath,
    String? saveDir,
    TORRENT_TASK_STATUS? status,
  }) {
    return TorrentTaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      progress: progress ?? this.progress,
      downloaded: downloaded ?? this.downloaded,
      total: total ?? this.total,
      speed: speed ?? this.speed,
      allPeersNumber: allPeersNumber ?? this.allPeersNumber,
      connectedPeersNumber: connectedPeersNumber ?? this.connectedPeersNumber,
      seederNumber: seederNumber ?? this.seederNumber,
      currentDownloadSpeed: currentDownloadSpeed ?? this.currentDownloadSpeed,
      averageDownloadSpeed: averageDownloadSpeed ?? this.averageDownloadSpeed,
      filePath: filePath ?? this.filePath,
      saveDir: saveDir ?? this.saveDir,
      status: status ?? this.status,
    );
  }
}
