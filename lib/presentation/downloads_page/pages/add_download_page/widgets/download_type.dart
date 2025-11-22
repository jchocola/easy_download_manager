import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/download_type_card.dart';
import 'package:flutter/material.dart';

class DownloadType extends StatelessWidget {
  const DownloadType({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.containerPadding,
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Icon(AppIcon.settingIcon, color: theme.colorScheme.secondary),
              Text(l10n.downloadType, style: theme.textTheme.titleMedium),
            ],
          ),
          Text(
            l10n.selectHowYouWantToDownloadTheFile,
            style: theme.textTheme.bodySmall,
          ),

          DownloadTypeCard(
            title: l10n.httpHttps,
            subtitle: l10n.directDownloadFromWebServer,
            icon: AppIcon.downloadTypeHttpIcon,
          ),
          DownloadTypeCard(
            title: l10n.torrent,
            subtitle: l10n.downloadingViaTorrentProtocol,
            icon: AppIcon.downloadTypeTorrentIcon,
          ),
          DownloadTypeCard(
            title: l10n.cloud,
            subtitle: l10n.downloadingFromCloudServices,
            icon: AppIcon.downloadTypeCloudIcon,
          ),
        ],
      ),
    );
  }
}
