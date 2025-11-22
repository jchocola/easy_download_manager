import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';

import 'package:easy_download_manager/presentation/settings_page/pages/network_speed_page/widgets/speed_setting.dart';
import 'package:easy_download_manager/presentation/settings_page/pages/other_setting.dart';
import 'package:easy_download_manager/widget/advice_card.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:easy_download_manager/widget/file_info_card.dart';
import 'package:easy_download_manager/widget/setting_tile.dart';
import 'package:flutter/material.dart';

class NetworkSpeedPage extends StatelessWidget {
  const NetworkSpeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppAppBar(title: l10n.speedLimit, showLeading: true),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [
            SettingTile(title: l10n.basicSettings, icon: AppIcon.speedIcon),
            Container(
              padding: EdgeInsets.all(AppConstant.containerPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstant.borderRadius),
                color: theme.colorScheme.onPrimary,
              ),
              child: FileInfoCard(
                withSwitch: true,
                icon: AppIcon.speedIcon,
                title: l10n.speedLimit,
                subtitle: l10n.enableDownloadSpeedLimit,
              ),
            ),

            SpeedSetting(),

            OtherSetting(),
            AdviceCard(title: l10n.optimizationAdvice, subtitle: l10n.setASpeedLimitToReserveBandwidthForOtherApplicationsAndEnsureAStableConnection,),
          ],
        ),
      ),
    );
  }
}
