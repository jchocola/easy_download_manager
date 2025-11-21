import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/presentation/settings_page/pages/network_speed_page/widgets/advice.dart';
import 'package:easy_download_manager/presentation/settings_page/pages/network_speed_page/widgets/speed_setting.dart';
import 'package:easy_download_manager/presentation/settings_page/pages/other_setting.dart';
import 'package:easy_download_manager/widget/advice_card.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:easy_download_manager/widget/file_info_card.dart';
import 'package:easy_download_manager/widget/setting_tile.dart';
import 'package:flutter/material.dart';

class NetworkSettingPage extends StatelessWidget {
  const NetworkSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: 'Настройки сети' , showLeading: true,),
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
            SettingTile(title: 'ЗАГРУЗКА ПО WI-FI', icon: AppIcon.speedIcon),
            Container(
              padding: EdgeInsets.all(AppConstant.containerPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstant.borderRadius),
                color: theme.colorScheme.onPrimary,
              ),
              child: FileInfoCard(
                withSwitch: true,
                icon: AppIcon.wifiIcon,
                title: 'Загрузка только по Wi-Fi',
                subtitle: 'Загрузки будут доступны только при подключении к Wi-Fi сети',
              ),
            ),



              SettingTile(title: 'РОУМИНГ', icon: AppIcon.speedIcon),
             Container(
              padding: EdgeInsets.all(AppConstant.containerPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstant.borderRadius),
                color: theme.colorScheme.onPrimary,
              ),
              child: FileInfoCard(
                withSwitch: true,
                icon: AppIcon.infoIcon,
                title: 'Пауза при роуминге',
                subtitle: 'Автоматически приостанавливать загрузки при международном роуминге',
              ),
            ),

            //SpeedSetting(),

              SettingTile(title: 'АВТОМАТИЧЕСКОЕ ВОЗОБНОВЛЕНИЕ', icon: AppIcon.speedIcon),

              Container(
              padding: EdgeInsets.all(AppConstant.containerPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstant.borderRadius),
                color: theme.colorScheme.onPrimary,
              ),
              child: FileInfoCard(
                withSwitch: true,
                icon: AppIcon.infoIcon,
                title: 'Автоматическое возобновление',
                subtitle: 'Возобновлять загрузки при восстановлении сетевого подключения',
              ),
            ),

            OtherSetting(),
            AdviceCard(title: 'Совет по экономии трафика', subtitle: 'Включите "Загрузка только по Wi-Fi" и "Пауза при роуминге" для экономии мобильного трафика и снижения расходов.',),


          
          ],
        ),
      ),
    );
  }
}
