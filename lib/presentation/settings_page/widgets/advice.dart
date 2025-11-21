import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';

class Advice extends StatelessWidget {
  const Advice({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.containerPadding,
        children: [
          Icon(AppIcon.infoIcon ,color: theme.colorScheme.secondary,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Совет' , style: theme.textTheme.titleMedium,),
                Text(
                  'Используйте ограничение скорости для экономии трафика и предотвращения перегрузки сети. Настройки сети помогут оптимизировать загрузки в зависимости от типа подключения.',
                   style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
