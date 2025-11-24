import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/file_info_card_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingCategories extends StatelessWidget {
  const SettingCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      //padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        //color: theme.colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.containerPadding,
        children: [
          Text(l10n.categoriesSettings),

          FileInfoCard2(
            title: l10n.speedLimit,
            icon: AppIcon.speedIcon,
            subtitle: l10n.setSpeedLimitsAndRulesForAutomaticEnforcement,
            onTap: () => context.pushReplacement('/settings/network_speed'),
          ),
          FileInfoCard2(
            title: l10n.networkManagement,
            icon: AppIcon.networkIcon,
            subtitle: l10n.configureBehaviorWhenNetworkConnectionChanges,
            onTap: () => context.pushReplacement('/settings/network_setting'),
          ),
          FileInfoCard2(
            title: l10n.notification,
            icon: AppIcon.notificationIcon,
            subtitle: l10n.manageDownloadNotificationsAndSoundAlerts,
            onTap: () =>
                context.pushReplacement('/settings/notification_setting'),
          ),
          FileInfoCard2(
            title: l10n.language,
            icon: AppIcon.languageIcon,
            subtitle: 'vi - Vietnamese',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
