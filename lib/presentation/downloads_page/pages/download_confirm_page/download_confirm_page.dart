import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_confirm_page/widgets/download_info.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_confirm_page/widgets/download_params.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_confirm_page/widgets/notice.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DownloadConfirmPage extends StatelessWidget {
  const DownloadConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: 'Подтверждение загрузки', showLeading: true),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
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
            BigButton(
              withGradient: true,
              title: 'Начать загрузку',
              icon: AppIcon.downloadIcon,
            ),

            BigButton(
              withGradient: false,
              title: 'Редактировать параметры',
              icon: AppIcon.settingIcon,
              onTap: () => context.pop(),
            ),

            Notice()
          ],
        ),
      ),
    );
  }
}
