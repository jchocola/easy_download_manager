part of 'download_list_bloc.dart';

abstract class DownloadListEvent extends Equatable {
  const DownloadListEvent();

  @override
  List<Object?> get props => [];
}

class DownloadListSubscriptionRequested extends DownloadListEvent {
  const DownloadListSubscriptionRequested();
}

class DownloadListPauseRequested extends DownloadListEvent {
  const DownloadListPauseRequested({required this.taskId});
  final String taskId;

  @override
  List<Object?> get props => [taskId];
}

class DownloadListResumeRequested extends DownloadListEvent {
  const DownloadListResumeRequested({required this.taskId});
  final String taskId;

  @override
  List<Object?> get props => [taskId];
}

class DownloadListCancelRequested extends DownloadListEvent {
  const DownloadListCancelRequested({required this.taskId});
  final String taskId;

  @override
  List<Object?> get props => [taskId];
}

class DownloadListDeleteRequested extends DownloadListEvent {
  const DownloadListDeleteRequested({required this.taskId});
  final String taskId;

  @override
  List<Object?> get props => [taskId];
}

