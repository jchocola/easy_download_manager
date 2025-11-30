// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:dtorrent_parser/dtorrent_parser.dart';
import 'package:dtorrent_task/dtorrent_task.dart';
import 'package:easy_download_manager/core/enum/download_status.dart';
import 'package:easy_download_manager/core/enum/save_place.dart';
import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/data/repository/flutter_torrent_downloader_impl.dart';
import 'package:easy_download_manager/domain/models/download_task.dart';
import 'package:easy_download_manager/flutter_foreground_task.dart';
import 'package:easy_download_manager/main.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:easy_download_manager/core/enum/download_method.dart';
import 'package:path_provider/path_provider.dart';

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

class AddDownloadBlocEvent_StartDownload extends AddDownloadBlocEvent {
  final String? notificationTitle;
  final String? notificationContent;
  AddDownloadBlocEvent_StartDownload({this.notificationTitle, this.notificationContent});
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
  final SAVE_PLACE savePlace;
  final Torrent? torrent;

  AddDownloadBlocStateLoaded({
    required this.downloadUrl,
    required this.downloadMethod,
    required this.fileName,
    required this.savePath,
    this.torrentFile,
    required this.savePlace,
    this.torrent,
  });

  @override
  List<Object?> get props => [
    downloadUrl,
    downloadMethod,
    fileName,
    savePath,
    torrentFile,
    savePlace,
    torrent,
  ];

  AddDownloadBlocStateLoaded copyWith({
    String? downloadUrl,
    DOWNLOAD_METHOD? downloadMethod,
    String? fileName,
    String? savePath,
    File? torrentFile,
    SAVE_PLACE? savePlace,
    Torrent? torrent,
  }) {
    return AddDownloadBlocStateLoaded(
      downloadUrl: downloadUrl ?? this.downloadUrl,
      downloadMethod: downloadMethod ?? this.downloadMethod,
      fileName: fileName ?? this.fileName,
      savePath: savePath ?? this.savePath,
      torrentFile: torrentFile ?? this.torrentFile,
      savePlace: savePlace ?? this.savePlace,
      torrent: torrent ?? this.torrent,
    );
  }
}

class AddDownloadBlocStateSuccess extends AddDownloadBlocState {
  final String success;
  AddDownloadBlocStateSuccess({required this.success});
  @override
  List<Object?> get props => [success];
}

class AddDownloadBlocStateError extends AddDownloadBlocState {
  final String error;
  AddDownloadBlocStateError({required this.error});

  @override
  List<Object?> get props => [error];
}

///
/// BLOC
///
class AddDownloadBloc extends Bloc<AddDownloadBlocEvent, AddDownloadBlocState> {
  final FlutterDownloaderRepositoryImpl flutterDownloader;
  final FlutterTorrentDownloaderImpl torrentDownloader;
  AddDownloadBloc({
    required this.flutterDownloader,
    required this.torrentDownloader,
  }) : super(AddDownloadBlocStateInitial()) {
    ///
    /// INIT
    ///

    on<AddDownloadBlocEvent_Init>((event, emit) async {
      logger.i('ADD DOWNLOAD BLOC - INIT');
      final savePath = await getFullSavingPath(place: SAVE_PLACE.DOWNLOADS);
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

            final torrent = await torrentDownloader.createTorrentModel(
              torrentFilePath: file.path,
            );
            emit(currentState.copyWith(torrentFile: file, torrent: torrent));
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
        emit(currentState.copyWith(torrentFile: null, torrent: null));
      }
    });

    ///
    /// CHANGE SAVE PLACE
    ///
    on<AddDownloadBlocEvent_ChangeSavePlace>((event, emit) async {
      final currentState = state;
      if (currentState is AddDownloadBlocStateLoaded) {
        logger.i('ADD DOWNLOAD BLOC - CHANGE SAVE PLACE ');
        final savePath = await getFullSavingPath(place: event.savePlace);
        logger.i(savePath);
        emit(
          currentState.copyWith(savePlace: event.savePlace, savePath: savePath),
        );
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
    ///  START DOWN LOAD
    ///
    on<AddDownloadBlocEvent_StartDownload>((event, emit) async {
      // get currentState
      final currentState = state;

      if (currentState is AddDownloadBlocStateLoaded) {
        ///
        /// HTTP/HTTPS
        ///

        if (currentState.downloadMethod == DOWNLOAD_METHOD.HTTP_HTTPS) {
          // downloadtask model
          final DownloadTask downloadTaskModel = DownloadTask(
            id: '',
            url: currentState.downloadUrl,
            fileName: currentState.fileName,
            directory: currentState.savePath,
            method: currentState.downloadMethod,
            status: DOWNLOAD_STATUS.QUEUED,
            downloadedBytes: 0,
            totalBytes: 0,
            speedBytesPerSecond: 0,
            isResumable: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          try {
            await flutterDownloader.createNewTask(task: downloadTaskModel).then(
              (value) {
                emit(AddDownloadBlocStateSuccess(success: 'Start Downloading'));
              },
            );
          } catch (e) {
            emit(AddDownloadBlocStateError(error: e.toString()));
            emit(currentState);
          }
        }

        ///
        /// TORRENT
        ///
        if (currentState.downloadMethod == DOWNLOAD_METHOD.TORRENT) {
          // final torrent = currentState.torrent;

          try {
            // final TorrentTask torrentTask = await torrentDownloader
            //     .createTorrentTask(
            //       model: torrent!,
            //       saveDir: currentState.savePath,
            //     );

            // logger.i('Created torrent task' + torrentTask.name);

            // // torrentTask.start();

            // final listener = torrentTask.createListener();

            // // Обрабатываем события торрент задачи
            // listener.on<TaskCompleted>((event) {
            //   // Используем Bloc для эмитации события завершения
            //   // Это можно сделать через дополнительное событие или сохраняя ссылку на задачу
            //   logger.i('Torrent download completed: ${torrentTask.name}');
            // });

            // listener.on<TaskStarted>((event) {
            //   logger.e('Torrent download started ${torrentTask.name}');
            // });

            // listener.on<StateFileUpdated>((event) {
            //   // Можно отправлять обновления прогресса
            //   logger.v('Torrent progress updated: ${torrentTask.progress}');
            // });

            // listener.on<TaskStopped>((event) {
            //   // Можно отправлять обновления прогресса
            //   logger.v('Torrent Stopped: ${torrentTask.progress}');
            // });

            ///
            /// START FOREGROUND SERVICE
            ///
            if (event.notificationTitle != null &&
                event.notificationContent != null) {
                await startService(notificationTitle: event.notificationTitle!, notificationText: event.notificationContent! );
            } else {
                await startService();
            }
          

            ///
            /// PASS DATA TO START DOWNLOAD
            ///
            await sendDataFromUI(
              torrentFilePath: currentState.torrentFile!.path,
              saveDir: currentState.savePath
            );

            emit(AddDownloadBlocStateSuccess(success: 'Start Downloading'));
            add(AddDownloadBlocEvent_Init());
          } catch (e) {
            emit(AddDownloadBlocStateError(error: e.toString()));
            emit(currentState);
          }
        }
      }
    });
  }
}
