import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/torrents_page/widgets/active_download_list_torrent.dart';
import 'package:easy_download_manager/presentation/torrents_page/widgets/completed_download_list_torrent.dart';
import 'package:easy_download_manager/presentation/torrents_page/widgets/others_download_list_torrent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveCompletedAllTorrent extends StatefulWidget {
  const ActiveCompletedAllTorrent({super.key});

  @override
  State<ActiveCompletedAllTorrent> createState() => _ActiveCompletedAllTorrentState();
}

class _ActiveCompletedAllTorrentState extends State<ActiveCompletedAllTorrent> {
  String currentIndex = 'actived';

  void changeIndex(String value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
     final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoSlidingSegmentedControl(
              backgroundColor: theme.colorScheme.onPrimary,
              thumbColor: theme.colorScheme.onPrimaryContainer,
              groupValue: currentIndex,
              children: {
                'actived': Text(l10n.active),
                'completed': Text(l10n.completed),
                'others': Text(l10n.others),
                // 'error': Text('Error'),
                //'all': Text('All'),
              },
              onValueChanged: (value) {
                changeIndex(value!);
              },
            ),

            IconButton(onPressed: () {}, icon: Icon(AppIcon.sortIcon)),
          ],
        ),

        buildContent(context),
      ],
    );
  }

  Widget buildContent(context) {
    switch (currentIndex) {
      case 'actived':
        return ActiveDownloadsListTorrent();
      case 'completed':
        return CompletedDownloadsListTorrent();
      case 'others':
        return OthersDownloadsListTorrent();

      default:
        return Text('Error');
    }
  }
}
