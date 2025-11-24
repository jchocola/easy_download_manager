import 'package:easy_download_manager/core/constant/app_constant.dart';
import 'package:easy_download_manager/l10n/app_localizations.dart';
import 'package:easy_download_manager/presentation/settings_page/blocs/download_settings_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultDirectoryCard extends StatelessWidget {
  const DefaultDirectoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<DownloadSettingsCubit, DownloadSettingsState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(AppConstant.containerPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstant.borderRadius),
            color: theme.colorScheme.onPrimary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppConstant.containerPadding,
            children: [
              Text(
                l10n.saveFolder,
                style: theme.textTheme.titleMedium,
              ),
              Text(
                state.defaultDirectory ?? AppConstant.pathDefault,
                style: theme.textTheme.bodySmall,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: () => _pickDirectory(context),
                  icon: const Icon(Icons.folder_open),
                  label: Text(l10n.changeFolder),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDirectory(BuildContext context) async {
    final path = await FilePicker.platform.getDirectoryPath();
    if (!context.mounted || path == null) return;
    await context.read<DownloadSettingsCubit>().updateDefaultDirectory(path);
  }
}

