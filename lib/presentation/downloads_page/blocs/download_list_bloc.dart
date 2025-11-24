import 'dart:async';

import 'package:easy_download_manager/core/enum/download_status.dart';
import 'package:easy_download_manager/core/models/download_task.dart';
import 'package:easy_download_manager/core/providers/download_repository.dart';
import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'download_list_event.dart';
part 'download_list_state.dart';

class DownloadListBloc extends Bloc<DownloadListEvent, DownloadListState> {
  DownloadListBloc({required DownloadRepository repository})
      : _repository = repository,
        super(const DownloadListState()) {
    on<DownloadListSubscriptionRequested>(_onSubscriptionRequested);
    on<DownloadListPauseRequested>(_onPauseRequested);
    on<DownloadListResumeRequested>(_onResumeRequested);
    on<DownloadListCancelRequested>(_onCancelRequested);
    on<DownloadListDeleteRequested>(_onDeleteRequested);

    add(const DownloadListSubscriptionRequested());
  }

  final DownloadRepository _repository;

  Future<void> _onSubscriptionRequested(
    DownloadListSubscriptionRequested event,
    Emitter<DownloadListState> emit,
  ) async {
    emit(state.copyWith(status: DownloadListStatus.loading));
    await emit.forEach<List<DownloadTask>>(
      _taskStream(),
      onData: (tasks) => state.copyWith(
        status: DownloadListStatus.success,
        tasks: tasks,
        resetError: true,
      ),
      onError: (error, stackTrace) {
        logger.e('Download stream failed', error: error, stackTrace: stackTrace);
        return state.copyWith(
          status: DownloadListStatus.failure,
          errorMessage: error.toString(),
        );
      },
    );
  }

  Future<void> _onPauseRequested(
    DownloadListPauseRequested event,
    Emitter<DownloadListState> emit,
  ) async {
    await _repository.pauseTask(event.taskId);
  }

  Future<void> _onResumeRequested(
    DownloadListResumeRequested event,
    Emitter<DownloadListState> emit,
  ) async {
    await _repository.resumeTask(event.taskId);
  }

  Future<void> _onCancelRequested(
    DownloadListCancelRequested event,
    Emitter<DownloadListState> emit,
  ) async {
    await _repository.cancelTask(event.taskId);
  }

  Future<void> _onDeleteRequested(
    DownloadListDeleteRequested event,
    Emitter<DownloadListState> emit,
  ) async {
    await _repository.deleteTask(event.taskId);
  }

  Stream<List<DownloadTask>> _taskStream() {
    return Stream.multi((controller) {
      controller.add(_repository.currentTasks);
      final subscription = _repository.watchTasks().listen(
        controller.add,
        onError: controller.addError,
      );
      controller.onCancel = () {
        subscription.cancel();
      };
    });
  }
}

