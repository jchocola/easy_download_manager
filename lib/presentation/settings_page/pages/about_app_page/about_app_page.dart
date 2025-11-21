import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/file_info_card.dart';
import 'package:easy_download_manager/widget/file_info_card_2.dart';
import 'package:easy_download_manager/widget/setting_tile.dart';
import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: 'О приложении', showLeading: true),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppConstant.containerPadding,
            children: [
              Image.asset(
                'assets/logo.png',
                width: size.width * 0.3,
                height: size.width * 0.3,
              ),

              Text('Менеджер Загрузок', style: theme.textTheme.titleMedium),
              Text('Version 1.0.0+1 (BETA)', style: theme.textTheme.bodySmall),

              FileInfoCard(
                icon: AppIcon.calendarIcon,
                title: 'Дата сборки',
                subtitle: '2025-11-18',
              ),

              FileInfoCard(
                icon: AppIcon.developerIcon,
                title: 'Разработчик',
                subtitle: 'Nguen T.B',
              ),

              SettingTile(title: 'ПРАВОВАЯ ИНФОРМАЦИЯ'),

              FileInfoCard2(
                title: 'Пользователское соглашение',
                subtitle: '',
                icon: AppIcon.filesIcon,
              ),
              FileInfoCard2(
                title: 'Политика конфиденциальности',
                subtitle: '',
                icon: AppIcon.privacyPolicyIcon,
              ),

              Text('©2025 BacDev', style: theme.textTheme.bodySmall),
              Text('Все права защищены', style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
