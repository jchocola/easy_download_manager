import 'dart:io';
import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/utils/custom_toastification.dart';
import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/main.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/picked_task_bloc.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:easy_download_manager/widget/big_button_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class OpenShareDelete extends StatelessWidget {
  const OpenShareDelete({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return BlocBuilder<PickedTaskBloc, PickedTaskBlocState>(
      builder: (context, state) {
        if (state is PickedTaskBlocState_loaded) {
          void deleteTapped() {
            showDialog(
              useRootNavigator: true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    l10n.deleteFile,
                    style: theme.textTheme.titleMedium,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Confirm file deletion\n1. The file will be deleted from the application database\n2. The file will be deleted from the device's local storage\n3. All associated metadata will be deleted\n",
                        style: theme.textTheme.bodyMedium,
                      ),
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
                            showSuccessToastification(
                              success: l10n.fileDeleted,
                            );
                          });
                          logger.i('Deleted file');
                        } else {
                          showErrorToastification(error: l10n.fileNotExists);
                        }

                        // delete from app ui

                        FlutterDownloaderRepositoryImpl.instance.removeTask(
                          taskId: state.task.taskId,
                        );
                      },
                      child: Text(l10n.confirm),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(l10n.cancel),
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
              await Share.shareXFiles([XFile(fullpath)]);
            } else {
              showErrorToastification(error: l10n.fileNotExists);
            }
          }

          return Column(
            spacing: AppConstant.containerPadding,
            children: [
              BigButton(
                icon: AppIcon.folderIcon,
                title: l10n.openFile,
                onTap: () => FlutterDownloaderRepositoryImpl.instance
                    .openFile(taskId: state.task.taskId)
                    .then((value) {
                      if (!value)
                        showErrorToastification(
                          error: l10n.cannotOpenFileMaybeFileNotExists,
                        );
                    }),
              ),
              BigButton(
                icon: AppIcon.shareIcon,
                title: l10n.share,
                onTap: shareTapped,
              ),
              BigButtonDelete(
                icon: AppIcon.deleteIcon,
                title: l10n.delete,
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
