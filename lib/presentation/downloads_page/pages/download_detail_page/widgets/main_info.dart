import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MainInfo extends StatelessWidget {
  const MainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      //margin: EdgeInsets.all(AppConstant.containerMargin / 2),
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
      ),
      child: Column(
        spacing: AppConstant.containerPadding,
        children: [
          fileName(context),
          SizedBox(height: AppConstant.containerPadding * 2),
          progress(context),

          Row(
            children: [
              Expanded(
                child: _customButton(
                  context,
                  title: 'Загружено',
                  subtitle: '33.85 MB',
                ),
              ),
              SizedBox(width: AppConstant.containerPadding),
              Expanded(
                child: _customButton(
                  context,
                  title: 'Всего',
                  subtitle: '43.11 MB',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget fileName(context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        ContainerWithBorderColor(withGradient: true),
        SizedBox(width: AppConstant.containerPadding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Презентация_финал.pdf', style: theme.textTheme.bodyMedium),
            Text('Загружается', style: theme.textTheme.bodySmall),
          ],
        ),
      ],
    );
  }

  Widget progress(context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      spacing: AppConstant.containerPadding,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Прогресс', style: theme.textTheme.titleSmall),
            Text(
              '98%',
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),

        StepProgressIndicator(
          fallbackLength: size.width * 0.7,
          totalSteps: 100,
          currentStep: 32,
          size: AppConstant.loadingHeight,
          padding: 0,
          selectedColor: AppColor.activeProgressColor,
          unselectedColor: AppColor.inactiveProgressColor,
          roundedEdges: Radius.circular(10),
        ),
      ],
    );
  }

  Widget _customButton(
    context, {
    String title = 'title',
    String subtitle = 'subtitle',
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.bodySmall),
          Text(subtitle, style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }
}
