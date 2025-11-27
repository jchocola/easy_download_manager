import 'package:easy_download_manager/core/enum/download_card_status.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/active_downloading_tasks_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/other_tasks_bloc.dart';
import 'package:easy_download_manager/widget/download_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OthersDownloadsList extends StatelessWidget {
  const OthersDownloadsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [_buildOtherList(context)]);
  }

  Widget _buildOtherList(context) {
    return BlocBuilder<OtherTasksBloc, OtherTasksBlocState>(
      builder: (context, state) {
        if (state is OtherTasksBlocState_loaded) {
          final otherTasks = state.pausedTasks + state.failedTasks;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: otherTasks.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return DownloadCard(
                task: otherTasks[index],
                onCancelTapped: () =>
                    context.read<ActiveDownloadingTasksBloc>().add(
                      ActiveDownloadingTasksEvent_CancelTask(
                        task: otherTasks[index],
                      ),
                    ),
                onContinueTapped: () =>
                    context.read<ActiveDownloadingTasksBloc>().add(
                      ActiveDownloadingTasksEvent_ResumeTask(
                        task: otherTasks[index],
                      ),
                    ),
                onTap: () => context.push('/downloads/download_detail_page'),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
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
        return DownloadCard(status: DOWNLOAD_CARD_STATUS.FAILED);
      },
    );
  }
}
