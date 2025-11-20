import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/file_info_card.dart';
import 'package:flutter/material.dart';

class FileInfo extends StatelessWidget {
  const FileInfo({super.key});

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
        children: [
          Text(
            'ИНФОРМАЦИЯ О ФАЙЛЕ',
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onTertiary,
            ),
          ),
          FileInfoCard(
            icon: AppIcon.urlIcon,
            title: 'URL',
            subtitle: 'https://example.com/files/Презентация_финал.pdf',
          ),
          FileInfoCard(
            icon: AppIcon.folderIcon,
            title: 'Путь сохранения',
            subtitle: '/storage/Downloads/pdf',
          ),
          FileInfoCard(
            icon: AppIcon.calendarIcon,
            title: 'Начало загрузки',
            subtitle: '18.11.2025, 10:00',
          ),

          Text(
            'ПАРАМЕТРЫ',
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onTertiary,
            ),
          ),

          FileInfoCard(
            icon: AppIcon.sourceIcon,
            title: 'Тип источника',
            subtitle: 'HTTP/HTTPS',
          ),

           FileInfoCard(
            icon: AppIcon.priorityIcon,
            title: 'Приоритет',
            subtitle: 'Нормальный',
          ),

          FileInfoCard(
            icon: AppIcon.resumableIcon,
            title: 'Возобновляемая',
            subtitle: 'Да',
          ),

        ],
      ),
    );
  }
}
