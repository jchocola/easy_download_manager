import 'package:easy_download_manager/widget/download_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActiveDownloadsList extends StatelessWidget {
  const ActiveDownloadsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return DownloadCard(
          onTap: () => context.push('/downloads/download_detail_page'),
        );
      },
    );
  }
}
