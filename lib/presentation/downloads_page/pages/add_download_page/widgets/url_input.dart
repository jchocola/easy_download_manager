import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/core/constant/app_icon.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/downloads_page/blocs/add_download_bloc.dart';
import 'package:easy_download_manager/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrlInput extends StatefulWidget {
  const UrlInput({super.key});

  @override
  State<UrlInput> createState() => _UrlInputState();
}

class _UrlInputState extends State<UrlInput> {
  late final TextEditingController urlController;

  @override
  void initState() {
    urlController = TextEditingController();
    super.initState();
  }

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
        borderRadius: BorderRadius.circular(AppConstant.borderRadius),
        color: theme.colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: AppConstant.containerPadding,
            children: [
              Icon(
                AppIcon.urlIcon,
                color: theme.colorScheme.secondaryContainer,
              ),
              Text(l10n.urlDownloads, style: theme.textTheme.titleMedium),
            ],
          ),

          Text(
            l10n.enterTheLinkToTheFileForDownload,
            style: theme.textTheme.bodySmall,
          ),

          SizedBox(height: AppConstant.containerPadding * 2),

          Text(l10n.url, style: theme.textTheme.titleSmall),

          BlocBuilder<AddDownloadBloc, AddDownloadBlocState>(
            builder: (context, state) {
              if (state is AddDownloadBlocStateLoaded) {
                urlController.text = state.downloadUrl;
                return Input(
                  hintText: AppConstant.urlHintText,
                  controller: urlController,
                  onChanged: (value) => context.read<AddDownloadBloc>().add(
                    AddDownloadBlocEvent_ChangeDownloadUrl(value: value),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
