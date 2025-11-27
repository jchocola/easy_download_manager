import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

///
/// EVENT
///
abstract class PickedTaskBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedTaskBlocEvent_pickTask extends PickedTaskBlocEvent {
  final DownloadTask task;

  PickedTaskBlocEvent_pickTask({required this.task});

  @override
  List<Object?> get props => [task];
}

///
/// STATE
///
abstract class PickedTaskBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedTaskBlocState_inittial extends PickedTaskBlocState {}

class PickedTaskBlocState_loading extends PickedTaskBlocState {}

class PickedTaskBlocState_loaded extends PickedTaskBlocState {
  final DownloadTask task;

  PickedTaskBlocState_loaded({required this.task});

  @override
  List<Object?> get props => [task];
}

///
/// BLOC
///
class PickedTaskBloc extends Bloc<PickedTaskBlocEvent, PickedTaskBlocState> {
  PickedTaskBloc() : super(PickedTaskBlocState_inittial()) {
    on<PickedTaskBlocEvent_pickTask>((event, emit) {
      logger.i('Picked task ${event.task.taskId}');
      emit(PickedTaskBlocState_loaded(task: event.task));
    });
  }
}
