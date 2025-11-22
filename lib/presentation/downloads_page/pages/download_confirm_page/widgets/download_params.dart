import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/file_info_card.dart';
import 'package:flutter/material.dart';

class DownloadParams extends StatelessWidget {
  const DownloadParams({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
      final l10n = AppLocalizations.of(context);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: AppConstant.containerPadding, vertical: AppConstant.containerPadding/2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimary,
      ),

      child: Column(
        children: [
            FileInfoCard(
            icon: AppIcon.downloadIcon,
            title: l10n.downloadType,
            subtitle: 'Прямая ссылка (HTTP/HTTPS)',
            withSwitch: false,
          ),

           FileInfoCard(
            icon: AppIcon.pathIcon,
            title: l10n.storageLocation,
            subtitle: '/storage/Documents/Archives',
            withSwitch: false,
          ),


           FileInfoCard(
            icon: AppIcon.priorityIcon,
            title: l10n.priority,
            subtitle: 'Высокий',
            withSwitch: false,
          ),

           FileInfoCard(
            icon: AppIcon.speedIcon,
            title: l10n.speedLimit,
            subtitle: '5.0 МБ/с',
            withSwitch: false,
          ),
        ],
      ),
    );
  }
}
