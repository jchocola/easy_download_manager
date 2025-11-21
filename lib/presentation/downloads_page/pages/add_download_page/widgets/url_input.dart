import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/input.dart';
import 'package:flutter/material.dart';

class UrlInput extends StatelessWidget {
  const UrlInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
       padding: EdgeInsets.all(AppConstant.containerPadding),
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
            Icon(AppIcon.urlIcon , color: theme.colorScheme.secondaryContainer,),
            Text('URL Downloads' , style: theme.textTheme.titleMedium,)
          ],),

          Text('Введите ссылку на файл для загрузки', style: theme.textTheme.bodySmall,),

          SizedBox(height: AppConstant.containerPadding*2,),

          Text('URL' ,style:  theme.textTheme.titleSmall,),
          Input(hintText: AppConstant.urlHintText,)
        ],
      ),
    );
  }
}
