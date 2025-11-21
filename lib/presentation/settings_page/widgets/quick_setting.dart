import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/file_info_card.dart';
import 'package:flutter/material.dart';

class QuickSetting extends StatelessWidget {
  const QuickSetting({super.key});

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
        spacing: AppConstant.containerPadding,
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Icon(AppIcon.settingIcon, color: theme.colorScheme.secondary),
              Text('БЫСТРЫЕ ПЕРЕКЛЮЧАТЕЛИ', style: theme.textTheme.titleMedium),
            ],
          ),

          FileInfoCard(
            icon: AppIcon.speedIcon,
            title: 'Ограничение скорости',
            subtitle: 'Включить общий лимит скорости',
            withSwitch: true,
          ),

          FileInfoCard(
            icon: AppIcon.networkIcon,
            title: 'Только Wi-Fi',
            subtitle: 'Загружать только по Wi-Fi',
            withSwitch: true,
          ),

          FileInfoCard(
            icon: AppIcon.infoIcon,
            title: 'Пауза при роуминге',
            subtitle: 'Приостановить при роуминге',
            withSwitch: true,
          ),

          FileInfoCard(
            icon: AppIcon.notificationIcon,
            title: 'Уведомления',
            subtitle: 'Уведомлять о завершении',
            withSwitch: true,
          ),
        ],
      ),
    );
  }
}
