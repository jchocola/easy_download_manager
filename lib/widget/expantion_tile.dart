import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';

class ExpantionTile extends StatelessWidget {
  const ExpantionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(AppIcon.downloadIcon),
      title: Text('dsds'), subtitle: Text('dshjshds'),children: [
        
    ],);
  }
}
