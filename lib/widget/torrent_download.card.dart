import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/enum/download_card_status.dart';
import 'package:easy_download_manager/core/utils/icon_coverter_from_filename.dart';
import 'package:easy_download_manager/core/utils/remain_time_converter.dart';
import 'package:easy_download_manager/core/utils/task_status_color.dart';
import 'package:easy_download_manager/core/utils/total_size_converter.dart';
import 'package:easy_download_manager/domain/models/torrent_task_model.dart';
import 'package:easy_download_manager/widget/button_with_icon.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TorrentDownloadCard extends StatelessWidget {
  TorrentDownloadCard({
    super.key,
    this.onTap,
    this.onCancelTapped,
    this.onContinueTapped,
    this.task,
  });
  void Function()? onTap;
  final TorrentTaskModel? task;
  void Function()? onCancelTapped;
  void Function()? onContinueTapped;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
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
                ContainerWithBorderColor(
                  icon: AppIcon.downloadIcon,
                  withGradient: true,
                ),

                SizedBox(width: AppConstant.containerPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///
                    /// file name
                    ///
                    Text(
                      task?.name ?? 'Unknown',
                      style: theme.textTheme.titleMedium,
                    ),

                    ///
                    /// progress
                    ///
                    if (task?.status == TORRENT_TASK_STATUS.TaskStarted)
                      buildProgress(context),


                    ///
                    ///Peers and seeds
                    ///
                       if (task?.status == TORRENT_TASK_STATUS.TaskStarted)
                      buildPeersAndSeeds(context),

                    ///
                    /// speed duration
                    ///
                    if (task?.status == TORRENT_TASK_STATUS.TaskStarted)
                      buildSpeedDuration(context),

                    if (task?.status == TORRENT_TASK_STATUS.TaskStarted)
                      SizedBox(width: size.width * 0.7, child: Divider()),

                    if (task?.status == TORRENT_TASK_STATUS.TaskCompleted)
                      Text(
                        'Completed',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.scrim,
                        ),
                      ),

                    if (task?.status == TORRENT_TASK_STATUS.TaskPaused)
                      Text(
                        'Paused',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onTertiary,
                        ),
                      ),
                  ],
                ),
              ],
            ),

            if (task?.status == TORRENT_TASK_STATUS.TaskPaused)
              ButtonWithIcon(
                label: 'Cancel',
                icon: AppIcon.cancelIcon,
                color: theme.colorScheme.error,
                onPressed: onCancelTapped,
              ),

            if (task?.status == TORRENT_TASK_STATUS.TaskStarted)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonWithIcon(
                    label: 'Pause',
                    icon: AppIcon.pauseIcon,
                    color: theme.colorScheme.tertiary,
                  //  onPressed: onPauseTapped,
                  ),
                  ButtonWithIcon(
                    label: 'Cancel',
                    icon: AppIcon.cancelIcon,
                    color: theme.colorScheme.error,
                    onPressed: onCancelTapped,
                  ),
                ],
              ),

            // if (task?.status == TORRENT_TASK_STATUS.TaskPaused)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       ButtonWithIcon(
            //         label: 'Continue',
            //         icon: AppIcon.continueIcon,
            //         color: theme.colorScheme.tertiary,
            //         onPressed: onContinueTapped,
            //       ),
            //       ButtonWithIcon(
            //         label: 'Cancel',
            //         icon: AppIcon.cancelIcon,
            //         color: theme.colorScheme.error,
            //         onPressed: onCancelTapped,
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }

  Widget buildProgress(context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstant.containerPadding),
      child: Column(
        spacing: AppConstant.containerPadding,
        children: [
          StepProgressIndicator(
            fallbackLength: size.width * 0.7,
            totalSteps: 100,
            currentStep: (double.parse(task?.progress.toStringAsFixed(2) ?? '1') * 100).toInt(),
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
                Text('${double.parse(task?.progress.toStringAsFixed(2) ?? '1') * 100} %', style: theme.textTheme.bodySmall),
                Text(TotalSizeConverter(task?.total ?? 0), style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSpeedDuration(context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SizedBox(
      width: size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${task?.currentDownloadSpeed.toStringAsFixed(2) ?? 0} KB/s',
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          Text(remainTimeConverter(totalSizeInBytes:  task?.total ?? 0, currentSpeedInKiloBytes: task?.averageDownloadSpeed ?? 0, progress: task?.progress ?? 0), style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }



  Widget buildPeersAndSeeds(context) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppConstant.containerPadding * 2,
      children: [
        Row(
          spacing: AppConstant.containerPadding / 2,
          children: [
            Icon(AppIcon.seedIcon, color: theme.colorScheme.secondary, size: 14),
            Text('${task?.seederNumber ?? 0}', style: theme.textTheme.bodySmall),
          ],
        ),
        Row(
          spacing: AppConstant.containerPadding / 2,
          children: [
            Icon(AppIcon.peersIcon, color: theme.colorScheme.secondary, size: 14),
            Text('${task?.allPeersNumber ?? 0}', style: theme.textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
