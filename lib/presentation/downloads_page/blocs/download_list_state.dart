part of 'download_list_bloc.dart';

enum DownloadListStatus { initial, loading, success, failure }

class DownloadListState extends Equatable {
  const DownloadListState({
    this.status = DownloadListStatus.initial,
    this.tasks = const [],
    this.errorMessage,
  });

  final DownloadListStatus status;
  final List<DownloadTask> tasks;
  final String? errorMessage;

  bool get isLoading => status == DownloadListStatus.loading;

  List<DownloadTask> get active => tasks
      .where(
        (task) =>
            task.status == DownloadStatus.DOWNLOADING ||
            task.status == DownloadStatus.QUEUED,
      )
      .toList();

  List<DownloadTask> get completed => tasks
      .where((task) => task.status == DownloadStatus.COMPLETED)
      .toList();

  List<DownloadTask> get others => tasks
      .where(
        (task) =>
            task.status == DownloadStatus.PAUSED ||
            task.status == DownloadStatus.FAILED ||
            task.status == DownloadStatus.CANCELED,
      )
      .toList();

  DownloadListState copyWith({
    DownloadListStatus? status,
    List<DownloadTask>? tasks,
    String? errorMessage,
    bool resetError = false,
  }) {
    return DownloadListState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: resetError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, tasks, errorMessage];
}

