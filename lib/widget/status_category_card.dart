///
/// USING FOR DISPLAY (ACTIVE + COMPLETED + ERROR + PAUSE)
///

import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class StatusCategoryCard extends StatelessWidget {
  const StatusCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      
      margin: EdgeInsets.all(AppConstant.containerMargin/2),
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
      ),
      child: Text('Text'),
    );
  }
}
