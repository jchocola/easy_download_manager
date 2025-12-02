import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_download_manager/app_config.bloc.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/utils/language_convert.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/settings_page/pages/language_page/language_page.dart';
import 'package:easy_download_manager/widget/file_info_card_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingCategories extends StatelessWidget {
  const SettingCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void languageTapped() {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(height: size.height * 0.6, child: LanguagePage());
        },
      );
    }

    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      //padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        //color: theme.colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.containerPadding,
        children: [
          Text(l10n.categoriesSettings),

          // FileInfoCard2(
          //   title: l10n.speedLimit,
          //   icon: AppIcon.speedIcon,
          //   subtitle: l10n.setSpeedLimitsAndRulesForAutomaticEnforcement,
          //   onTap: () => context.pushReplacement('/settings/network_speed'),
          // ),
          // FileInfoCard2(
          //   title: l10n.networkManagement,
          //   icon: AppIcon.networkIcon,
          //   subtitle: l10n.configureBehaviorWhenNetworkConnectionChanges,
          //   onTap: () => context.pushReplacement('/settings/network_setting'),
          // ),
          // FileInfoCard2(
          //   title: l10n.notification,
          //   icon: AppIcon.notificationIcon,
          //   subtitle: l10n.manageDownloadNotificationsAndSoundAlerts,
          //   onTap: () =>
          //       context.pushReplacement('/settings/notification_setting'),
          // ),
          FileInfoCard2(
            title: l10n.theme,
            icon: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                ? AppIcon.themeDarkIcon
                : AppIcon.themeLightIcon,
            subtitle: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                ? l10n.darkMode
                : l10n.lightMode,
            onTap: () => AdaptiveTheme.of(context).toggleThemeMode(),
          ),

          BlocBuilder<AppConfigBloc, AppConfigBlocState>(
            builder: (context, state) {
              if (state is AppConfigBloacState_Loaded) {
                return FileInfoCard2(
                  title: l10n.language,
                  icon: AppIcon.languageIcon,
                  subtitle: LanguageConverter(languageCode: state.locale),
                  onTap: languageTapped,
                );
              } else {
               return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
