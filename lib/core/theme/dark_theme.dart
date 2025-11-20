import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

final appDarkTheme = ThemeData.dark(
  //useMaterial3: true
).copyWith(
  scaffoldBackgroundColor: AppColor.backgroundColor,
  colorScheme: ColorScheme.dark(
    onPrimary: AppColor.onBackgroundColor,
    onPrimaryContainer: AppColor.inactiveProgressColor,

    secondary: AppColor.activeProgressColor,

    tertiary: AppColor.mainTextColor,
    error: AppColor.cancelTextColor,

    scrim: AppColor.successColor,

  ),

  textTheme: TextTheme(
    bodySmall: TextStyle(color: AppColor.secondTextColor),
    bodyMedium:TextStyle(color: AppColor.mainTextColor), 


    titleMedium: TextStyle(color: AppColor.mainTextColor)
  ),


  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.onBackgroundColor,
    //foregroundColor: AppColor.activeEndColor,
  ),

  


  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.inactiveProgressColor,
    foregroundColor: AppColor.secondTextColor
  ),



  dividerTheme: DividerThemeData(
    color: AppColor.navBarInActiveColor,
    thickness: 0.3
  ),



  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(AppColor.onBackgroundColor),
      foregroundColor: WidgetStatePropertyAll(AppColor.navBarInActiveColor)
    )
  ),


  focusColor: AppColor.mainTextColor,
  unselectedWidgetColor: AppColor.secondTextColor.withOpacity(0.5),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
  backgroundColor: AppColor.onBackgroundColor,
  selectedItemColor: AppColor.navBarActiveColor,
  unselectedItemColor: AppColor.navBarInActiveColor,
  showUnselectedLabels: true,
  selectedLabelStyle: TextStyle(color: AppColor.navBarActiveColor,),
  unselectedLabelStyle: TextStyle(color: AppColor.navBarInActiveColor,),
  type: BottomNavigationBarType.fixed
  )
);
