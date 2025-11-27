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
  final List<fl_dl.DownloadTask> otherTasks;

  OtherTasksBlocState_loaded({required this.otherTasks});

  @override
  List<Object?> get props => [otherTasks];
}

///
/// BLOC
///
class OtherTasksBloc extends Bloc<OtherTasksBlocEvent, OtherTasksBlocState> {
  final FlutterDownloaderRepositoryImpl flutter_downloader;
  OtherTasksBloc({required this.flutter_downloader})
    : super(OtherTasksBlocState_loaded(otherTasks: [])) {
    on<OtherTaskBlocEvent_load>((event, emit) async {
      final list = await flutter_downloader.getOtherTasks();
      Future.delayed(Duration(seconds: 10), () {
        add(OtherTaskBlocEvent_reload());
      });

      logger.i('OtherTaskBlocEvent_load : ${list.length}');
      emit(OtherTasksBlocState_loaded(otherTasks: list));
    });

    on<OtherTaskBlocEvent_reload>((event, emit) async {
      final list = await flutter_downloader.getOtherTasks();
      Future.delayed(Duration(seconds: 10), () {
        add(OtherTaskBlocEvent_load());
      });
      logger.i('OtherTaskBlocEvent_reload : ${list.length}');
      emit(OtherTasksBlocState_loaded(otherTasks: list));
    });
  }
}
