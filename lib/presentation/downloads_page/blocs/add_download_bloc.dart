// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
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

class AddDownloadBlocEvent_ChangeDownloadMethod extends AddDownloadBlocEvent {
  final DOWNLOAD_METHOD method;
  AddDownloadBlocEvent_ChangeDownloadMethod({required this.method});

  @override
  List<Object?> get props => [method];
}

class AddDownloadBlocEvent_PickTorrentFile extends AddDownloadBlocEvent {
  AddDownloadBlocEvent_PickTorrentFile();

  @override
  List<Object?> get props => [];
}

class AddDownloadBlocEvent_RemoveTorrentFile extends AddDownloadBlocEvent {
  AddDownloadBlocEvent_RemoveTorrentFile();

  @override
  List<Object?> get props => [];
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
  final File? torrentFile;

  AddDownloadBlocStateLoaded({
    required this.downloadUrl,
    required this.downloadMethod,
    required this.fileName,
    required this.savePath,
    this.torrentFile,
  });

  @override
  List<Object?> get props => [
    downloadUrl,
    downloadMethod,
    fileName,
    savePath,
    torrentFile,
  ];

  AddDownloadBlocStateLoaded copyWith({
    String? downloadUrl,
    DOWNLOAD_METHOD? downloadMethod,
    String? fileName,
    String? savePath,
    File? torrentFile,
  }) {
    return AddDownloadBlocStateLoaded(
      downloadUrl: downloadUrl ?? this.downloadUrl,
      downloadMethod: downloadMethod ?? this.downloadMethod,
      fileName: fileName ?? this.fileName,
      savePath: savePath ?? this.savePath,
      torrentFile: torrentFile ,
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

    ///
    /// CHANGE DOWNLOAD METHOD
    ///
    on<AddDownloadBlocEvent_ChangeDownloadMethod>((event, emit) {
      final currentState = state;

      if (currentState is AddDownloadBlocStateLoaded) {
        logger.i('ADD DOWNLOAD BLOC - CHANGE DOWNLOAD METHOD ${event.method}');
        emit(currentState.copyWith(downloadMethod: event.method));
      }
    });

    ///
    /// PICK TORRENT FILE
    ///
    on<AddDownloadBlocEvent_PickTorrentFile>((event, emit) async {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowedExtensions: ['torrent'],
          allowMultiple: false,
          type: FileType.custom,
        );
        if (result != null) {
          File file = File(result.files.single.path!);

          final currentState = state;
          if (currentState is AddDownloadBlocStateLoaded) {
            logger.i('ADD DOWNLOAD BLOC - PICK TORRENT FILE ');
            emit(currentState.copyWith(torrentFile: file));
          }
        } else {
          // User canceled the picker
        }
      } catch (e) {
        logger.e(e.toString());
      }
    });

    ///
    /// REMOVE TORRENT FILE
    ///
    on<AddDownloadBlocEvent_RemoveTorrentFile>((event, emit) {
       final currentState = state;
          if (currentState is AddDownloadBlocStateLoaded) {
            logger.i('ADD DOWNLOAD BLOC - REMOVE TORRENT FILE ');
            emit(currentState.copyWith(torrentFile: null));
          }
    });
  }
}
