import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/4_status_category.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/active_completed_all.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/add_download.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppAppBar(
          title: l10n.downloads,
          showActions: true,
          actionIcon: AppIcon.historyIcon,
          onActionTapped: () => context.push('/downloads/history'),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [FourStatusCategory(), AddDownload(), ActiveCompletedAll()],
        ),
      ),
    );
  }
}
