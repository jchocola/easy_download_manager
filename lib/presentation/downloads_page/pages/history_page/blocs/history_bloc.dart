import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

///
/// event
///
abstract class HistoryBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryBlocEvent_load extends HistoryBlocEvent {}

class HistoryBlocEvent_reload extends HistoryBlocEvent {}

///
/// state
///
abstract class HistoryBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryBlocState_loaded extends HistoryBlocState {
  final List<DownloadTask> allTasks;

  HistoryBlocState_loaded({required this.allTasks});

  @override
  List<Object?> get props => [allTasks];
}

///
/// bloc
///
class HistoryBloc extends Bloc<HistoryBlocEvent, HistoryBlocState> {
  final FlutterDownloaderRepositoryImpl fl_dl;

  HistoryBloc({required this.fl_dl})
    : super(HistoryBlocState_loaded(allTasks: [])) {
    on<HistoryBlocEvent_load>((event, emit) async {
      final allTask = await fl_dl.getAllTasks();

      Future.delayed((Duration(seconds: 5)), () {
        add(HistoryBlocEvent_reload());
      });
      emit(HistoryBlocState_loaded(allTasks: allTask));
    });

    on<HistoryBlocEvent_reload>((event, emit) async {
      final allTask = await fl_dl.getAllTasks();

       Future.delayed((Duration(seconds: 5)), () {
        add(HistoryBlocEvent_load());
      });
      emit(HistoryBlocState_loaded(allTasks: allTask));
    });
  }
}
