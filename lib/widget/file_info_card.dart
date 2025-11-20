import 'package:flutter/material.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
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
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.onTertiary),
      title: Text(title, style: theme.textTheme.bodySmall),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall!.copyWith(
          color: theme.colorScheme.tertiary,
        ),
      ),
    );
  }
}
