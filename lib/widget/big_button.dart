import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
   const BigButton({
    super.key,
    this.withGradient = false,
    this.icon = Icons.add,
    this.title = 'title',
    this.onTap,
  });
  final bool withGradient;
  final IconData icon;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppConstant.containerPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          color: theme.colorScheme.onPrimary,
      
          gradient: withGradient ? LinearGradient(
            colors: [AppColor.activeBeginColor, AppColor.activeEndColor],
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
          ) : null,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppConstant.containerPadding,
            children: [
              Icon(icon),
              Text(title, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
