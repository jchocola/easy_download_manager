import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/appbar.dart';
import 'package:easy_download_manager/widget/history_card.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
     final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppAppBar(title: l10n.downloadHistory, showLeading: true),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.containerPadding,
        children: [HistoryCard()],
      ),
    );
  }
}
