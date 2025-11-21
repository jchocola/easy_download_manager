import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/widget/download_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActiveDownloadsListTorrent extends StatelessWidget {
  const ActiveDownloadsListTorrent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          //spacing: AppConstant.containerPadding,
          children: [
            DownloadCard(
              onTap: () => context.push('/downloads/download_detail_page'),
            ),

            Row(
              spacing: AppConstant.containerPadding * 2,
              children: [
                _customButton(icon: AppIcon.peersIcon, title: '32 peers'),
                _customButton(icon: AppIcon.seedIcon, title: '5 seeds'),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _customButton extends StatelessWidget {
  const _customButton({
    super.key,
    this.icon = Icons.do_disturb,
    this.title = 'Title',
  });
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppConstant.containerPadding / 2,
      children: [
        Icon(icon, color: theme.colorScheme.secondary, size: 14),
        Text(title, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
