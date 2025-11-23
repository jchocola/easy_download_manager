import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddDownload extends StatefulWidget {
  const AddDownload({super.key});

  @override
  State<AddDownload> createState() => _AddDownloadState();
}

class _AddDownloadState extends State<AddDownload> {
  final urlController = TextEditingController();

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(AppConstant.containerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.addDownload, style: theme.textTheme.titleMedium),
          SizedBox(height: AppConstant.containerPadding),
          Row(
            children: [
              Flexible(
                child: Input(
                  hintText: l10n.insertUrl,
                  controller: urlController,
                  onChanged: (value) {
                    context.read<AddDownloadBloc>().add(
                      AddDownloadBlocEvent_ChangeDownloadUrl(value: value),
                    );
                  },
                ),
              ),
              SizedBox(width: AppConstant.containerPadding),
              FloatingActionButton(
                onPressed: () {
                  context.push('/downloads/add_download');
                },
                child: Icon(AppIcon.addIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
