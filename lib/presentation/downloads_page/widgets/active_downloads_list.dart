import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/download_list_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/widgets/downloads_empty_state.dart';
import 'package:easy_download_manager/widget/download_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveDownloadsList extends StatelessWidget {
  const ActiveDownloadsList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<DownloadListBloc, DownloadListState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final tasks = state.active;
        if (tasks.isEmpty) {
          return DownloadsEmptyState(message: l10n.noActiveDownloads);
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return DownloadCard(
              task: task,
              onPause: () => context
                  .read<DownloadListBloc>()
                  .add(DownloadListPauseRequested(taskId: task.id)),
              onCancel: () => context
                  .read<DownloadListBloc>()
                  .add(DownloadListCancelRequested(taskId: task.id)),
            );
          },
        );
      },
    );
  }
}
