// ignore_for_file: camel_case_types

import 'package:dtorrent_parser/dtorrent_parser.dart';
import 'package:easy_download_manager/data/repository/flutter_torrent_downloader_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// EVENT
///
abstract class TorrentFileParserBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TorrentFileParserBlocEvent_setTorrentFile
    extends TorrentFileParserBlocEvent {
  final String torrentFilePath;

  TorrentFileParserBlocEvent_setTorrentFile({required this.torrentFilePath});

  @override
  List<Object?> get props => [torrentFilePath];
}

///
/// STATE
///
abstract class TorrentFileParserBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TorrentFileParserBlocState_inittial extends TorrentFileParserBlocState {}

class TorrentFileParserBlocState_loaded extends TorrentFileParserBlocState {
  final Torrent torrent;
  TorrentFileParserBlocState_loaded({required this.torrent});
  @override
  List<Object?> get props => [torrent];
}

class TorrentFileParserBlocState_error extends TorrentFileParserBlocState {
  final String error;
  TorrentFileParserBlocState_error({required this.error});

  @override
  List<Object?> get props => [error];
}



////
/// BLOC , 
///
///
class TorrentFileParserBloc
    extends Bloc<TorrentFileParserBlocEvent, TorrentFileParserBlocState> {
  final FlutterTorrentDownloaderImpl torrentRepo;

  TorrentFileParserBloc({required this.torrentRepo})
    : super(TorrentFileParserBlocState_inittial()) {
    on<TorrentFileParserBlocEvent_setTorrentFile>((event, emit) async {
      try {
        final torrent = await torrentRepo.createTorrentModel(
          torrentFilePath: event.torrentFilePath,
        );
        emit(TorrentFileParserBlocState_loaded(torrent: torrent));
      } catch (e) {
        emit(TorrentFileParserBlocState_error(error: e.toString()));
      }
    });
  }
}
