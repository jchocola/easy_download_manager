import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SpeedSetting extends StatelessWidget {
  const SpeedSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
     final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimary,
      ),
      child: Column(
        spacing: AppConstant.containerPadding,
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Text(l10n.maximumSpeed, style: theme.textTheme.titleSmall),
              Spacer(),
              Text(
                '80.0',
                style: theme.textTheme.titleMedium!.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
              Text('Мбит/с', style: theme.textTheme.bodySmall),
            ],
          ),

          StepProgressIndicator(
            totalSteps: 4,
            currentStep: 1,
            selectedColor: theme.colorScheme.secondary,
            unselectedColor: theme.colorScheme.tertiaryFixed,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonWithIcon(label: '1 Мбит/с'),
              ButtonWithIcon(label: '5 Мбит/с'),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonWithIcon(label: '10 Мбит/с'),
              ButtonWithIcon(label: l10n.maximumSpeed),
            ],
          ),
        ],
      ),
    );
  }
}
