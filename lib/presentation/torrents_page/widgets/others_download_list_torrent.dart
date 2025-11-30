import 'package:easy_download_manager/presentation/torrents_page/blocs/torrent_task_bloc.dart';
import 'package:easy_download_manager/widget/empty_card.dart';
import 'package:easy_download_manager/widget/torrent_download.card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OthersDownloadsListTorrent extends StatelessWidget {
  const OthersDownloadsListTorrent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TorrentTaskBloc, TorrentTaskBlocState>(
      builder: (context, state) {
        if (state is TorrentTaskBlocState_loaded) {

           if (state.othersTaskList.isEmpty) {
            return Center(
              child: EmptyCard(),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.othersTaskList.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TorrentDownloadCard(
                task: state.othersTaskList[index],
                onTap: () {
                 
                },
                onCancelTapped: () => context.read<TorrentTaskBloc>().add(TorrentTaskBlocEvent_cancelTask(id: state.othersTaskList[index].id)),
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