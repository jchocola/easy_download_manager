import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/status_category_card.dart';
import 'package:flutter/material.dart';

class FourStatusCategory extends StatelessWidget {
  const FourStatusCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: StatusCategoryCard(
                label: 'Активные',
                count: '34',
                withGradient: true,
              ),
            ),
            Expanded(
              flex: 1,
              child: StatusCategoryCard(
                label: 'Завершено',
                count: '2',
                color: theme.colorScheme.scrim,
                icon: AppIcon.completedIcon,
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              flex: 1,
              child: StatusCategoryCard(
                label: 'Ошибки',
                count: '4',
                color: theme.colorScheme.error,
                icon: AppIcon.errorIcon,
              ),
            ),
            Expanded(
              flex: 1,
              child: StatusCategoryCard(
                label: 'На паузе',
                count: '3',
                color: theme.colorScheme.tertiaryFixed,
                icon: AppIcon.pauseIcon,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
