import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:easy_download_manager/widget/big_button_delete.dart';
import 'package:flutter/material.dart';

class OpenShareDelete extends StatelessWidget {
  const OpenShareDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.containerPadding,
      children: [
       BigButton(icon: AppIcon.folderIcon, title: 'Open file',),
       BigButton(icon: AppIcon.shareIcon, title: 'Share',), 
       BigButtonDelete(icon: AppIcon.deleteIcon, title: 'Delete',),  
      ],
    );
  }
}
