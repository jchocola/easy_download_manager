import 'dart:math';

import 'package:easy_download_manager/core/constant/app_color.dart';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/enum/download_status.dart';
import 'package:easy_download_manager/core/models/download_task.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/widget/button_with_icon.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DownloadCard extends StatelessWidget {
  const DownloadCard({
    super.key,
    required this.task,
    this.onTap,
    this.onPause,
    this.onResume,
    this.onCancel,
    this.onDelete,
  });

  final DownloadTask task;
  final VoidCallback? onTap;
  final VoidCallback? onPause;
  final VoidCallback? onResume;
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final progressPercent = (task.progress * 100).clamp(0, 100).toInt();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppConstant.containerPadding),
        padding: EdgeInsets.all(AppConstant.containerPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          color: theme.colorScheme.onPrimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContainerWithBorderColor(),
                SizedBox(width: AppConstant.containerPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.fileName,
                        style: theme.textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppConstant.containerPadding / 2),
                      if (_showProgress)
                        Column(
                          spacing: AppConstant.containerPadding / 2,
                          children: [
                            StepProgressIndicator(
                              fallbackLength: size.width * 0.7,
                              totalSteps: 100,
                              currentStep: progressPercent.clamp(0, 100),
                              size: AppConstant.loadingHeight,
                              padding: 0,
                              selectedColor: AppColor.activeProgressColor,
                              unselectedColor: AppColor.inactiveProgressColor,
                              roundedEdges: const Radius.circular(10),
                            ),
                            SizedBox(
                              width: size.width * 0.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$progressPercent%',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Text(
                                    _buildSizeLabel(l10n),
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      if (_showSpeed)
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppConstant.containerPadding / 2,
                          ),
                          child: SizedBox(
                            width: size.width * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatSpeed(l10n),
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                                Text(
                                  _formatEta(l10n),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: AppConstant.containerPadding / 2),
                      Text(
                        _statusLabel(l10n),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: _statusColor(theme),
                        ),
                      ),
                      if (task.error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            task.error!,
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: theme.colorScheme.error),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstant.containerPadding),
            _buildActions(theme, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(ThemeData theme, AppLocalizations l10n) {
    if (task.status == DownloadStatus.DOWNLOADING ||
        task.status == DownloadStatus.QUEUED) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonWithIcon(
            label: l10n.pause,
            icon: AppIcon.pauseIcon,
            color: theme.colorScheme.tertiary,
            onPressed: onPause,
          ),
          ButtonWithIcon(
            label: l10n.cancelDownload,
            icon: AppIcon.cancelIcon,
            color: theme.colorScheme.error,
            onPressed: onCancel,
          ),
        ],
      );
    }

    if (task.status == DownloadStatus.PAUSED ||
        task.status == DownloadStatus.FAILED ||
        task.status == DownloadStatus.CANCELED) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonWithIcon(
            label: task.status == DownloadStatus.PAUSED ? l10n.resume : l10n.retry,
            icon: AppIcon.continueIcon,
            color: theme.colorScheme.tertiary,
            onPressed: onResume,
          ),
          ButtonWithIcon(
            label: l10n.cancel,
            icon: AppIcon.deleteIcon,
            color: theme.colorScheme.error,
            onPressed: onDelete ?? onCancel,
          ),
        ],
      );
    }

    if (task.status == DownloadStatus.COMPLETED) {
      return Align(
        alignment: Alignment.centerRight,
        child: ButtonWithIcon(
          label: l10n.delete,
          icon: AppIcon.deleteIcon,
          color: theme.colorScheme.error,
          onPressed: onDelete,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  bool get _showProgress =>
      task.status == DownloadStatus.DOWNLOADING ||
      task.status == DownloadStatus.QUEUED ||
      task.status == DownloadStatus.PAUSED;

  bool get _showSpeed => task.status == DownloadStatus.DOWNLOADING;

  String _buildSizeLabel(AppLocalizations l10n) {
    if (task.totalBytes == null) {
      return l10n.downloadSizeUnknown;
    }
    return '${_formatBytes(task.downloadedBytes)} / ${_formatBytes(task.totalBytes!)}';
  }

  String _formatSpeed(AppLocalizations l10n) {
    if (task.speedBytesPerSecond <= 0) {
      return l10n.speed;
    }
    return '${_formatBytes(task.speedBytesPerSecond.round())}/s';
  }

  String _formatEta(AppLocalizations l10n) {
    if (task.totalBytes == null || task.speedBytesPerSecond <= 0) {
      return l10n.speed;
    }
    final remaining =
        max(0, task.totalBytes! - task.downloadedBytes).toDouble();
    final seconds = remaining / max(task.speedBytesPerSecond, 1);
    final duration = Duration(seconds: seconds.round());
    if (duration.inMinutes > 0) {
      final minutes = duration.inMinutes;
      final secondsPart = duration.inSeconds % 60;
      return '${minutes}m ${secondsPart}s';
    }
    return '${duration.inSeconds}s';
  }

  String _statusLabel(AppLocalizations l10n) {
    switch (task.status) {
      case DownloadStatus.QUEUED:
        return l10n.queued;
      case DownloadStatus.DOWNLOADING:
        return l10n.active;
      case DownloadStatus.PAUSED:
        return l10n.paused;
      case DownloadStatus.COMPLETED:
        return l10n.completed;
      case DownloadStatus.FAILED:
        return l10n.failed;
      case DownloadStatus.CANCELED:
        return l10n.canceled;
    }
  }

  Color _statusColor(ThemeData theme) {
    switch (task.status) {
      case DownloadStatus.DOWNLOADING:
      case DownloadStatus.QUEUED:
        return theme.colorScheme.primary;
      case DownloadStatus.COMPLETED:
        return theme.colorScheme.secondary;
      case DownloadStatus.PAUSED:
        return theme.colorScheme.tertiary;
      case DownloadStatus.FAILED:
      case DownloadStatus.CANCELED:
        return theme.colorScheme.error;
    }
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (log(bytes) / log(1024)).floor();
    final size = bytes / pow(1024, i);
    return '${size.toStringAsFixed(i == 0 ? 0 : 1)} ${suffixes[i]}';
  }
}
