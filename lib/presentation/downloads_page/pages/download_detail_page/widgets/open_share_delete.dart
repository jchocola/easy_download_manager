import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/core/utils/custom_toastification.dart';
import 'package:easy_download_manager/data/repository/flutter_downloader_repository_impl.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/picked_task_bloc.dart';
import 'package:easy_download_manager/widget/big_button.dart';
import 'package:easy_download_manager/widget/big_button_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class OpenShareDelete extends StatelessWidget {
  const OpenShareDelete({super.key});

  @override
  Widget build(BuildContext context) {
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
              TextButton(onPressed: () {}, child: Text('Confirm')),
              ElevatedButton(onPressed: () {}, child: Text('Cancel')),
            ],
          );
        },
      );
    }

    return BlocBuilder<PickedTaskBloc, PickedTaskBlocState>(
      builder: (context, state) {
        if (state is PickedTaskBlocState_loaded) {
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
              BigButton(icon: AppIcon.shareIcon, title: 'Share'),
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
