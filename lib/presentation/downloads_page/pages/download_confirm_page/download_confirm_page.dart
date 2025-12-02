import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/utils/custom_toastification.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_confirm_page/widgets/download_info.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_confirm_page/widgets/download_params.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_confirm_page/widgets/notice.dart';
import 'package:easy_download_manager/widget/advice_card.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DownloadConfirmPage extends StatelessWidget {
  const DownloadConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppAppBar(title: l10n.downloadConfirmation, showLeading: true),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
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
            DownloadInfo(),
            DownloadParams(),
            BlocListener<AddDownloadBloc, AddDownloadBlocState>(
              listener: (context, state) {
                if (state is AddDownloadBlocStateError) {
                  showErrorToastification(error: state.error);
                  context.go('/downloads');
                }

                if (state is AddDownloadBlocStateSuccess) {
                  showSuccessToastification(success: state.success);
                  context.go('/downloads');
                }
              },
              child: BigButton(
                withGradient: true,
                title: l10n.startDownloading,
                icon: AppIcon.downloadIcon,
                onTap: () => context.read<AddDownloadBloc>().add(
                  AddDownloadBlocEvent_StartDownload(
                    notificationTitle: l10n.torrentnotificationtitle,
                    notificationContent: l10n.torrentnotificationcontent,
                  ),
                ),
              ),
            ),

            BigButton(
              withGradient: false,
              title: l10n.editSettings,
              icon: AppIcon.settingIcon,
              onTap: () => context.pop(),
            ),

            AdviceCard(
              title: l10n.attention,
              subtitle: l10n
                  .ensureThatAllDownloadSettingsAreConfiguredCorrectlyBeforeConfirming,
            ),
          ],
        ),
      ),
    );
  }
}
