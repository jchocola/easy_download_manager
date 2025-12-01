// ignore_for_file: non_constant_identifier_names

import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/picked_task_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/action_buttons.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/additional_info.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/file_info.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/main_info_completed.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/main_info_downloading.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/open_share_delete.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/speed_remain.dart';
import 'package:easy_download_manager/widget/advice_card.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadDetailPage extends StatelessWidget {
  const DownloadDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppAppBar(title: l10n.downloadDetails, showLeading: true),
      body: BlocBuilder<PickedTaskBloc, PickedTaskBlocState>(
        builder: (context, state) {
          if (state is PickedTaskBlocState_loaded) {
            if (state.task.status == DownloadTaskStatus.running) {
              return buildBody_when_downloading(context);
            } else {
              return buildBody_when_completed(context);
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget buildBody_when_downloading(context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [
            MainInfoDownloading(),
            SpeedRemain(),
            FileInfo(),
            ActionButtons(),
            BigButton(
              withGradient: true,
              icon: AppIcon.settingIcon,
              title: 'Настройки загрузки',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody_when_completed(context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [
            MainInfoCompleted(),
            OpenShareDelete(),
            AdviceCard(title: l10n.additionalInformation , subtitle: """
  • The file is located in the device's local storage.
  • You can open, share, or delete this file.
  • Deleting the file is irreversible.
""",),

          //  AdditionalInfo(),
            // SpeedRemain(),
            // FileInfo(),
            // ActionButtons(),
            // BigButton(
            //   withGradient: true,
            //   icon: AppIcon.settingIcon,
            //   title: 'Настройки загрузки',
            // ),
          ],
        ),
      ),
    );
  }
}
