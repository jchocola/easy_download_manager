// ignore_for_file: non_constant_identifier_names

import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///

abstract class F4StatisticBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class F4StatisticBlocEvent_Load extends F4StatisticBlocEvent {}

class F4StatisticBlocEvent_Reload extends F4StatisticBlocEvent {}

///
/// STATE
///

abstract class F4StatisticBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class F4StatisticBlocState_Loaded extends F4StatisticBlocState {
  final int activeTasks;
  final int completeTasks;
  final int errorTasks;
  final int pausedTasks;
  F4StatisticBlocState_Loaded({
    required this.activeTasks,
    required this.completeTasks,
    required this.errorTasks,
    required this.pausedTasks,
  });

  @override
  List<Object?> get props => [
    activeTasks,
    completeTasks,
    errorTasks,
    pausedTasks,
  ];
}

class F4StatisticBlocState_Error extends F4StatisticBlocState {
  final String error;
  F4StatisticBlocState_Error({required this.error});

  @override
  List<Object?> get props => [error];
}

///
/// BLOC
///

class F4StatisticBloc extends Bloc<F4StatisticBlocEvent, F4StatisticBlocState> {
  final FlutterDownloaderRepositoryImpl flutter_dl;

  F4StatisticBloc({required this.flutter_dl})
    : super(
        F4StatisticBlocState_Loaded(
          activeTasks: 0,
          completeTasks: 0,
          errorTasks: 0,
          pausedTasks: 0,
        ),
      ) {
    on<F4StatisticBlocEvent_Load>((event, emit) async {
      {
        try {
          final completeTask = await flutter_dl.getCompleteTasksCount();
          final activeTask = await flutter_dl.getActiveTasksCount();
          final errorTask = await flutter_dl.getErrorTasksCount();
          final pausedTask = await flutter_dl.getPausedTasksCount();

          logger.i('LOAD :$completeTask , $activeTask $errorTask $pausedTask');

          Future.delayed(Duration(seconds: 2), () {
            add(F4StatisticBlocEvent_Reload());
          });
          emit(
            F4StatisticBlocState_Loaded(
              activeTasks: activeTask,
              completeTasks: completeTask,
              errorTasks: errorTask,
              pausedTasks: pausedTask,
            ),
          );
        } catch (e) {}
      }
    });

    on<F4StatisticBlocEvent_Reload>((event, emit) async {
      {
        try {
          final completeTask = await flutter_dl.getCompleteTasksCount();
          final activeTask = await flutter_dl.getActiveTasksCount();
          final errorTask = await flutter_dl.getErrorTasksCount();
          final pausedTask = await flutter_dl.getPausedTasksCount();

            logger.i('RELOAD :$completeTask , $activeTask $errorTask $pausedTask');

          Future.delayed(Duration(seconds: 2), () {
            add(F4StatisticBlocEvent_Load());
          });
          emit(
            F4StatisticBlocState_Loaded(
              activeTasks: activeTask,
              completeTasks: completeTask,
              errorTasks: errorTask,
              pausedTasks: pausedTask,
            ),
          );
        } catch (e) {}
      }
    });
  }
}
