import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class ContainerWithBorderColor extends StatelessWidget {
  const ContainerWithBorderColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
          colors: [AppColor.activeProgressColor, AppColor.activeEndColor],
        ),
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
      ),
      padding: EdgeInsets.all(AppConstant.containerPadding),
      child: Icon(Icons.download),
    );
  }
}
