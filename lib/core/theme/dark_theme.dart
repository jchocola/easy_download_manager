import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:flutter/material.dart';

final appDarkTheme = ThemeData.dark(
  useMaterial3: true
).copyWith(
  scaffoldBackgroundColor: AppColor.backgroundColor,

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
  backgroundColor: AppColor.onBackgroundColor,
  selectedItemColor: AppColor.navBarActiveColor,
  unselectedItemColor: AppColor.navBarInActiveColor,
  showUnselectedLabels: true,
  selectedLabelStyle: TextStyle(color: AppColor.navBarActiveColor,),
  unselectedLabelStyle: TextStyle(color: AppColor.navBarInActiveColor,),
  type: BottomNavigationBarType.shifting
  )
);
