import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';

class DownloadTypeCard extends StatelessWidget {
  const DownloadTypeCard({super.key , this.icon = Icons.abc, this.title = 'title', this.subtitle = 'subtitle', this.onChanged});
  final String title;
  final String subtitle;
  final IconData icon;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(title, style: theme.textTheme.bodyMedium),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall,
      ),
      leading: Checkbox(value: true, onChanged: onChanged),
      trailing: Icon(
        icon,
        color: theme.colorScheme.onTertiary,
      ),
    );
  }
}
