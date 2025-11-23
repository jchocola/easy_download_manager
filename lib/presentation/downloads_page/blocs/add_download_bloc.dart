// ignore_for_file: camel_case_types

import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:easy_download_manager/core/enum/download_method.dart';

///
/// EVENT
///
abstract class AddDownloadBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDownloadBlocEvent_Init extends AddDownloadBlocEvent {}

class AddDownloadBlocEvent_ChangeDownloadUrl extends AddDownloadBlocEvent {
  final String value;
  AddDownloadBlocEvent_ChangeDownloadUrl({required this.value});

  @override
  List<Object?> get props => [value];
}

///
/// STATE
///
abstract class AddDownloadBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDownloadBlocStateInitial extends AddDownloadBlocState {}

class AddDownloadBlocStateLoading extends AddDownloadBlocState {}

class AddDownloadBlocStateLoaded extends AddDownloadBlocState {
  final String downloadUrl;
  final DOWNLOAD_METHOD downloadMethod;
  final String fileName;
  final String savePath;

  AddDownloadBlocStateLoaded({
    required this.downloadUrl,
    required this.downloadMethod,
    required this.fileName,
    required this.savePath,
  });

  @override
  List<Object?> get props => [downloadUrl];

  AddDownloadBlocStateLoaded copyWith({
    String? downloadUrl,
    DOWNLOAD_METHOD? downloadMethod,
    String? fileName,
    String? savePath,
  }) {
    return AddDownloadBlocStateLoaded(
      downloadUrl: downloadUrl ?? this.downloadUrl,
      downloadMethod: downloadMethod ?? this.downloadMethod,
      fileName: fileName ?? this.fileName,
      savePath: savePath ?? this.savePath,
    );
  }
}

class AddDownloadBlocStateSucces extends AddDownloadBlocState {}

class AddDownloadBlocStateError extends AddDownloadBlocState {}

///
/// BLOC
///
class AddDownloadBloc extends Bloc<AddDownloadBlocEvent, AddDownloadBlocState> {
  AddDownloadBloc() : super(AddDownloadBlocStateInitial()) {
    ///
    /// INIT
    ///

    on<AddDownloadBlocEvent_Init>((event, emit) {
      logger.i('ADD DOWNLOAD BLOC - INIT');
      emit(
        AddDownloadBlocStateLoaded(
          downloadUrl: '',
          downloadMethod: DOWNLOAD_METHOD.HTTP_HTTPS,
          fileName: '',
          savePath: '/saving',
        ),
      );
    });

    ///
    /// DOWNLOAD URL CHANGING
    ///
    on<AddDownloadBlocEvent_ChangeDownloadUrl>((event, emit) {
      final currentState = state;

      if (currentState is AddDownloadBlocStateLoaded) {
        logger.i('ADD DOWNLOAD BLOC - CHANGE DOWNLOAD URL ${event.value}');
        emit(currentState.copyWith(downloadUrl: event.value));
      }
    });
  }
}
