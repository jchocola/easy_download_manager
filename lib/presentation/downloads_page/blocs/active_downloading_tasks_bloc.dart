import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ActiveDownloadingTasksEvent {}

class ActiveDownloadingTasksEvent_Load extends ActiveDownloadingTasksEvent {}

class ActiveDownloadingTasksEvent_Refresh extends ActiveDownloadingTasksEvent {}

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
