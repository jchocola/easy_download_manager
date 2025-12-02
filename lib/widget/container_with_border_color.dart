import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';

class ContainerWithBorderColor extends StatelessWidget {
  const ContainerWithBorderColor({
    super.key,
    this.icon = Icons.download,
    this.withGradient = false,
    this.color = Colors.amber,
  });
  final IconData icon;
  final bool withGradient;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        gradient: withGradient
            ? LinearGradient(
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomRight,
                colors: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                    ? [
                        AppDarkColor.activeBeginColor,
                        AppDarkColor.activeEndColor,
                      ]
                    : [
                        AppLightColor.activeBeginColor,
                        AppLightColor.activeEndColor,
                      ],
              )
            : null,
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
      ),
      padding: EdgeInsets.all(AppConstant.containerPadding),
      child: Icon(icon),
    );
  }
}
