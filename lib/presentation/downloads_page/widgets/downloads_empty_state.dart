import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class DownloadsEmptyState extends StatelessWidget {
  const DownloadsEmptyState({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: AppConstant.containerPadding * 2),
      child: Center(
        child: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

