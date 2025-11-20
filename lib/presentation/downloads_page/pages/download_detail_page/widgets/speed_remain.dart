import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';

class SpeedRemain extends StatelessWidget {
  const SpeedRemain({super.key});

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
        spacing: AppConstant.containerPadding,
        children: [
          Expanded(child: _customButton(context , title: 'Скорость' , subtitle: '650 KB/s' , icon: AppIcon.speedIcon)),

          Expanded(child: _customButton(context , title: 'Осталось', subtitle: '2м 5с', icon: AppIcon.timeIcon)),
        ],
      ),
    );
  }

  Widget _customButton(
    context, {
    String title = 'title',
    String subtitle = 'subtitle',
    IconData icon = Icons.download
  }) {
    final theme = Theme.of(context);
    return Container(
      child: Row(
        children: [
          ContainerWithBorderColor(withGradient: true,icon: icon,),
          SizedBox(width: AppConstant.containerPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.bodySmall),
              Text(subtitle, style: theme.textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}
