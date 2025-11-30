// ignore_for_file: camel_case_types

import 'package:easy_download_manager/domain/models/torrent_task_model.dart';
import 'package:easy_download_manager/domain/repository/local_torent_db.dart';
import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
abstract class TorrentTaskBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TorrentTaskBlocEvent_load extends TorrentTaskBlocEvent {}

class TorrentTaskBlocEvent_reload extends TorrentTaskBlocEvent {}

///
/// STATE
///
abstract class TorrentTaskBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TorrentTaskBlocState_initial extends TorrentTaskBlocState {}

class TorrentTaskBlocState_loaded extends TorrentTaskBlocState {
  final List<TorrentTaskModel> runningTaskList;
  final List<TorrentTaskModel> completedTaskList;
  final List<TorrentTaskModel> othersTaskList;

  TorrentTaskBlocState_loaded({
    required this.runningTaskList,
    required this.completedTaskList,
    required this.othersTaskList,
  });

  @override
  List<Object?> get props => [
    runningTaskList,
    completedTaskList,
    othersTaskList,
  ];
}

class TorrentTaskBlocState_error extends TorrentTaskBlocState {
  final String error;

  TorrentTaskBlocState_error({required this.error});
  @override
  List<Object?> get props => [error];
}

///
/// BLOC
///
class TorrentTaskBloc extends Bloc<TorrentTaskBlocEvent, TorrentTaskBlocState> {
  final LocalTorrentDB localDb;

  TorrentTaskBloc({required this.localDb})
    : super(
        TorrentTaskBlocState_loaded(
          runningTaskList: [],
          completedTaskList: [],
          othersTaskList: [],
        ),
      ) {
    ///
    /// LOAD
    ///
    on<TorrentTaskBlocEvent_load>((event, emit) async {
      try {
        final runningTask = await localDb.getRunningTorrentTaskList();
        final completedTask = await localDb.getCompletedTorrentTaskList();
        final othersTask = await localDb.getOthersTorrentTaskList();

        logger.i('TorrentTaskBlocEvent_load');
        emit(
          TorrentTaskBlocState_loaded(
            runningTaskList: runningTask,
            completedTaskList: completedTask,
            othersTaskList: othersTask,
          ),
        );

        Future.delayed((Duration(seconds: 5)), () {
          add(TorrentTaskBlocEvent_reload());
        });
      } catch (e) {
        emit(TorrentTaskBlocState_error(error: e.toString()));
        add(TorrentTaskBlocEvent_load());
      }
    });

    ///
    /// RELOAD
    ///
    on<TorrentTaskBlocEvent_reload>((event, emit) async{
        try {
        final runningTask = await localDb.getRunningTorrentTaskList();
        final completedTask = await localDb.getCompletedTorrentTaskList();
        final othersTask = await localDb.getOthersTorrentTaskList();

        logger.i('TorrentTaskBlocEvent_reload');
        emit(
          TorrentTaskBlocState_loaded(
            runningTaskList: runningTask,
            completedTaskList: completedTask,
            othersTaskList: othersTask,
          ),
        );

        Future.delayed((Duration(seconds: 5)), () {
          add(TorrentTaskBlocEvent_load());
        });
      } catch (e) {
        emit(TorrentTaskBlocState_error(error: e.toString()));
        add(TorrentTaskBlocEvent_load());
      }
    });
  }
}
