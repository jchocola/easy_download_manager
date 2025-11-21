import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:easy_download_manager/widget/file_info_card_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingCategories extends StatelessWidget {
  const SettingCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          Text('КАТЕГОРИИ НАСТРОЕК'),

          FileInfoCard2(
            title: 'Ограничение скорости',
            icon: AppIcon.speedIcon,
            subtitle:
                'Установите лимит скорости и правила автоматического применения',
            onTap: () => context.pushReplacement('/settings/network_speed'),
          ),
          FileInfoCard2(
            title: 'Управление сетью',
            icon: AppIcon.networkIcon,
            subtitle: 'Настройте поведение при изменении сетевого подключения',
            onTap: () => context.pushReplacement('/settings/network_setting'),
          ),
          FileInfoCard2(
            title: 'Уведомления',
            icon: AppIcon.notificationIcon,
            subtitle:
                'Управляйте уведомлениями о загрузках и звуковыми оповещениями',
            onTap: () =>
                context.pushReplacement('/settings/notification_setting'),
          ),
          FileInfoCard2(
            title: 'Язык',
            icon: AppIcon.languageIcon,
            subtitle: 'vi - Vietnamese',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
