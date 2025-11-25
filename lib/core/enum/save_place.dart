// ignore_for_file: constant_identifier_names, camel_case_types

import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum SAVE_PLACE { DOWNLOADS, DOCUMENTS, VIDEOS, MUSICS }

Future<String> getFullSavingPath({required SAVE_PLACE place}) async {
  final Directory? downloadsDir = await getDownloadsDirectory();

  switch (place) {
    case SAVE_PLACE.DOWNLOADS:
      return '${downloadsDir!.path}/Downloads';
    case SAVE_PLACE.DOCUMENTS:
      return '${downloadsDir!.path}/Documents';
      case SAVE_PLACE.VIDEOS:
      return '${downloadsDir!.path}/Videos';
      case SAVE_PLACE.MUSICS:
      return '${downloadsDir!.path}/Musics'; 
  }
}
