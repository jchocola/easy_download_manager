import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/torrents_page/widgets/all_active_comple_torrent.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:flutter/material.dart';

class TorrentsPage extends StatelessWidget {
  const TorrentsPage({super.key});

  @override
  Widget build(BuildContext context) {
     final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppAppBar(title: l10n.torrents),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),

      child: SingleChildScrollView(
        child: Column(
          spacing: AppConstant.containerPadding,
          children: [ActiveCompletedAllTorrent()],
        ),
      ),
    );
  }
}
