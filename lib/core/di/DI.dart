import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/data/repository/flutter_torrent_downloader_impl.dart';
import 'package:easy_download_manager/main.dart';
import 'package:get_it/get_it.dart' show GetIt;

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<FlutterDownloaderRepositoryImpl>(
    FlutterDownloaderRepositoryImpl.instance,
  );

  getIt.registerSingleton<FlutterTorrentDownloaderImpl>(FlutterTorrentDownloaderImpl());

  logger.i('DI');
}
