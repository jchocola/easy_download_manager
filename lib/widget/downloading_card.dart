import 'dart:isolate';
import 'dart:ui';

import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/enum/download_card_status.dart';
import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/widget/button_with_icon.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart' as fl_dl;
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DownloadingCard extends StatefulWidget {
  DownloadingCard({super.key, required this.task, this.onTap, this.onCancelTapped,this.onPauseTapped});
  final fl_dl.DownloadTask task;
  void Function()? onTap;
  void Function()? onCancelTapped;
 void Function()? onPauseTapped; 
  @override
  State<DownloadingCard> createState() => _DownloadingCardState();
}

class _DownloadingCardState extends State<DownloadingCard> {
  ReceivePort _port = ReceivePort();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _registerPort();
    _registerCallback();
  }

  void _registerPort() {
    // Register the port only once
    if (_isListening == false) {
      _isListening = true;

      IsolateNameServer.registerPortWithName(
        _port.sendPort,
        'downloader_send_port',
      );

      _port.listen((dynamic data) {
        String id = data[0];

        // DownloadTaskStatus status = DownloadTaskStatus.fromInt(data[1]);
        int progress = data[2];

        // Only update if this is our task
        if (id == widget.task.taskId) {
          setState(() {
            // Update the widget with new progress
          });
        }
      });
    }
  }

  void _registerCallback() {
    // Register the callback to receive download updates
    fl_dl.FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName(
      'downloader_send_port',
    );
    send?.send([id, status, progress]);
  }

  @override
  void dispose() {
    if (_isListening) {
      IsolateNameServer.removePortNameMapping('downloader_send_port');
      _isListening = false;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // Determine the status based on the download task status
    // Determine the status based on the download task status
    // DOWNLOAD_CARD_STATUS displayStatus = DOWNLOAD_CARD_STATUS.UNDEFINED;
    // if (widget.task.status == fl_dl.DownloadTaskStatus.undefined) {
    //   displayStatus = DOWNLOAD_CARD_STATUS.UNDEFINED;
    // } else if (widget.task.status == fl_dl.DownloadTaskStatus.enqueued) {
    //   displayStatus = DOWNLOAD_CARD_STATUS.ENQUEUED;
    // } else if (widget.task.status == fl_dl.DownloadTaskStatus.running) {
    //   displayStatus = DOWNLOAD_CARD_STATUS.RUNNING;
    // } else if (widget.task.status == fl_dl.DownloadTaskStatus.complete) {
    //   displayStatus = DOWNLOAD_CARD_STATUS.COMPLETE;
    // } else if (widget.task.status == fl_dl.DownloadTaskStatus.failed) {
    //   displayStatus = DOWNLOAD_CARD_STATUS.FAILED;
    // } else if (widget.task.status == fl_dl.DownloadTaskStatus.canceled) {
    //   displayStatus = DOWNLOAD_CARD_STATUS.CANCELED;
    // } else if (widget.task.status == fl_dl.DownloadTaskStatus.paused) {
    //   displayStatus = DOWNLOAD_CARD_STATUS.PAUSED;
    // }

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppConstant.containerPadding),
        padding: EdgeInsets.all(AppConstant.containerPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          color: theme.colorScheme.onPrimary,
        ),
        child: Column(
          children: [
            Row(
              children: [
                ContainerWithBorderColor(),
                SizedBox(width: AppConstant.containerPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.filename ?? 'Unknown File',
                      style: theme.textTheme.titleMedium,
                    ),
                    _buildProgress(context),
                    if (widget.task.status == fl_dl.DownloadTaskStatus.running)
                      _buildSpeedDuration(context),
                    if (widget.task.status == fl_dl.DownloadTaskStatus.running)
                      SizedBox(width: size.width * 0.7, child: Divider()),
                    if (widget.task.status == fl_dl.DownloadTaskStatus.complete)
                      Text(
                        'Completed',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.scrim,
                        ),
                      ),
                    if (widget.task.status == fl_dl.DownloadTaskStatus.failed)
                      Text(
                        'Ошибка загрузки',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (widget.task.status == fl_dl.DownloadTaskStatus.failed)
              ButtonWithIcon(
                label: 'Cancel',
                icon: AppIcon.cancelIcon,
                color: theme.colorScheme.error,
                onPressed: widget.onCancelTapped,
              ),
            if (widget.task.status == fl_dl.DownloadTaskStatus.running)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonWithIcon(
                    label: 'Pause',
                    icon: AppIcon.pauseIcon,
                    color: theme.colorScheme.tertiary,
                     onPressed: widget.onPauseTapped,
                  ),
                  ButtonWithIcon(
                    label: 'Cancel',
                    icon: AppIcon.cancelIcon,
                    color: theme.colorScheme.error,
                      onPressed: widget.onCancelTapped,
                  ),
                ],
              ),
            if (widget.task.status == fl_dl.DownloadTaskStatus.paused)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonWithIcon(
                    label: 'Continue',
                    icon: AppIcon.continueIcon,
                    color: theme.colorScheme.tertiary,
                  ),
                  ButtonWithIcon(
                    label: 'Cancel',
                    icon: AppIcon.cancelIcon,
                    color: theme.colorScheme.error,
                      onPressed: widget.onCancelTapped,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    // Determine progress text based on status
    String progressText;
    if (widget.task.status == fl_dl.DownloadTaskStatus.complete) {
      progressText = '100%';
    } else if (widget.task.status == fl_dl.DownloadTaskStatus.failed) {
      progressText = 'Failed';
    } else {
      progressText = '${widget.task.progress}%';
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstant.containerPadding),
      child: Column(
        spacing: AppConstant.containerPadding,
        children: [
          StepProgressIndicator(
            fallbackLength: size.width * 0.7,
            totalSteps: 100,
            currentStep: widget.task.progress,
            size: AppConstant.loadingHeight,
            padding: 0,
            selectedColor: AppColor.activeProgressColor,
            unselectedColor: AppColor.inactiveProgressColor,
            roundedEdges: Radius.circular(10),
          ),
          SizedBox(
            width: size.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(progressText, style: theme.textTheme.bodySmall),
                Text(_formatFileSize(), style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedDuration(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SizedBox(
      width: size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '650 KB/s',
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          Text('2m', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  String _formatFileSize() {
    // This is a simplified implementation
    // In a real app, you would calculate this based on the actual file size
    return widget.task.filename != null ? '43.3 MB' : 'Unknown Size';
  }
}
