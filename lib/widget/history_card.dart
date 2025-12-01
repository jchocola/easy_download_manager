import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/utils/icon_coverter_from_filename.dart';
import 'package:easy_download_manager/core/utils/task_status_color.dart';
import 'package:easy_download_manager/widget/container_with_border_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key , this.task , this.onTap});
  final DownloadTask? task;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppConstant.containerPadding),
        margin: EdgeInsets.only(bottom: AppConstant.containerPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.borderRadius),
          color: theme.colorScheme.onPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: AppConstant.containerPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContainerWithBorderColor(
              icon: IconConverterFromFileName(filename:task?.filename ?? '' ),
              color: TaskStattusColorConverter(task: task!),
            ),
      
            Expanded(
              child: Column(
                spacing: AppConstant.containerPadding,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task?.filename ?? 'Unknown', style: theme.textTheme.titleMedium , maxLines: 1, overflow: TextOverflow.ellipsis,),
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('${task?.progress}%', style: theme.textTheme.bodySmall),
                      Text(
                        '${DateTime.fromMillisecondsSinceEpoch(task!.timeCreated).toString().substring(0,16)}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
      
                  _status(task: task,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _status extends StatelessWidget {
  const _status({super.key , this.task});
    final DownloadTask? task;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.containerPadding / 2,
        horizontal: AppConstant.containerPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color:TaskStattusColorConverter(task: task!).withOpacity(0.1),
      ),
      child: Text(
        task?.status.name ?? '',
        style: theme.textTheme.bodySmall!.copyWith(
          color:TaskStattusColorConverter(task: task!)
        ),
      ),
    );
  }
}
