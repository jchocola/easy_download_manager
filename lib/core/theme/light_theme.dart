import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:flutter/material.dart';

final appLightTheme =
    ThemeData.light(
      //useMaterial3: true
    ).copyWith(
      scaffoldBackgroundColor: AppLightColor.backgroundColor,
      colorScheme: ColorScheme.light(
        primary: AppLightColor.activeBeginColor,
        onPrimary: AppLightColor.onBackgroundColor,
        primaryContainer: AppLightColor.inactiveProgressColor,
        onPrimaryContainer: AppLightColor.mainTextColor.withOpacity(0.2),

        secondary: AppLightColor.activeProgressColor,
        onSecondary: AppLightColor.onBackgroundColor,

        tertiary: AppLightColor.mainTextColor,
        onTertiary: AppLightColor.secondTextColor,

        error: AppLightColor.cancelTextColor.withOpacity(0.8),
        onError: AppLightColor.onBackgroundColor,

        background: AppLightColor.backgroundColor,
        onBackground: AppLightColor.mainTextColor,

        surface: AppLightColor.onBackgroundColor,
        onSurface: AppLightColor.mainTextColor,

        tertiaryContainer: AppLightColor.inactiveProgressColor,
        onTertiaryContainer: AppLightColor.secondTextColor,
        onTertiaryFixed: AppLightColor.secondTextColor.withOpacity(0.3),
        tertiaryFixed:AppLightColor.secondTextColor.withOpacity(0.3) ,

        scrim: AppLightColor.successColor.withOpacity(0.8),
      ),

      textTheme: TextTheme(
        bodySmall: TextStyle(color: AppLightColor.secondTextColor),
        bodyMedium: TextStyle(color: AppLightColor.mainTextColor),
        titleMedium: TextStyle(color: AppLightColor.mainTextColor),
        titleLarge: TextStyle(color: AppLightColor.mainTextColor),
        labelLarge: TextStyle(color: AppLightColor.mainTextColor),
        titleSmall: TextStyle(color: AppLightColor.mainTextColor.withOpacity(0.7)),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppLightColor.onBackgroundColor,
        foregroundColor: AppLightColor.mainTextColor,
        elevation: 1,
        shadowColor: AppLightColor.borderColor,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppLightColor.activeBeginColor.withOpacity(0.5),
        foregroundColor: AppLightColor.onBackgroundColor,
      ),

      dividerTheme: DividerThemeData(
        color: AppLightColor.borderColor,
        thickness: 0.5,
        space: 1,
      ),

      cardTheme: CardThemeData(
        color: AppLightColor.onBackgroundColor,
        elevation: 1,
        shadowColor: AppLightColor.borderColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(AppLightColor.onBackgroundColor),
        trackColor: WidgetStatePropertyAll(AppLightColor.inactiveProgressColor),
        trackOutlineColor: WidgetStatePropertyAll(AppLightColor.borderColor),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppLightColor.onBackgroundColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      expansionTileTheme: ExpansionTileThemeData(
        iconColor: AppLightColor.activeProgressColor,
        textColor: AppLightColor.mainTextColor,
        collapsedTextColor: AppLightColor.mainTextColor,
        collapsedIconColor: AppLightColor.secondTextColor,
        shape: Border.all(color: AppLightColor.borderColor),
        collapsedShape: Border.all(color: AppLightColor.borderColor),
      ),

      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStatePropertyAll(AppLightColor.onBackgroundColor),
        fillColor: WidgetStatePropertyAll(AppLightColor.activeBeginColor),
        overlayColor: WidgetStatePropertyAll(
          AppLightColor.activeBeginColor.withOpacity(0.1),
        ),
        side: BorderSide(color: AppLightColor.borderColor),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            AppLightColor.activeBeginColor.withOpacity(0.8),
          ),
          foregroundColor: WidgetStatePropertyAll(
            AppLightColor.onBackgroundColor,
          ),
          elevation: WidgetStatePropertyAll(1),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),

      focusColor: AppLightColor.activeBeginColor.withOpacity(0.2),
      unselectedWidgetColor: AppLightColor.secondTextColor.withOpacity(0.6),
      hintColor: AppLightColor.secondTextColor,

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppLightColor.onBackgroundColor,
        selectedItemColor: AppLightColor.navBarActiveColor,
        unselectedItemColor: AppLightColor.navBarInActiveColor,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          color: AppLightColor.navBarActiveColor,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppLightColor.navBarInActiveColor,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 2,
      ),

      // Additional light theme specific settings
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppLightColor.backgroundColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppLightColor.borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppLightColor.borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppLightColor.activeBeginColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppLightColor.activeProgressColor,
        linearTrackColor: AppLightColor.inactiveProgressColor,
      ),
    );
