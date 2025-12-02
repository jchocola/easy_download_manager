import 'dart:ui';

import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Color TaskStattusColorConverter({required DownloadTask task}) {
  switch (task.status) {
    case DownloadTaskStatus.paused:
      return AppDarkColor.inactiveProgressColor.withOpacity(0.4);

    case DownloadTaskStatus.failed:
      return AppDarkColor.errorColor.withOpacity(0.4);
    case DownloadTaskStatus.complete:
      return AppDarkColor.successColor.withOpacity(0.4);

    default:
      return AppDarkColor.activeBeginColor..withOpacity(0.4);
  }
}
