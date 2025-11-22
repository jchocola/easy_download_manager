import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/active_downloads_list.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/completed_downloads_list.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/others_downloads_list.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/sort_modal_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActiveCompletedAll extends StatefulWidget {
  const ActiveCompletedAll({super.key});

  @override
  State<ActiveCompletedAll> createState() => _ActiveCompletedAllState();
}

class _ActiveCompletedAllState extends State<ActiveCompletedAll> {
  String currentIndex = 'actived';

  void changeIndex(String value) {
    setState(() {
      currentIndex = value;
    });
  }

  void onSortTapped() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      showDragHandle: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: SortModalPage(),
      ),
    );
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

            IconButton(onPressed: onSortTapped, icon: Icon(AppIcon.sortIcon)),
          ],
        ),

        buildContent(context),
      ],
    );
  }

  Widget buildContent(context) {
    switch (currentIndex) {
      case 'actived':
        return ActiveDownloadsList();
      case 'completed':
        return CompletedDownloadsList();
      case 'others':
        return OthersDownloadsList();

      default:
        return Text('Error');
    }
  }
}
