import 'dart:math';

import 'package:dtorrent_parser/dtorrent_parser.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/di/DI.dart';
import 'package:easy_download_manager/data/repository/flutter_torrent_downloader_impl.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/torrent_file_parser_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TorrentFileInfo extends StatelessWidget {
  const TorrentFileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TorrentFileParserBloc>(
      create: (context) => TorrentFileParserBloc(
        torrentRepo: getIt<FlutterTorrentDownloaderImpl>(),
        parentBloc: BlocProvider.of<AddDownloadBloc>(context),
      ),
      child: BlocBuilder<AddDownloadBloc, AddDownloadBlocState>(
        builder: (context, state) {
          if (state is AddDownloadBlocStateLoaded) {
            return BlocBuilder<
              TorrentFileParserBloc,
              TorrentFileParserBlocState
            >(
              builder: (context, torrentFileParserState) {
                if (torrentFileParserState
                    is TorrentFileParserBlocState_loaded) {
                  return TorrentInfoWidget(
                    torrent: torrentFileParserState.torrent,
                  );
                } else {
                  return SizedBox();
                }
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class TorrentInfoWidget extends StatelessWidget {
  const TorrentInfoWidget({super.key, required this.torrent});
  final Torrent torrent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      //margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(AppConstant.containerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            _buildSectionTitle(context, title: l10n.torrentInformation),
            SizedBox(height: AppConstant.containerPadding),

            // Основная информация
            _buildInfoRow(l10n.title, torrent.name),
            _buildInfoRow(l10n.hash, _formatHash(torrent.infoHash)),
            _buildInfoRow(l10n.totalSize, _formatBytes(torrent.length)),
            _buildInfoRow(l10n.numberOfFiles, '${torrent.files.length}'),
            _buildInfoRow(l10n.pieceSize, _formatBytes(torrent.pieceLength)),
            _buildInfoRow(l10n.numberOfPieces, '${torrent.pieces.length}'),

            if (torrent.private != null)
              _buildInfoRow(l10n.private, torrent.private! ? 'Yes' : 'No'),

            if (torrent.comment != null && torrent.comment!.isNotEmpty)
              _buildInfoRow(l10n.comment, torrent.comment!),

            if (torrent.createdBy != null && torrent.createdBy!.isNotEmpty)
              _buildInfoRow(l10n.createdBy, torrent.createdBy!),

            if (torrent.creationDate != null)
              _buildInfoRow(
                l10n.creationDate,
                _formatDate(torrent.creationDate!),
              ),

            if (torrent.encoding != null && torrent.encoding!.isNotEmpty)
              _buildInfoRow(l10n.encoding, torrent.encoding!),

            SizedBox(height: 16),

            // Трекеры
            if (torrent.announces.isNotEmpty) _buildTrackersSection(context),

            SizedBox(height: 8),

            // URL списки
            if (torrent.urlList.isNotEmpty) _buildUrlListSection(context),

            SizedBox(height: 8),

            // Файлы
            _buildFilesSection(context),

            SizedBox(height: 8),

            // DHT узлы
            if (torrent.nodes.isNotEmpty) _buildNodesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, {required String title}) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildTrackersSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          context,
          title: 'Trackers (${torrent.announces.length})',
        ),
        SizedBox(height: 8),
        ...torrent.announces
            .take(5)
            .map(
              (tracker) => Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '• ${tracker.toString()}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        if (torrent.announces.length > 5)
          Text(
            '... and ${torrent.announces.length - 5} more',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }

  Widget _buildUrlListSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          context,
          title: 'URL lists (${torrent.urlList.length})',
        ),
        SizedBox(height: 8),
        ...torrent.urlList
            .take(3)
            .map(
              (url) => Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '• ${url.toString()}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        if (torrent.urlList.length > 3)
          Text(
            '... and ${torrent.urlList.length - 3} more',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }

  Widget _buildFilesSection(BuildContext context) {
    final totalSize = torrent.files.fold<int>(
      0,
      (sum, file) => sum + file.length,
    );

  final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, title: 'Files (${torrent.files.length})'),
        SizedBox(height: 8),
        Container(
          constraints: BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: torrent.files.length,
            itemBuilder: (context, index) {
              final file = torrent.files[index];
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  _getFileIcon(file.name),
                  size: 20,
                  color: Colors.grey[600],
                ),
                title: Text(
                  file.name,
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  _formatBytes(file.length),
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              );
            },
          ),
        ),
        Divider(),
        _buildInfoRow(l10n.totalFileSize, _formatBytes(totalSize)),
      ],
    );
  }

  Widget _buildNodesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          context,
          title: 'DHT nodes (${torrent.nodes.length})',
        ),
        SizedBox(height: 8),
        ...torrent.nodes
            .take(3)
            .map(
              (node) => Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '• ${node.toString()}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        if (torrent.nodes.length > 3)
          Text(
            '... and ${torrent.nodes.length - 3} more',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }

  IconData _getFileIcon(String filename) {
    final ext = filename.toLowerCase().split('.').last;

    if (['mp4', 'avi', 'mkv', 'mov', 'wmv'].contains(ext)) {
      return Icons.video_file;
    } else if (['mp3', 'wav', 'flac', 'aac'].contains(ext)) {
      return Icons.audio_file;
    } else if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext)) {
      return Icons.image;
    } else if (['pdf', 'doc', 'docx', 'txt'].contains(ext)) {
      return Icons.description;
    } else if (['zip', 'rar', '7z', 'tar'].contains(ext)) {
      return Icons.archive;
    } else {
      return Icons.insert_drive_file;
    }
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  String _formatHash(String hash) {
    if (hash.length <= 12) return hash;
    return '${hash.substring(0, 6)}...${hash.substring(hash.length - 6)}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
