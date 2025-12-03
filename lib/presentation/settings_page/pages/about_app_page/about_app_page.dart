import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/domain/models/download_task.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/file_info_card.dart';
import 'package:easy_download_manager/widget/file_info_card_2.dart';
import 'package:easy_download_manager/widget/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppAppBar(title: l10n.aboutTheApp, showLeading: true),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context);
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

              Text(
                l10n.edmEasyDownloadManager,
                style: theme.textTheme.titleMedium,
              ),
              Text(AppConstant.appVersion, style: theme.textTheme.bodySmall),

              FileInfoCard(
                icon: AppIcon.calendarIcon,
                title: l10n.buildDate,
                subtitle: AppConstant.buildDate,
              ),

              FileInfoCard(
                icon: AppIcon.developerIcon,
                title: l10n.developer,
                subtitle: AppConstant.developer,
              ),

              SettingTile(title: l10n.legalInformation),

              FileInfoCard2(
                title: l10n.termsOfService,
                subtitle: '',
                icon: AppIcon.filesIcon,
                onTap: () {
                  // context.read<AddDownloadBloc>().add(
                  //   AddDownloadBlocEvent_onLegalInfoTap(
                  //     url: AppConstant.termsOfServiceURLDownload,
                  //   ),
                  // );

                    context.push('/settings/about_app/term_service');
                },
              ),
              FileInfoCard2(
                title: l10n.privacyPolicy,
                subtitle: '',
                icon: AppIcon.privacyPolicyIcon,
                onTap: () {
                  // context.read<AddDownloadBloc>().add(
                  //   AddDownloadBlocEvent_onLegalInfoTap(
                  //     url: AppConstant.privacyPolicyURLDownload,
                  //   ),
                  // );

                  context.push('/settings/about_app/privacy_policy');
                },
              ),

              Text(AppConstant.BacDev, style: theme.textTheme.bodySmall),
              Text(l10n.allRightsReserved, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
