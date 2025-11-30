import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/enum/download_card_status.dart';
import 'package:easy_download_manager/core/utils/icon_coverter_from_filename.dart';
import 'package:easy_download_manager/core/utils/task_status_color.dart';
import 'package:easy_download_manager/widget/button_with_icon.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DownloadCard extends StatelessWidget {
  DownloadCard({
    super.key,
    this.status = DOWNLOAD_CARD_STATUS.RUNNING,
    this.onTap,
    this.onCancelTapped,
    this.onContinueTapped,
    this.task,
  });
  final DOWNLOAD_CARD_STATUS status;
  void Function()? onTap;
  final DownloadTask? task;
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
                  icon: IconConverterFromFileName(
                    filename: task?.filename ?? '',
                  ),
                  color: TaskStattusColorConverter(task: task!),
                ),

                SizedBox(width: AppConstant.containerPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///
                    /// file name
                    ///
                    Text(
                      task?.filename ?? 'Unknown',
                      style: theme.textTheme.titleMedium,
                    ),

                    ///
                    /// progress
                    ///
                    if (task?.status != DownloadTaskStatus.complete)
                      buildProgress(context),

                    ///
                    /// speed duration
                    ///
                    if (task?.status == DownloadTaskStatus.running)
                      buildSpeedDuration(context),

                    if (status == DOWNLOAD_CARD_STATUS.RUNNING)
                      SizedBox(width: size.width * 0.7, child: Divider()),

                    if (task?.status == DownloadTaskStatus.complete)
                      Text(
                        'Completed',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.scrim,
                        ),
                      ),

                    if (task?.status == DownloadTaskStatus.failed)
                      Text(
                        'Ошибка загрузки',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),

                    if (task?.status == DownloadTaskStatus.paused)
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

            if (task?.status == DownloadTaskStatus.failed)
              ButtonWithIcon(
                label: 'Cancel',
                icon: AppIcon.cancelIcon,
                color: theme.colorScheme.error,
                onPressed: onCancelTapped,
              ),

            if (task?.status == DownloadTaskStatus.running)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonWithIcon(
                    label: 'Pause',
                    icon: AppIcon.pauseIcon,
                    color: theme.colorScheme.tertiary,
                  ),
                  ButtonWithIcon(
                    label: 'Cancel',
                    icon: AppIcon.cancelIcon,
                    color: theme.colorScheme.error,
                  ),
                ],
              ),

            if (task?.status == DownloadTaskStatus.paused)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonWithIcon(
                    label: 'Continue',
                    icon: AppIcon.continueIcon,
                    color: theme.colorScheme.tertiary,
                    onPressed: onContinueTapped,
                  ),
                  ButtonWithIcon(
                    label: 'Cancel',
                    icon: AppIcon.cancelIcon,
                    color: theme.colorScheme.error,
                    onPressed: onCancelTapped,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildProgress(context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDarkMode = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstant.containerPadding),
      child: Column(
        spacing: AppConstant.containerPadding,
        children: [
          StepProgressIndicator(
            fallbackLength: size.width * 0.7,
            totalSteps: 100,
            currentStep: task?.progress ?? 0,
            size: AppConstant.loadingHeight,
            padding: 0,
            selectedColor: isDarkMode ? AppDarkColor.activeProgressColor : AppLightColor.activeProgressColor,
            unselectedColor: isDarkMode ? AppDarkColor.inactiveProgressColor : AppLightColor.inactiveProgressColor,
            roundedEdges: Radius.circular(10),
          ),

          SizedBox(
            width: size.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${task?.progress} %', style: theme.textTheme.bodySmall),
                Text('43.3 MB', style: theme.textTheme.bodySmall),
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
}
