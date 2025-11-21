import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';

class DownloadInfo extends StatelessWidget {
  const DownloadInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.containerPadding, vertical: AppConstant.containerPadding/2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimary,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              ContainerWithBorderColor(withGradient: true,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 spacing: AppConstant.containerPadding,
                children: [
                    Text('Файл', style: theme.textTheme.bodySmall,),
                    Text('data_2025.zip', style: theme.textTheme.titleMedium)
                ],
              )
            ],
          ),


          SizedBox(height: AppConstant.containerPadding*2,),

          Text('URL загрузки',style: theme.textTheme.bodySmall ),

          Text('https://fileserver.com/archive/data_2025.zip', style: theme.textTheme.titleMedium!.copyWith(letterSpacing: 2.5),)

        ],
      ),
    );
  }
}
