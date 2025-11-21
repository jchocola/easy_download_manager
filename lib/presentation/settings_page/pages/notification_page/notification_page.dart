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

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: 'Уведомления', showLeading: true),
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
            SettingTile(
              title: 'УВЕДОМЛЕНИЯ О ЗАВЕРШЕНИИ',
              icon: AppIcon.speedIcon,
            ),
            Container(
              padding: EdgeInsets.all(AppConstant.containerPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstant.borderRadius),
                color: theme.colorScheme.onPrimary,
              ),
              child: FileInfoCard(
                withSwitch: true,
                icon: AppIcon.wifiIcon,
                title: 'Уведомления о завершении',
                subtitle: 'Получать уведомления когда загрузка завершена',
              ),
            ),

            SettingTile(title: 'ЗВУКОВЫЕ ОПОВЕЩЕНИЯ', icon: AppIcon.speedIcon),
            Container(
              padding: EdgeInsets.all(AppConstant.containerPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstant.borderRadius),
                color: theme.colorScheme.onPrimary,
              ),
              child: FileInfoCard(
                withSwitch: true,
                icon: AppIcon.infoIcon,
                title: 'Звуковые оповещения',
                subtitle: 'Воспроизводить звук при завершении загрузки',
              ),
            ),

            OtherSetting(),
            AdviceCard(
              title: 'Совет',
              subtitle:
                  'Включите звуковые оповещения, чтобы не пропустить завершение важных загрузок. Прогресс в статус-баре помогает отслеживать загрузки без открытия приложения.',
            ),
          ],
        ),
      ),
    );
  }
}
