import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/download_type_card.dart';
import 'package:flutter/material.dart';

class DownloadType extends StatelessWidget {
  const DownloadType({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              Text('Тип загрузки', style: theme.textTheme.titleMedium),
            ],
          ),
          Text(
            'Выберите способ загрузки файла',
            style: theme.textTheme.bodySmall,
          ),

          DownloadTypeCard(
            title: 'HTTP/HTTPS',
            subtitle: 'Прямая загрузка с веб-сервера',
            icon: AppIcon.downloadTypeHttpIcon,
          ),
          DownloadTypeCard(
            title: 'Торрент',
            subtitle: 'Загрузка через торрент-протокол',
            icon: AppIcon.downloadTypeTorrentIcon,
          ),
          DownloadTypeCard(
            title: 'Облако',
            subtitle: 'Загрузка из облачных сервисов',
            icon: AppIcon.downloadTypeCloudIcon,
          ),
        ],
      ),
    );
  }
}
