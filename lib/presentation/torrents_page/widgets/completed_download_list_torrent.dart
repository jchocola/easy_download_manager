import 'package:easy_download_manager/presentation/torrents_page/blocs/torrent_task_bloc.dart';
import 'package:easy_download_manager/widget/torrent_download.card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedDownloadsListTorrent extends StatelessWidget {
  const CompletedDownloadsListTorrent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TorrentTaskBloc, TorrentTaskBlocState>(
      builder: (context, state) {
        if (state is TorrentTaskBlocState_loaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.completedTaskList.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TorrentDownloadCard(
                task: state.completedTaskList[index],
                onTap: () {
                 
                },
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