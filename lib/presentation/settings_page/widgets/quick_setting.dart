import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/file_info_card.dart';
import 'package:flutter/material.dart';

class QuickSetting extends StatelessWidget {
  const QuickSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimary,
      ),
      child: Column(
        spacing: AppConstant.containerPadding,
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Icon(AppIcon.settingIcon, color: theme.colorScheme.secondary),
              Text(l10n.quickSwitches, style: theme.textTheme.titleMedium),
            ],
          ),

          FileInfoCard(
            icon: AppIcon.speedIcon,
            title: l10n.speedLimit,
            subtitle: l10n.enableGeneralSpeedLimit,
            withSwitch: true,
          ),

          FileInfoCard(
            icon: AppIcon.networkIcon,
            title: l10n.onlyWiFi,
            subtitle: l10n.downloadOnlyViaWiFi,
            withSwitch: true,
          ),

          FileInfoCard(
            icon: AppIcon.infoIcon,
            title: l10n.roamingPause,
            subtitle: l10n.suspendWhileRoaming,
            withSwitch: true,
          ),

          FileInfoCard(
            icon: AppIcon.notificationIcon,
            title: l10n.notification,
            subtitle: l10n.notifyWhenCompleted,
            withSwitch: true,
          ),
        ],
      ),
    );
  }
}
