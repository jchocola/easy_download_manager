import 'dart:ui';

import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Color TaskStattusColorConverter({required DownloadTask task}) {
  switch (task.status) {
    case DownloadTaskStatus.paused:
      return AppColor.inactiveProgressColor;

    case DownloadTaskStatus.failed:
      return AppColor.errorColor;
    case DownloadTaskStatus.complete:
      return AppColor.successColor;

    default:
      return AppColor.activeBeginColor;
  }
}
