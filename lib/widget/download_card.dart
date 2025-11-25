import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/enum/download_card_status.dart';
import 'package:easy_download_manager/widget/button_with_icon.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DownloadCard extends StatelessWidget {
   DownloadCard({
    super.key,
    this.status = DOWNLOAD_CARD_STATUS.RUNNING,
    this.onTap
  });
  final DOWNLOAD_CARD_STATUS status;
  void Function()? onTap;
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
                ContainerWithBorderColor(),
      
                SizedBox(width: AppConstant.containerPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Presentation.pdf', style: theme.textTheme.titleMedium),
                    buildProgress(context),
                    if (status == DOWNLOAD_CARD_STATUS.RUNNING)
                      buildSpeedDuration(context),
                    if (status == DOWNLOAD_CARD_STATUS.RUNNING)
                      SizedBox(width: size.width * 0.7, child: Divider()),
      
                     if (status == DOWNLOAD_CARD_STATUS.COMPLETE) Text('Completed', style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.scrim),) ,
                      if (status == DOWNLOAD_CARD_STATUS.FAILED) Text('Ошибка загрузки', style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.error),) , 
                  ],
                ),
              ],
            ),
      
      
            if (status == DOWNLOAD_CARD_STATUS.FAILED) ButtonWithIcon(
              label: 'Cancel',
              icon: AppIcon.cancelIcon,
                    color: theme.colorScheme.error, 
            ),
      
            if (status == DOWNLOAD_CARD_STATUS.RUNNING)
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
      
      
                if (status == DOWNLOAD_CARD_STATUS.PAUSED)
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstant.containerPadding),
      child: Column(
        spacing: AppConstant.containerPadding,
        children: [
          StepProgressIndicator(
            fallbackLength: size.width * 0.7,
            totalSteps: 100,
            currentStep: 32,
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
                Text('32%', style: theme.textTheme.bodySmall),
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
