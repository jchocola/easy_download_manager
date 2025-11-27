import 'dart:io';

import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/utils/custom_toastification.dart';
import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/main.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/picked_task_bloc.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:easy_download_manager/widget/big_button_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class OpenShareDelete extends StatelessWidget {
  const OpenShareDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickedTaskBloc, PickedTaskBlocState>(
      builder: (context, state) {
        if (state is PickedTaskBlocState_loaded) {
          void deleteTapped() {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Delete file'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("""Подтверждение удаления файла\n
      1. Файл будет удален из базы данных приложения\n
      2. Файл будет удален из локального хранилища устройства\n
      3. Все связанные метаданные будут удалены\n
      """),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        context.pop();
                        context.pop();

                        // trying delete file
                        final fullpath =
                            state.task.savedDir + '/' + state.task.filename!;

                        final File file = File(fullpath);
                        logger.i(fullpath);
                        if (await file.exists()) {
                          await file.delete().then((value) {
                            showSuccessToastification(success: 'File deleted');
                          });
                          logger.i('Deleted file');
                        } else {
                          showErrorToastification(error: 'File not exists');
                        }

                        // delete from app ui

                        FlutterDownloaderRepositoryImpl.instance.removeTask(
                          taskId: state.task.taskId,
                        );
                      },
                      child: Text('Confirm'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          }

          void shareTapped() async {
            final fullpath = state.task.savedDir + '/' + state.task.filename!;

            final File file = File(fullpath);
            logger.i(fullpath);
            if (await file.exists()) {
             await SharePlus.instance.share(ShareParams(
                files: [XFile(fullpath)]
              ));
            } else {
              showErrorToastification(error: 'File not exists');
            }
          }

          return Column(
            spacing: AppConstant.containerPadding,
            children: [
              BigButton(
                icon: AppIcon.folderIcon,
                title: 'Open file',
                onTap: () => FlutterDownloaderRepositoryImpl.instance
                    .openFile(taskId: state.task.taskId)
                    .then((value) {
                      if (!value)
                        showErrorToastification(error: 'Cannot open file');
                    }),
              ),
              BigButton(icon: AppIcon.shareIcon, title: 'Share' , onTap: shareTapped,),
              BigButtonDelete(
                icon: AppIcon.deleteIcon,
                title: 'Delete',
                onTap: deleteTapped,
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
