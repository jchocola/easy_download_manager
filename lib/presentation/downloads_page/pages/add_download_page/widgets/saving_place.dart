import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/input.dart';
import 'package:flutter/material.dart';

class SavingPlace extends StatelessWidget {
  const SavingPlace({super.key});

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
        spacing: AppConstant.containerPadding,
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Icon(AppIcon.folderIcon, color: theme.colorScheme.secondary),
              Text('Место хранения', style: theme.textTheme.titleMedium),
            ],
          ),

          Text('Укажите где сохранить файл', style: theme.textTheme.bodySmall),

          Text('Имя файла', style: theme.textTheme.bodyMedium),
          Input(hintText: 'document.pdf'),

          Text('Папка сохранения', style: theme.textTheme.bodyMedium),
          Input(hintText: '/downloads'),

          Text('Быстрый выбор', style: theme.textTheme.bodySmall),

          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Expanded(child: _customButton(context , selected: true , title: 'Downloads' , icon: AppIcon.downloadIcon)),
              Expanded(child: _customButton(context ,title:  'Documents' , icon: AppIcon.folderIcon))
            ],
          ),


          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Expanded(child: _customButton(context ,title: 'Videos', icon: AppIcon.videoIcon)),
              Expanded(child: _customButton(context, title: 'Musics' , icon: AppIcon.musicIcon))
            ],
          )
        ],
      ),
    );
  }

  Widget _customButton(context , {bool selected = false , IconData icon = Icons.add , String title = 'title'}) {
     final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.tertiaryFixed),
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color:selected ? theme.colorScheme.onPrimaryContainer :  theme.colorScheme.onPrimary,
      ), 
      child: Center(
        child : Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppConstant.containerPadding,
          children: [
            Icon(icon),
            Text(title , style: theme.textTheme.bodyMedium,)
          ],
        ),
      ),
    );
  }
}
