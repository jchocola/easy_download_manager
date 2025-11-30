import 'package:easy_download_manager/data/repository/direct_link_impl.dart';
import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/data/repository/flutter_torrent_downloader_impl.dart';
import 'package:easy_download_manager/data/repository/local_torrent_db_impl.dart';
import 'package:easy_download_manager/domain/repository/local_torent_db.dart';
import 'package:easy_download_manager/main.dart';
import 'package:get_it/get_it.dart' show GetIt;

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<FlutterDownloaderRepositoryImpl>(
    FlutterDownloaderRepositoryImpl.instance,
  );

  getIt.registerSingleton<FlutterTorrentDownloaderImpl>(
    FlutterTorrentDownloaderImpl(),
  );

  getIt.registerSingleton<LocalTorrentDB>(LocalTorrentDbImpl());

  getIt.registerSingleton<DirectLinkImpl>(DirectLinkImpl());

  logger.i('DI');
}
