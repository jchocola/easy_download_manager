import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/presentation/settings_page/pages/network_speed_page/widgets/advice.dart';
import 'package:easy_download_manager/presentation/settings_page/pages/network_speed_page/widgets/speed_setting.dart';
import 'package:easy_download_manager/presentation/settings_page/pages/other_setting.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:easy_download_manager/widget/file_info_card.dart';
import 'package:easy_download_manager/widget/setting_tile.dart';
import 'package:flutter/material.dart';

class NetworkSpeedPage extends StatelessWidget {
  const NetworkSpeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: 'Ограничение скорости' , showLeading: true,),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [
            SettingTile(title: 'ОСНОВНЫЕ НАСТРОЙКИ', icon: AppIcon.speedIcon),
            Container(
              padding: EdgeInsets.all(AppConstant.containerPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstant.borderRadius),
                color: theme.colorScheme.onPrimary,
              ),
              child: FileInfoCard(
                withSwitch: true,
                icon: AppIcon.speedIcon,
                title: 'Ограничение скорости',
                subtitle: 'Включить ограничение скорости загрузки',
              ),
            ),

            SpeedSetting(),


            OtherSetting(),
            Advice(),


          
          ],
        ),
      ),
    );
  }
}
