import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';

class MainInfoCompleted extends StatelessWidget {
  const MainInfoCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
      ),
      child: Column(
        spacing: AppConstant.containerPadding,
        children: [
          Text('Новый_фильм_4K.mkv', style: theme.textTheme.titleMedium),
          Divider(),

          _customInfo(
            title: 'Размер',
            value: '7.92 GB',
            icon: AppIcon.sizeIcon,
          ),
          _customInfo(
            title: 'Изменено',
            value: '18 ноября 2025 г. в 15:45',
            icon: AppIcon.calendarIcon,
          ),
          _customInfo(
            title: 'Путь',
            value: '/storage/Video/Новый_фильм_4K.mkv',
            icon: AppIcon.pathIcon,
          ),
          _customInfo(
            title: 'Тип',
            value: 'Файл',
            icon: AppIcon.typeFileIcon,
          ),
         
        ],
      ),
    );
  }
}

class _customInfo extends StatelessWidget {
  const _customInfo({
    super.key,
    this.title = 'title',
    this.value = 'value',
    this.icon = Icons.abc,
  });
  final String title;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppConstant.containerPadding,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Icon(icon, color: theme.colorScheme.onTertiary),
              Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onTertiary,
                ),
              ),
            ],
          ),
        ),

        Expanded(flex: 2, child: Text(value, style: theme.textTheme.titleSmall)),
      ],
    );
  }
}
