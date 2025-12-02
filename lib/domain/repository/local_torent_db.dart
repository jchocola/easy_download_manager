import 'package:easy_download_manager/domain/models/torrent_task_model.dart';

abstract class LocalTorrentDB {
  Future<void> init();

  Future<void> saveNewTorrentTask({required TorrentTaskModel torrentTask});

  Future<TorrentTaskModel> getTorrentTask({required String id});

  Future<List<TorrentTaskModel>> getRunningTorrentTaskList();

  Future<List<TorrentTaskModel>> getCompletedTorrentTaskList();

  Future<List<TorrentTaskModel>> getOthersTorrentTaskList();

  Future<void> deleteTorrentTask({required String id});

  Future<void> updateTorrentTask({required TorrentTaskModel torrentTask});

  
}
