import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: AppConstant.containerPadding,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerWithBorderColor(),

          Expanded(
            child: Column(
              spacing: AppConstant.containerPadding,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Отчет_2024.pdf', style: theme.textTheme.titleMedium),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('5MB', style: theme.textTheme.bodySmall),
                    Text(
                      '15 нояб. 2025 г., 10:30',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),

                _status(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _status extends StatelessWidget {
  const _status({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.scrim.withOpacity(0.1),
      ),
      child: Text(
        'Завершено',
        style: theme.textTheme.bodySmall!.copyWith(
          color: theme.colorScheme.scrim,
        ),
      ),
    );
  }
}
