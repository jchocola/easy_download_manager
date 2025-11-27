// ignore_for_file: camel_case_types

import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/main.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ActiveDownloadingTasksEvent {}

class ActiveDownloadingTasksEvent_Load extends ActiveDownloadingTasksEvent {}

class ActiveDownloadingTasksEvent_Refresh extends ActiveDownloadingTasksEvent {}

class ActiveDownloadingTasksEvent_PauseTask
    extends ActiveDownloadingTasksEvent {
  final DownloadTask task;
  ActiveDownloadingTasksEvent_PauseTask({required this.task});
}

class ActiveDownloadingTasksEvent_CancelTask
    extends ActiveDownloadingTasksEvent {
  final DownloadTask task;
  ActiveDownloadingTasksEvent_CancelTask({required this.task});
}

// States
abstract class ActiveDownloadingTasksState {}

class ActiveDownloadingTasksState_Loading extends ActiveDownloadingTasksState {}

class ActiveDownloadingTasksState_Loaded extends ActiveDownloadingTasksState {
  final List<DownloadTask> tasks;

  ActiveDownloadingTasksState_Loaded({required this.tasks});
}

class ActiveDownloadingTasksState_Error extends ActiveDownloadingTasksState {
  final String message;

  ActiveDownloadingTasksState_Error({required this.message});
}

// BLoC
class ActiveDownloadingTasksBloc
    extends Bloc<ActiveDownloadingTasksEvent, ActiveDownloadingTasksState> {
  final FlutterDownloaderRepositoryImpl _repository =
      FlutterDownloaderRepositoryImpl.instance;

  ActiveDownloadingTasksBloc() : super(ActiveDownloadingTasksState_Loading()) {
    on<ActiveDownloadingTasksEvent_Load>(_onLoad);
    on<ActiveDownloadingTasksEvent_Refresh>(_onRefresh);
    on<ActiveDownloadingTasksEvent_PauseTask>((event, emit) async {
      try {
        await _repository.pauseTask(taskId: event.task.taskId);
        logger.i('Paused task ${event.task.taskId}');
      } catch (e) {
        rethrow;
      }
    });

    on<ActiveDownloadingTasksEvent_CancelTask>((event, emit) async {
      try {
        await _repository.cancelTask(taskId: event.task.taskId);
         logger.i('Canceled task ${event.task.taskId}');
      } catch (e) {
        rethrow;
      }
    });
  }

  void _onLoad(
    ActiveDownloadingTasksEvent_Load event,
    Emitter<ActiveDownloadingTasksState> emit,
  ) async {
    emit(ActiveDownloadingTasksState_Loading());
    try {
      final tasks = await _repository.getAllDownloadingTasks();
      // Filter only active tasks (not completed, failed, or canceled)
      final activeTasks = tasks.where((task) {
        return task.status == DownloadTaskStatus.enqueued ||
            task.status == DownloadTaskStatus.running ||
            task.status == DownloadTaskStatus.paused;
      }).toList();

      Future.delayed((Duration(seconds: 1)), () {
        add(ActiveDownloadingTasksEvent_Refresh());
      });
      emit(ActiveDownloadingTasksState_Loaded(tasks: activeTasks));
    } catch (e) {
      emit(
        ActiveDownloadingTasksState_Error(
          message: 'Failed to load active downloads: $e',
        ),
      );
    }
  }

  void _onRefresh(
    ActiveDownloadingTasksEvent_Refresh event,
    Emitter<ActiveDownloadingTasksState> emit,
  ) async {
    try {
      final tasks = await _repository.getAllDownloadingTasks();
      // Filter only active tasks (not completed, failed, or canceled)
      final activeTasks = tasks.where((task) {
        // return task.status == DownloadTaskStatus.complete;
        return task.status == DownloadTaskStatus.enqueued ||
            task.status == DownloadTaskStatus.running ||
            task.status == DownloadTaskStatus.paused;
      }).toList();

      Future.delayed((Duration(seconds: 1)), () {
        add(ActiveDownloadingTasksEvent_Refresh());
      });
      emit(ActiveDownloadingTasksState_Loaded(tasks: activeTasks));
    } catch (e) {
      emit(
        ActiveDownloadingTasksState_Error(
          message: 'Failed to refresh active downloads: $e',
        ),
      );
    }
  }
}
