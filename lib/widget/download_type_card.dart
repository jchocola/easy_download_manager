import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';

class DownloadTypeCard extends StatelessWidget {
  const DownloadTypeCard({
    super.key,
    this.icon = Icons.abc,
    this.title = 'title',
    this.subtitle = 'subtitle',
    this.value = false,
    this.onTap
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final void Function()? onTap;
  final bool value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      title: Text(title, style: theme.textTheme.bodyMedium),
      subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
      leading: Checkbox(value: value, onChanged: (value) {
        
      },),
      trailing: Icon(icon, color: theme.colorScheme.onTertiary),
    );
  }
}
