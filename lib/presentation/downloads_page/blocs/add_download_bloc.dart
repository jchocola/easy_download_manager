// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:easy_download_manager/core/enum/save_place.dart';
import 'package:easy_download_manager/core/providers/download_repository.dart';
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

class AddDownloadBlocEvent_ChangeSavePlace extends AddDownloadBlocEvent {
  final SAVE_PLACE savePlace;
  AddDownloadBlocEvent_ChangeSavePlace({required this.savePlace});

  @override
  List<Object?> get props => [savePlace];
}


class AddDownloadBlocEvent_ChangeFileName extends AddDownloadBlocEvent {
  final String value;
  AddDownloadBlocEvent_ChangeFileName({required this.value});

  @override
  List<Object?> get props => [value];
}

class AddDownloadBlocEvent_Submit extends AddDownloadBlocEvent {}

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
  final SAVE_PLACE savePlace;

  AddDownloadBlocStateLoaded({
    required this.downloadUrl,
    required this.downloadMethod,
    required this.fileName,
    required this.savePath,
    this.torrentFile,
    required this.savePlace,
  });

  @override
  List<Object?> get props => [
    downloadUrl,
    downloadMethod,
    fileName,
    savePath,
    torrentFile,
    savePlace,
  ];

  AddDownloadBlocStateLoaded copyWith({
    String? downloadUrl,
    DOWNLOAD_METHOD? downloadMethod,
    String? fileName,
    String? savePath,
    File? torrentFile,
    SAVE_PLACE? savePlace,
  }) {
    return AddDownloadBlocStateLoaded(
      downloadUrl: downloadUrl ?? this.downloadUrl,
      downloadMethod: downloadMethod ?? this.downloadMethod,
      fileName: fileName ?? this.fileName,
      savePath: savePath ?? this.savePath,
      torrentFile: torrentFile ?? this.torrentFile,
      savePlace: savePlace ?? this.savePlace,
    );
  }
}

class AddDownloadBlocStateSucces extends AddDownloadBlocState {}

class AddDownloadBlocStateError extends AddDownloadBlocState {}

///
/// BLOC
///
class AddDownloadBloc extends Bloc<AddDownloadBlocEvent, AddDownloadBlocState> {
  AddDownloadBloc({required DownloadRepository downloadRepository})
      : _downloadRepository = downloadRepository,
        super(AddDownloadBlocStateInitial()) {
    ///
    /// INIT
    ///

    on<AddDownloadBlocEvent_Init>((event, emit) async {
      logger.i('ADD DOWNLOAD BLOC - INIT');
      final defaultPath = _downloadRepository.defaultDirectory;
      final savePath =
          defaultPath ?? await getFullSavingPath(place: SAVE_PLACE.DOWNLOADS);
      emit(
        AddDownloadBlocStateLoaded(
          downloadUrl: '',
          downloadMethod: DOWNLOAD_METHOD.HTTP_HTTPS,
          fileName: '',
          savePlace: SAVE_PLACE.DOWNLOADS, // default
          savePath: savePath, // default
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
        final shouldAutofillName = currentState.fileName.isEmpty;
        emit(
          currentState.copyWith(
            downloadUrl: event.value,
            fileName: shouldAutofillName
                ? _inferFileName(event.value)
                : currentState.fileName,
          ),
        );
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

    ///
    /// CHANGE SAVE PLACE
    ///
    on<AddDownloadBlocEvent_ChangeSavePlace>((event, emit) async{
      final currentState = state;
      if (currentState is AddDownloadBlocStateLoaded) {
        logger.i('ADD DOWNLOAD BLOC - CHANGE SAVE PLACE ');
        final savePath = await getFullSavingPath(place: event.savePlace);
        await _downloadRepository.setDefaultDirectory(savePath);
        emit(currentState.copyWith(savePlace: event.savePlace, savePath: savePath));
      }
    });


    ///
    /// CHANGE FILE NAME
    ///
      on<AddDownloadBlocEvent_ChangeFileName>((event, emit) {
      final currentState = state;

      if (currentState is AddDownloadBlocStateLoaded) {
        logger.i('ADD DOWNLOAD BLOC - CHANGE FILE NAME ${event.value}');
        emit(currentState.copyWith(fileName: event.value));
      }
    });

    ///
    /// SUBMIT DOWNLOAD
    ///
    on<AddDownloadBlocEvent_Submit>((event, emit) async {
      final currentState = state;
      if (currentState is! AddDownloadBlocStateLoaded) return;

      final url = currentState.downloadUrl.trim();
      if (url.isEmpty) {
        emit(AddDownloadBlocStateError());
        emit(currentState);
        return;
      }

      emit(AddDownloadBlocStateLoading());
      try {
        final fileName = (currentState.fileName.trim().isEmpty)
            ? _inferFileName(url)
            : currentState.fileName.trim();
        await _downloadRepository.enqueueHttpDownload(
          url: url,
          fileName: fileName,
          directory: currentState.savePath,
        );
        emit(AddDownloadBlocStateSucces());
        emit(
          currentState.copyWith(
            downloadUrl: '',
            fileName: '',
          ),
        );
      } catch (error, stackTrace) {
        logger.e(
          'Failed to enqueue download',
          error: error,
          stackTrace: stackTrace,
        );
        emit(AddDownloadBlocStateError());
        emit(currentState);
      }
    });
  }

  final DownloadRepository _downloadRepository;

  String _inferFileName(String url) {
    final uri = Uri.tryParse(url.trim());
    final lastSegment =
        uri != null && uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    if (lastSegment.isNotEmpty && !lastSegment.endsWith('/')) {
      return lastSegment;
    }
    return 'download_${DateTime.now().millisecondsSinceEpoch}';
  }
}
