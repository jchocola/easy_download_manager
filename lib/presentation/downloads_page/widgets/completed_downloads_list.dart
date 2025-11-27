import 'package:easy_download_manager/core/enum/download_card_status.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/complete_tasks_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/picked_task_bloc.dart';
import 'package:easy_download_manager/widget/download_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CompletedDownloadsList extends StatelessWidget {
  const CompletedDownloadsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteTasksBloc, CompleteTasksBlocState>(
      builder: (context, state) {
        if (state is CompleteTasksBlocState_loaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.completedTasks.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return DownloadCard(
                task: state.completedTasks[index],
                status: DOWNLOAD_CARD_STATUS.COMPLETE,
                onTap: () {
                  context.read<PickedTaskBloc>().add(
                    PickedTaskBlocEvent_pickTask(
                      task: state.completedTasks[index],
                    ),
                  );
                  context.push('/downloads/download_detail_page');
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
