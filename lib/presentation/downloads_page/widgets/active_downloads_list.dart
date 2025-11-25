import 'package:easy_download_manager/presentation/downloads_page/blocs/active_downloading_tasks_bloc.dart';
import 'package:easy_download_manager/widget/downloading_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActiveDownloadsList extends StatelessWidget {
  const ActiveDownloadsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActiveDownloadingTasksBloc()
        ..add(ActiveDownloadingTasksEvent_Load()),
      child: BlocBuilder<ActiveDownloadingTasksBloc, ActiveDownloadingTasksState>(
        builder: (context, state) {
          if (state is ActiveDownloadingTasksState_Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ActiveDownloadingTasksState_Loaded) {
            if (state.tasks.isEmpty) {
              return Center(
                child: Text('No active downloads'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.tasks.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return DownloadingCard(
                  task: task,
                  onTap: () => context.push('/downloads/download_detail_page'),
                );
              },
            );
          } else if (state is ActiveDownloadingTasksState_Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ActiveDownloadingTasksBloc>()
                          .add(ActiveDownloadingTasksEvent_Refresh());
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return Container(); // Fallback
        },
      ),
    );
  }
}