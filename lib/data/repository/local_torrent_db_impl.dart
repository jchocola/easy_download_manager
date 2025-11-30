import 'package:easy_download_manager/domain/models/torrent_task_model.dart';
import 'package:easy_download_manager/domain/repository/local_torent_db.dart';
import 'package:easy_download_manager/main.dart';
import 'package:localstore/localstore.dart';

class LocalTorrentDbImpl implements LocalTorrentDB {
  final db = Localstore.instance.collection('Torrents');

  @override
  Future<void> deleteTorrentTask({required String id}) async {
    try {
      await db.doc(id).delete();
    } catch (e) {
       logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<TorrentTaskModel>> getCompletedTorrentTaskList() async {
    try {
      final allDocs = await db.get();

      if (allDocs == null) {
        return [];
      }

      final listTorrentTask = allDocs.entries.map((entry) {
        final data = Map<String, dynamic>.from(entry.value);
        return TorrentTaskModel.fromMap(data);
      }).toList();

      final filteredList = listTorrentTask.where((element) {
        return element.status == TORRENT_TASK_STATUS.TaskCompleted;
      }).toList();

      return filteredList;
    } catch (e) {
       logger.e(e.toString());
      return [];
    }
  }

  @override
  Future<List<TorrentTaskModel>> getOthersTorrentTaskList() async {
    try {
      final allDocs = await db.get();

      if (allDocs == null) {
        return [];
      }

      final listTorrentTask = allDocs.entries.map((entry) {
        final data = Map<String, dynamic>.from(entry.value);
        return TorrentTaskModel.fromMap(data);
      }).toList();

      final filteredList = listTorrentTask.where((element) {
        return element.status == TORRENT_TASK_STATUS.TaskPaused ||
            element.status == TORRENT_TASK_STATUS.TaskStopped;
      }).toList();

      return filteredList;
    } catch (e) {
       logger.e(e.toString());
      return [];
    }
  }

  @override
  Future<List<TorrentTaskModel>> getRunningTorrentTaskList() async {
    try {
      final allDocs = await db.get();

      if (allDocs == null) {
        return [];
      }

      final listTorrentTask = allDocs.entries.map((entry) {
        final data = Map<String, dynamic>.from(entry.value);
        return TorrentTaskModel.fromMap(data);
      }).toList();

      final filteredList = listTorrentTask.where((element) {
        return element.status == TORRENT_TASK_STATUS.TaskStarted;
      }).toList();

      return filteredList;
    } catch (e) {
       logger.e(e.toString());
      return [];
    }
  }

  @override
  Future<TorrentTaskModel> getTorrentTask({required String id}) async {
    try {
      final data = await db.doc(id).get();

      return TorrentTaskModel.fromMap(data!);
    } catch (e) {
       logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> saveNewTorrentTask({
    required TorrentTaskModel torrentTask,
  }) async {
    try {
      await db.doc(torrentTask.id).set(torrentTask.toMap());
    } catch (e) {
       logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateTorrentTask({
    required TorrentTaskModel torrentTask,
  }) async {
    try {
      await db
          .doc(torrentTask.id)
          .set(torrentTask.toMap(), SetOptions(merge: true));
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
