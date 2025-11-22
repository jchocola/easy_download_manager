import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';

class ThreeInfo extends StatelessWidget {
  const ThreeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      spacing: AppConstant.containerPadding,
      children: [
        Expanded(
          child: _cutomWidget(
            title: l10n.speed,
            icon: AppIcon.speedIcon,
            subtitle: '10.0 MB/s',
          ),
        ),
        Expanded(
          child: _cutomWidget(
            title: l10n.network,
            icon: AppIcon.networkIcon,
            subtitle: 'Только Wi-Fi',
          ),
        ),
        Expanded(
          child: _cutomWidget(
            title: l10n.notification,
            icon: AppIcon.notificationIcon,
            subtitle: 'Включены',
          ),
        ),
      ],
    );
  }
}

class _cutomWidget extends StatelessWidget {
  const _cutomWidget({
    super.key,
    this.icon = Icons.download,
    this.title = 'title',
    this.subtitle = 'subtitle',
  });
  final IconData icon;
  final String title;
  final String subtitle;
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
          ContainerWithBorderColor(withGradient: true, icon: icon),
          Text(title, style: theme.textTheme.titleMedium, maxLines: 1),
          Text(subtitle, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
