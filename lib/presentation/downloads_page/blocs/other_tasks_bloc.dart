// ignore_for_file: non_constant_identifier_names

import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart' as fl_dl;

///
/// EVENT
///
abstract class OtherTasksBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtherTaskBlocEvent_load extends OtherTasksBlocEvent {}

class OtherTaskBlocEvent_reload extends OtherTasksBlocEvent {}

///
/// STATE
///
abstract class OtherTasksBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtherTasksBlocState_loaded extends OtherTasksBlocState {
  final List<fl_dl.DownloadTask> pausedTasks;
    final List<fl_dl.DownloadTask> failedTasks;

  OtherTasksBlocState_loaded({required this.pausedTasks , required this.failedTasks});

  @override
  List<Object?> get props => [pausedTasks , failedTasks];
}

///
/// BLOC
///
class OtherTasksBloc extends Bloc<OtherTasksBlocEvent, OtherTasksBlocState> {
  final FlutterDownloaderRepositoryImpl flutter_downloader;
  OtherTasksBloc({required this.flutter_downloader})
    : super(OtherTasksBlocState_loaded(pausedTasks: [], failedTasks: [])) {
    on<OtherTaskBlocEvent_load>((event, emit) async {
      final paused = await flutter_downloader.getPausedTasks();
        final failed = await flutter_downloader.getFailedTasks();
      Future.delayed(Duration(seconds: 3), () {
        add(OtherTaskBlocEvent_reload());
      });

      logger.i('OtherTaskBlocEvent_load : ${paused.length}');
      emit(OtherTasksBlocState_loaded(pausedTasks: paused , failedTasks: failed));
    });

    on<OtherTaskBlocEvent_reload>((event, emit) async {
    final paused = await flutter_downloader.getPausedTasks();
        final failed = await flutter_downloader.getFailedTasks();
      Future.delayed(Duration(seconds: 3), () {
        add(OtherTaskBlocEvent_load());
      });
      logger.i('OtherTaskBlocEvent_reload : ${paused.length}');
      emit(OtherTasksBlocState_loaded(pausedTasks: paused, failedTasks: failed));
    });
  }
}
