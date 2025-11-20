///
/// USING FOR DISPLAY (ACTIVE + COMPLETED + ERROR + PAUSE)
///

import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';

class StatusCategoryCard extends StatelessWidget {
  const StatusCategoryCard({
    super.key,
    this.label = 'Label',
    this.count = '0',
    this.withGradient = false,
    this.color = Colors.grey,
    this.icon = Icons.download
  });
  final String label;
  final String count;
  final bool withGradient;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(AppConstant.containerMargin / 2),
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
      ),
      child: Row(
        children: [
          ContainerWithBorderColor(withGradient: withGradient, color: color , icon: icon,),

          SizedBox(width: AppConstant.containerPadding),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodySmall),
              Text(
                count,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
