import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/providers/download_repository.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/settings_page/blocs/download_settings_cubit.dart';
import 'package:easy_download_manager/presentation/settings_page/widgets/default_directory_card.dart';
import 'package:easy_download_manager/presentation/settings_page/widgets/quick_setting.dart';
import 'package:easy_download_manager/presentation/settings_page/widgets/setting_categories.dart';
import 'package:easy_download_manager/presentation/settings_page/widgets/three_info.dart';
import 'package:easy_download_manager/widget/advice_card.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
     final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => DownloadSettingsCubit(
        repository: context.read<DownloadRepository>(),
      ),
      child: Scaffold(
        appBar: AppAppBar(
          title: l10n.settings,
          showActions: true,
          actionIcon: AppIcon.infoIcon,
          onActionTapped: () => context.push('/settings/about_app'),
        ),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(context) {
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
            ThreeInfo(),

            SizedBox(height: AppConstant.containerPadding * 2),
            SettingCategories(),
            QuickSetting(),
            DefaultDirectoryCard(),
            AdviceCard(title: l10n.advice, subtitle: l10n.useSpeedLimitsToSaveBandwidthAndPreventNetworkOverloadNetworkSettingsWillHelpOptimizeDownloadsDependingOnTheTypeOfConnection,),
          ],
        ),
      ),
    );
  }
}
