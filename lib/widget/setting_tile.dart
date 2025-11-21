import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({super.key , this.icon = Icons.settings, this.title = 'Title'});
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppConstant.containerPadding,
      children: [
        Icon(icon, color: theme.colorScheme.secondary),
        Text(title , style: theme.textTheme.titleMedium),
      ],
    );
  }
}
