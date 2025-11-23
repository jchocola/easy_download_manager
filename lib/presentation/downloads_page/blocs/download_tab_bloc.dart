// ignore_for_file: camel_case_types

import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
abstract class DownloadTabBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DownloadTabBlocEvent_SetInitValue extends DownloadTabBlocEvent {
  DownloadTabBlocEvent_SetInitValue();
}

class DownloadTabBlocEvent_ChangeValue extends DownloadTabBlocEvent {
  final String value;
  DownloadTabBlocEvent_ChangeValue({required this.value});

  @override
  List<Object?> get props => [value];
}

///
/// STATE
///
abstract class DownloadTabBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DownloadTabBlocStateInitial extends DownloadTabBlocState {}

class DownloadTabBlocStateLoading extends DownloadTabBlocState {}

class DownloadTabBlocStateLoaded extends DownloadTabBlocState {
  final String value;
  DownloadTabBlocStateLoaded({required this.value});

  @override
  List<Object?> get props => [value];
}

class DownloadTabBlocStateError extends DownloadTabBlocState {
  @override
  List<Object?> get props => [];
}

///
///  DOWNLOAD TAB BLOC
///
class DownloadTabBloc extends Bloc<DownloadTabBlocEvent, DownloadTabBlocState> {
  DownloadTabBloc() : super(DownloadTabBlocStateInitial()) {
    ///
    /// SET INIT VALUE
    ///
    on<DownloadTabBlocEvent_SetInitValue>((event, emit) {
      logger.i('💩 INIT DOWNLOAD TAB - actived');
      emit(DownloadTabBlocStateLoaded(value: AppConstant.downloadTab_actived));
    });

    ///
    /// CHANGE VALUE
    ///
    on<DownloadTabBlocEvent_ChangeValue>((event, emit) {
      logger.i('♻ DOWNLOAD TAB CHANGED - ${event.value}');
      emit(DownloadTabBlocStateLoaded(value: event.value));
    });
  }
}
