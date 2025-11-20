import 'package:easy_download_manager/core/enum/download_card_status.dart';
import 'package:easy_download_manager/widget/download_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OthersDownloadsList extends StatelessWidget {
  const OthersDownloadsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildPausedList(context), _buildErrorList(context)],
    );
  }

  Widget _buildPausedList(context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return DownloadCard(
          status: DOWNLOAD_CARD_STATUS.PAUSED,
          onTap: () => context.push('/downloads/download_detail_page'),
        );
      },
    );
  }

  Widget _buildErrorList(context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return DownloadCard(status: DOWNLOAD_CARD_STATUS.ERROR);
      },
    );
  }
}
