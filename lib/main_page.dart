import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.navigationShell});

  // Shell - это виджет, который предоставляет go_router
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        // Устанавливаем текущий индекс
        currentIndex: navigationShell.currentIndex,

        onTap: (value) {
          navigationShell.goBranch(value);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(AppIcon.downloadIcon),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcon.filesIcon),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcon.torrentIcon),
            label: 'Torrents',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcon.settingIcon),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
