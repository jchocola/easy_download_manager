import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/button_with_icon.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: AppConstant.containerPadding,
      children: [
          Expanded(
            child: ButtonWithIcon(
                    label: 'Continue',
                    icon: AppIcon.continueIcon,
                    color: theme.colorScheme.tertiary,
                  ),
          ),
                Expanded(
                  child: ButtonWithIcon(
                    label: 'Cancel',
                    icon: AppIcon.cancelIcon,
                    color: theme.colorScheme.error,
                  ),
                ),
      ],
    );
  }
}
