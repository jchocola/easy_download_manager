// ignore_for_file: non_constant_identifier_names

import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart' as fl_dl;

///
/// EVENT
///
abstract class CompleteTasksBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompleteTaskBlocEvent_load extends CompleteTasksBlocEvent {}

class CompleteTaskBlocEvent_reload extends CompleteTasksBlocEvent {}

///
/// STATE
///
abstract class CompleteTasksBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompleteTasksBlocState_loaded extends CompleteTasksBlocState {
  final List<fl_dl.DownloadTask> completedTasks;

  CompleteTasksBlocState_loaded({required this.completedTasks});

  @override
  List<Object?> get props => [completedTasks];
}

///
/// BLOC
///
class CompleteTasksBloc
    extends Bloc<CompleteTasksBlocEvent, CompleteTasksBlocState> {
  final FlutterDownloaderRepositoryImpl flutter_downloader;
  CompleteTasksBloc({required this.flutter_downloader})
    : super(CompleteTasksBlocState_loaded(completedTasks: [])) {
    on<CompleteTaskBlocEvent_load>((event, emit) async {
      final list = await flutter_downloader.getCompleteTasks();
      Future.delayed(Duration(seconds: 10), () {
        add(CompleteTaskBlocEvent_reload());
      });

      logger.i('CompleteTaskBlocEvent_load : ${list.length}');
      emit(CompleteTasksBlocState_loaded(completedTasks: list));
    });

    on<CompleteTaskBlocEvent_reload>((event, emit) async {
      final list = await flutter_downloader.getCompleteTasks();
      Future.delayed(Duration(seconds: 10), () {
        add(CompleteTaskBlocEvent_load());
      });
      logger.i('CompleteTaskBlocEvent_reload : ${list.length}');
      emit(CompleteTasksBlocState_loaded(completedTasks: list));
    });
  }
}
