import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/presentation/torrents_page/blocs/torrent_task_bloc.dart';
import 'package:easy_download_manager/widget/download_card.dart';
import 'package:easy_download_manager/widget/empty_card.dart';
import 'package:easy_download_manager/widget/torrent_download.card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActiveDownloadsListTorrent extends StatelessWidget {
  const ActiveDownloadsListTorrent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TorrentTaskBloc, TorrentTaskBlocState>(
      builder: (context, state) {
        if (state is TorrentTaskBlocState_loaded) {
          if (state.runningTaskList.isEmpty) {
            return Center(
              child: EmptyCard(),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.runningTaskList.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TorrentDownloadCard(
                task: state.runningTaskList[index],
                onTap: () {},
                onCancelTapped: () => context.read<TorrentTaskBloc>().add(
                  TorrentTaskBlocEvent_cancelTask(
                    id: state.runningTaskList[index].id,
                  ),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
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
