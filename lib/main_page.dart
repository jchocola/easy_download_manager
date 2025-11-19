import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(AppIcon.downloadIcon), label: 'Downloads'),
          BottomNavigationBarItem(icon: Icon(AppIcon.filesIcon), label: 'Files'),
          BottomNavigationBarItem(icon: Icon(AppIcon.torrentIcon), label: 'Torrents'),
          BottomNavigationBarItem(icon: Icon(AppIcon.settingIcon), label: 'Settings'),
        ],
      ),
    );
  }
}
