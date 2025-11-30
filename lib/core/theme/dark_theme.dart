import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

final appDarkTheme =
    ThemeData.dark(
      //useMaterial3: true
    ).copyWith(
      scaffoldBackgroundColor: AppDarkColor.backgroundColor,
      colorScheme: ColorScheme.dark(
        onPrimary: AppDarkColor.onBackgroundColor,
        onPrimaryContainer: AppDarkColor.inactiveProgressColor,

        secondary: AppDarkColor.activeProgressColor,

        tertiary: AppDarkColor.mainTextColor,
        onTertiary: AppDarkColor.secondTextColor,
        error: AppDarkColor.cancelTextColor,
        tertiaryFixed: AppDarkColor.inactiveProgressColor,
        scrim: AppDarkColor.successColor,
      ),

      textTheme: TextTheme(
        bodySmall: TextStyle(color: AppDarkColor.secondTextColor),
        bodyMedium: TextStyle(color: AppDarkColor.mainTextColor),

        titleMedium: TextStyle(color: AppDarkColor.mainTextColor),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppDarkColor.onBackgroundColor,
        //foregroundColor: AppColor.activeEndColor,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppDarkColor.inactiveProgressColor,
        foregroundColor: AppDarkColor.secondTextColor,
      ),

      dividerTheme: DividerThemeData(
        color: AppDarkColor.navBarInActiveColor,
        thickness: 0.3,
      ),

      cardTheme: CardThemeData(color: AppDarkColor.onBackgroundColor),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(AppDarkColor.inactiveProgressColor),
        trackColor: WidgetStatePropertyAll(AppDarkColor.activeProgressColor),
        trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppDarkColor.backgroundColor,
      ),

      expansionTileTheme: ExpansionTileThemeData(
        iconColor: AppDarkColor.activeProgressColor,
        shape: Border.all(color: AppDarkColor.activeProgressColor),
      ),

      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStatePropertyAll(AppDarkColor.successColor),
        fillColor: WidgetStatePropertyAll(AppDarkColor.inactiveProgressColor),
        overlayColor: WidgetStatePropertyAll(
          AppDarkColor.inactiveProgressColor,
        ),
        side: BorderSide(color: AppDarkColor.activeProgressColor),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            AppDarkColor.onBackgroundColor,
          ),
          foregroundColor: WidgetStatePropertyAll(
            AppDarkColor.navBarInActiveColor,
          ),
        ),
      ),

      focusColor: AppDarkColor.mainTextColor,
      unselectedWidgetColor: AppDarkColor.secondTextColor.withOpacity(0.5),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppDarkColor.onBackgroundColor,
        selectedItemColor: AppDarkColor.navBarActiveColor,
        unselectedItemColor: AppDarkColor.navBarInActiveColor,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: AppDarkColor.navBarActiveColor),
        unselectedLabelStyle: TextStyle(
          color: AppDarkColor.navBarInActiveColor,
        ),
        type: BottomNavigationBarType.fixed,
      ),
    );
