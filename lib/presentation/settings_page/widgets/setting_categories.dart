import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';

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

          _FileInfoCard(title: 'Ограничение скорости', icon: AppIcon.speedIcon,subtitle: 'Установите лимит скорости и правила автоматического применения',),
          _FileInfoCard(title: 'Управление сетью', icon: AppIcon.networkIcon, subtitle: 'Настройте поведение при изменении сетевого подключения',),
          _FileInfoCard(title: 'Уведомления',icon: AppIcon.notificationIcon, subtitle: 'Управляйте уведомлениями о загрузках и звуковыми оповещениями',),
        ],
      ),
    );
  }
}

class _FileInfoCard extends StatelessWidget {
  const _FileInfoCard({
    super.key,
    this.icon = Icons.download,
    this.title = 'title',
    this.subtitle = 'subtitle',
    this.withSwitch = false,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final bool withSwitch;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimary,
      ),
      child: ListTile(
        leading: ContainerWithBorderColor(icon: icon, withGradient: true),
        title: Text(title, style: theme.textTheme.bodyMedium),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
        trailing: Icon(
          AppIcon.arrowForwardIcon,
          size: 14,
          color: theme.colorScheme.onTertiary,
        ),
      ),
    );
  }
}
