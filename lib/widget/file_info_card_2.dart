import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';

class FileInfoCard2 extends StatelessWidget {
  const FileInfoCard2({
    super.key,
    this.icon = Icons.download,
    this.title = 'title',
    this.subtitle = 'subtitle',
    this.withSwitch = false,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final bool withSwitch;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
