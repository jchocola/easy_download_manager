import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_download_manager/core/constant/router.dart';
import 'package:easy_download_manager/core/theme/dark_theme.dart';
import 'package:easy_download_manager/core/theme/light_theme.dart';
import 'package:easy_download_manager/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: appLightTheme,
      dark: appDarkTheme,
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'EDM',
        theme: theme,
        darkTheme: darkTheme,
        routerConfig: router,
       // home: const MainPage(),
      ),
    );
  }
}
