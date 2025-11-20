import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/action_buttons.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/file_info.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/main_info.dart';
import 'package:easy_download_manager/presentation/downloads_page/pages/download_detail_page/widgets/speed_remain.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:flutter/material.dart';

class DownloadDetailPage extends StatelessWidget {
  const DownloadDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: 'Детали загрузки', showLeading: true),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [
            MainInfo(),
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
}
